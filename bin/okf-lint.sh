#!/usr/bin/env bash
#
# okf-lint.sh — conformance + link linter for the OKF + Karpathy knowledge store.
#
# No external dependencies beyond bash / awk / grep / find / sed.
#
# Modes:
#   (default)   full report, always exits 0
#   --strict    conformance only, exits non-zero on any failure (for git hook / CI)
#
# Advisory checks (default mode only, never affect the exit code):
#   - orphan concepts with no inbound links
#   - agent-instruction files over the context budget (OKF_CONTEXT_BUDGET,
#     default 200 lines) — these are loaded into context, so length is a
#     standing cost on every session
#
# Conformance rules:
#   - every scanned *.md file starts with `---` on line 1 and has a closing `---`
#   - every scanned file has a non-empty `type:` in its frontmatter, EXCEPT
#     index.md, log.md, and the root README.md / CLAUDE.md (meta-docs)
#   - `okf_version:` may appear in frontmatter ONLY in the root index.md
#
# Scanning skips raw/, inbox/, .claude/, .git/ and the root AGENTS.md.

STRICT=0
if [ "${1:-}" = "--strict" ]; then
  STRICT=1
fi

# Always operate from the git repo root so relative links resolve consistently.
ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$ROOT" || exit 2

fail=0
broken=0
orphan_warn=0
budget_warn=0

# Agent-instruction files are loaded into context rather than searched, so their
# length is a running cost on every session. Advisory only.
CONTEXT_BUDGET="${OKF_CONTEXT_BUDGET:-200}"

# Collect scanned markdown files (exclude raw/, .claude/, .git/).
# AGENTS.md is a cross-vendor meta-doc whose spec is plain Markdown, so it is
# excluded from the scan rather than forced to carry OKF frontmatter.
mapfile -t FILES < <(find . -type f -name '*.md' \
  -not -path './raw/*' \
  -not -path './inbox/*' \
  -not -path './.claude/*' \
  -not -path './.git/*' \
  -not -path './AGENTS.md' \
  | sed 's|^\./||' | sort)

# Strip fenced code blocks and inline backtick spans, so illustrative example
# links inside code are never treated as real links.
strip_code() {
  awk '
    /^[[:space:]]*```/ { infence = !infence; next }
    !infence { print }
  ' "$1" | sed 's/`[^`]*`//g'
}

# Files exempt from the `type:` requirement.
is_type_exempt() {
  local f="$1"
  local base="${f##*/}"
  case "$base" in
    index.md|log.md) return 0 ;;
  esac
  case "$f" in
    README.md|CLAUDE.md) return 0 ;;
  esac
  return 1
}

# ---------------------------------------------------------------------------
# 1. Conformance
# ---------------------------------------------------------------------------
echo "== OKF conformance =="
for f in "${FILES[@]}"; do
  first="$(head -n1 "$f")"
  if [ "$first" != "---" ]; then
    echo "FAIL: $f — missing opening frontmatter ('---' on line 1)"
    fail=$((fail + 1))
    continue
  fi

  close="$(awk 'NR>1 && $0=="---" {print NR; exit}' "$f")"
  if [ -z "$close" ]; then
    echo "FAIL: $f — missing closing frontmatter ('---')"
    fail=$((fail + 1))
    continue
  fi

  fm="$(awk -v c="$close" 'NR>1 && NR<c' "$f")"

  if ! is_type_exempt "$f"; then
    if ! printf '%s\n' "$fm" | grep -Eq '^[[:space:]]*type:[[:space:]]*[^[:space:]]'; then
      echo "FAIL: $f — missing non-empty 'type:' in frontmatter"
      fail=$((fail + 1))
    fi
  fi

  if printf '%s\n' "$fm" | grep -Eq '^[[:space:]]*okf_version:'; then
    if [ "$f" != "index.md" ]; then
      echo "FAIL: $f — 'okf_version:' is permitted only in the root index.md"
      fail=$((fail + 1))
    fi
  fi
done
if [ "$fail" -eq 0 ]; then
  echo "OK: all scanned files conform."
fi

# In strict mode we only care about conformance; short-circuit here.
if [ "$STRICT" -eq 1 ]; then
  if [ "$fail" -gt 0 ]; then
    echo "STRICT: FAILED ($fail conformance failure(s))"
    exit 1
  fi
  echo "STRICT: OK"
  exit 0
fi

# ---------------------------------------------------------------------------
# 2. Broken relative *.md links
# ---------------------------------------------------------------------------
echo
echo "== Broken links =="
for f in "${FILES[@]}"; do
  dir="$(dirname "$f")"
  while IFS= read -r target; do
    [ -z "$target" ] && continue
    case "$target" in
      http://*|https://*|mailto:*|\#*) continue ;;
    esac
    # Drop an optional link title and any #anchor.
    t="${target%% *}"
    t="${t%%#*}"
    [ -z "$t" ] && continue
    # Only relative markdown targets are checked.
    case "$t" in
      *.md) ;;
      *) continue ;;
    esac
    if [ "$dir" = "." ]; then
      resolved="$t"
    else
      resolved="$dir/$t"
    fi
    if [ ! -e "$resolved" ]; then
      echo "BROKEN: $f -> $target"
      broken=$((broken + 1))
    fi
  done < <(strip_code "$f" | grep -oE '\]\([^)]+\)' | sed -E 's/^\]\(//; s/\)$//')
done
if [ "$broken" -eq 0 ]; then
  echo "OK: no broken relative markdown links."
fi

# ---------------------------------------------------------------------------
# 3. Orphan concepts (advisory only)
# ---------------------------------------------------------------------------
echo
echo "== Orphans (advisory) =="
LINKS_ALL=""
for f in "${FILES[@]}"; do
  l="$(strip_code "$f" | grep -oE '\]\([^)]+\)' | sed -E 's/^\]\(//; s/\)$//')"
  LINKS_ALL+="$l"$'\n'
done
for f in "${FILES[@]}"; do
  base="${f##*/}"
  case "$base" in
    index.md|log.md|README.md|CLAUDE.md) continue ;;
  esac
  if ! printf '%s\n' "$LINKS_ALL" | grep -qF "$base"; then
    echo "ORPHAN: $f — no inbound markdown links found"
    orphan_warn=$((orphan_warn + 1))
  fi
done
if [ "$orphan_warn" -eq 0 ]; then
  echo "OK: no orphan concepts."
fi

# ---------------------------------------------------------------------------
# 4. Context budget for agent-instruction files (advisory only)
# ---------------------------------------------------------------------------
echo
echo "== Context budget (advisory, ${CONTEXT_BUDGET} lines) =="
while IFS= read -r f; do
  [ -f "$f" ] || continue
  n="$(grep -c '' "$f")"
  if [ "$n" -gt "$CONTEXT_BUDGET" ]; then
    echo "OVER BUDGET: $f — ${n} lines (budget ${CONTEXT_BUDGET})"
    budget_warn=$((budget_warn + 1))
  fi
done < <(
  printf '%s\n' CLAUDE.md AGENTS.md
  find .claude/skills -type f -name 'SKILL.md' 2>/dev/null | sed 's|^\./||' | sort
)
if [ "$budget_warn" -eq 0 ]; then
  echo "OK: all agent-instruction files within budget."
fi

# ---------------------------------------------------------------------------
echo
echo "Summary: ${fail} conformance failure(s), ${broken} broken link(s), ${orphan_warn} orphan warning(s), ${budget_warn} over budget"
exit 0
