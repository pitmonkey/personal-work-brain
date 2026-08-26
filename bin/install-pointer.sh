#!/usr/bin/env bash
#
# install-pointer.sh — wire this store into your Claude setup.
#
# Installs a user-level skill that tells any Claude session where this store is
# and how to use it, and (optionally) adds a two-line pointer to your global
# CLAUDE.md for discoverability.
#
# The skill is the load-bearing part: its description sits in context always,
# but its body loads only when a session is actually about the store — so you
# do not pay for the full instructions in every unrelated session.
#
# Everything is idempotent and marker-delimited, so re-running updates in place
# rather than duplicating. Multiple stores can be installed side by side as long
# as each uses a distinct --label.
#
# Usage:
#   bin/install-pointer.sh [--dry-run] [--label NAME] [--description TEXT]
#                          [--no-claude-md]
#   bin/install-pointer.sh --uninstall [--label NAME]
#
# Environment:
#   CLAUDE_HOME   Claude config directory (default: ~/.claude)

set -euo pipefail

DRY_RUN=0
UNINSTALL=0
LABEL="work-brain"
WITH_CLAUDE_MD=1
DESCRIPTION=""

while [ $# -gt 0 ]; do
  case "$1" in
    --dry-run)      DRY_RUN=1 ;;
    --uninstall)    UNINSTALL=1 ;;
    --no-claude-md) WITH_CLAUDE_MD=0 ;;
    --label)        shift; LABEL="${1:?--label needs a value}" ;;
    --description)  shift; DESCRIPTION="${1:?--description needs a value}" ;;
    -h|--help)      sed -n '3,22p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *)              echo "unknown option: $1" >&2; exit 2 ;;
  esac
  shift
done

case "$LABEL" in
  *[!a-z0-9-]*|"") echo "ERROR: --label must be lowercase letters, digits, hyphens." >&2; exit 2 ;;
esac

ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
CLAUDE_HOME="${CLAUDE_HOME:-$HOME/.claude}"
SKILL_DIR="$CLAUDE_HOME/skills/$LABEL"
SKILL_FILE="$SKILL_DIR/SKILL.md"
GLOBAL_MD="$CLAUDE_HOME/CLAUDE.md"

BEGIN_MARK="<!-- BEGIN claude-brain pointer: $LABEL -->"
END_MARK="<!-- END claude-brain pointer: $LABEL -->"

# The blurb describes THIS store, so take it from the store's own root index.md
# frontmatter rather than assuming. Multiple stores installed side by side each
# get their own accurate description.
if [ -z "$DESCRIPTION" ] && [ -f "$ROOT/index.md" ]; then
  DESCRIPTION="$(awk '
    NR == 1 && $0 == "---" { infm = 1; next }
    infm && $0 == "---" { exit }
    infm && /^description:[[:space:]]*/ {
      sub(/^description:[[:space:]]*/, "")
      gsub(/^["'"'"']|["'"'"']$/, "")
      print; exit
    }
  ' "$ROOT/index.md")"
fi
[ -z "$DESCRIPTION" ] && DESCRIPTION="A private knowledge store."


say() { printf '%s\n' "$*"; }
would() { if [ "$DRY_RUN" -eq 1 ]; then say "  [dry-run] $*"; else say "  $*"; fi; }

# ---------------------------------------------------------------------------
# Uninstall
# ---------------------------------------------------------------------------
if [ "$UNINSTALL" -eq 1 ]; then
  say "Uninstalling pointer '$LABEL'"
  if [ -d "$SKILL_DIR" ]; then
    would "remove skill  $SKILL_DIR"
    [ "$DRY_RUN" -eq 0 ] && rm -rf "$SKILL_DIR"
  else
    say "  skill not installed ($SKILL_DIR)"
  fi
  if [ -f "$GLOBAL_MD" ] && grep -qF "$BEGIN_MARK" "$GLOBAL_MD"; then
    would "strip pointer block from $GLOBAL_MD"
    if [ "$DRY_RUN" -eq 0 ]; then
      awk -v b="$BEGIN_MARK" -v e="$END_MARK" '
        $0 == b { skip = 1; next }
        $0 == e { skip = 0; next }
        !skip
      ' "$GLOBAL_MD" > "$GLOBAL_MD.tmp" && mv "$GLOBAL_MD.tmp" "$GLOBAL_MD"
    fi
  else
    say "  no pointer block in ${GLOBAL_MD}"
  fi
  say "Done."
  exit 0
fi

