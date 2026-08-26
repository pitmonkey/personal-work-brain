---
name: lint
description: Run bin/okf-lint.sh, then apply editorial judgement on top (stale / orphan / duplicate / missing pages, and expired derived snapshots); auto-apply only mechanical fixes and log the pass.
---

# Lint

Keep the store healthy — mechanical checks plus judgement.

## Steps

1. **Run the linter.** `bin/okf-lint.sh` (full report). It checks: opening/closing
   frontmatter, a non-empty `type` (except meta-docs), `okf_version` placement,
   broken relative `.md` links, and orphan concepts (advisory).
2. **Read the report.** Resolve every FAIL and BROKEN. Orphan warnings are
   advisory — decide case by case whether to link the page in or remove it.
3. **Apply judgement** the linter cannot:
   - **Stale** — content contradicted by newer sources or reality.
   - **Expired snapshots** — any page carrying a *derived snapshot, as of
     `<date>`* banner whose date is old. Re-derive it, or graduate it to a
     pointer. This is the most common rot in a work store.
   - **Graduation due** — a page whose content the real system of record now
     carries; shrink it to a pointer plus the reasoning that home does not hold.
   - **Orphan** — a real concept with no inbound links; wire it in or retire it.
   - **Duplicate** — two thin pages that should be merged into one dense one.
   - **Missing** — a page the tree clearly implies but does not yet have.
   - **Leakage** — anything that reads like a secret, customer data, or an HR
     matter. Raise it immediately; do not quietly delete, because the file is
     already in history and the user needs to know.
4. **Auto-apply only mechanical fixes** (fix a broken link, add missing
   frontmatter, correct `okf_version` placement). Raise everything judgemental
   with the user before changing it.
5. **Log the pass** — prepend a dated `log.md` entry noting what was checked and
   changed.

## Guardrails

- Never edit `raw/`.
- Mechanical fixes only without asking; structural/content changes need a nod.