# ---------------------------------------------------------------------------
# Build the user-level skill
# ---------------------------------------------------------------------------
say "Installing pointer '$LABEL'"
say "  store: $ROOT"
say "  claude home: $CLAUDE_HOME"
say "  description: $DESCRIPTION"
say

SKILL_BODY="$(cat <<EOF
---
name: $LABEL
description: Read and maintain the user's knowledge store "$LABEL" at $ROOT. $DESCRIPTION Use when a question could be answered from knowledge already recorded there, when something learned in this session is worth filing, or when the user mentions this store, their work brain, second brain, or knowledge store.
---

# $LABEL

The user's private work knowledge store lives at:

\`\`\`
$ROOT
\`\`\`

## Before doing anything

Read \`$ROOT/AGENTS.md\`, then \`$ROOT/CLAUDE.md\`. They are the schema and
editorial policy — how concepts are shaped, what may never be recorded, and the
operations that grow the store. Do not write to the store without reading them.

Start browsing at \`$ROOT/index.md\`; it is the progressive-disclosure entry
point. \`$ROOT/log.md\` is the append-only changelog, newest first.

## What it holds

\`decisions/\` (ADRs — why, and what was rejected) · \`systems/\` · \`runbooks/\` ·
\`references/\` · \`people/\` · \`me/\` (the user's own working context — read this
early when drafting anything *for* them) · \`raw/\` (immutable sources).

## Operations

- **Query** — answer from the concept tree first, fall back to \`raw/\` only when
  it is insufficient, and cite what the answer rests on.
- **Ingest** — fold a \`raw/\` source into concepts.
- **Synthesize** — write pages connecting existing concepts, pushing links back.
- **Lint** — run \`$ROOT/bin/okf-lint.sh\`.

The store's own repo carries fuller skills for each; prefer those when working
inside it.

## Non-negotiables

- **The store is private and one-way.** Never paste its contents into an
  external service, ticket, chat, or repo. Nothing at work links back to it.
- **Never record** secrets, credentials, customer or personal data, privileged
  material, or HR and compensation matters — in \`raw/\` or the tree.
- **\`raw/\` is immutable.** Read from it; never edit it.
- **Never invent facts.** Unknowns are written \`TODO:\`.
- **Relative Markdown links only**, never wikilinks.
- Run \`$ROOT/bin/okf-lint.sh\` before committing; resolve every FAIL and BROKEN.
EOF
)"

if [ "$DRY_RUN" -eq 1 ]; then
  say "Would write skill -> $SKILL_FILE"
  say "---8<--- skill ---8<---"
  printf '%s\n' "$SKILL_BODY"
  say "---8<--- end ---8<---"
  say
else
  mkdir -p "$SKILL_DIR"
  printf '%s\n' "$SKILL_BODY" > "$SKILL_FILE"
  say "  wrote skill  $SKILL_FILE"
fi

# ---------------------------------------------------------------------------
# Global CLAUDE.md pointer — deliberately tiny; the skill carries the detail.
# ---------------------------------------------------------------------------
if [ "$WITH_CLAUDE_MD" -eq 1 ]; then
  BLOCK="$BEGIN_MARK
- **$LABEL** — \`$ROOT\`. $DESCRIPTION Invoke the \`$LABEL\` skill before answering from memory on topics it covers, or when something is worth filing. Never copy its contents into an external service.
$END_MARK"

  if [ "$DRY_RUN" -eq 1 ]; then
    say "Would add to $GLOBAL_MD:"
    printf '%s\n' "$BLOCK" | sed 's/^/    /'
    say
  else
    mkdir -p "$CLAUDE_HOME"
    touch "$GLOBAL_MD"
    if grep -qF "$BEGIN_MARK" "$GLOBAL_MD"; then
      awk -v b="$BEGIN_MARK" -v e="$END_MARK" -v repl="$BLOCK" '
        $0 == b { print repl; skip = 1; next }
        $0 == e { skip = 0; next }
        !skip
      ' "$GLOBAL_MD" > "$GLOBAL_MD.tmp" && mv "$GLOBAL_MD.tmp" "$GLOBAL_MD"
      say "  updated pointer block in $GLOBAL_MD"
    else
      printf '\n%s\n' "$BLOCK" >> "$GLOBAL_MD"
      say "  appended pointer block to $GLOBAL_MD"
    fi
  fi
else
  say "  skipped $GLOBAL_MD (--no-claude-md)"
fi

[ "$DRY_RUN" -eq 1 ] && { say "Dry run — nothing was written."; exit 0; }

say
say "Done. Re-running is safe; it updates in place."
say "To remove:  bin/install-pointer.sh --uninstall --label $LABEL"
