---
name: lint
description: Run bin/okf-lint.sh, then apply editorial judgement on top (stale / orphan / duplicate / missing pages, and expired derived snapshots); auto-apply only mechanical fixes and log the pass.
---

# Lint

Keep the store healthy — mechanical checks plus judgement.

## Steps

1. **Run the linter.** `bin/okf-lint.sh` (full report). It checks: opening/closing frontmatter, a non-empty `type` (except meta-docs), `okf_version` placement, broken relative `.md` links, orphan concepts (advisory), and the context budget on agent-instruction files (advisory, 200 lines).
2. **Read the report.** Resolve every FAIL and BROKEN. Orphan and OVER BUDGET warnings are advisory — decide case by case whether to link an orphan in or remove it, and on an overrun move the _explanation_ into `docs/<topic>.md`, leaving the rule behind with a link to it. `docs/` is read on demand and is not budgeted, which is what makes it the valve. Never cut a rule to hit the budget; raise it with the user instead.
3. **Apply judgement** the linter cannot. Staleness is the failure mode that matters most here: **a page six months stale is worse than no page**, because it gives agents confident but wrong context. Look for:
   - **Stale** — content contradicted by newer sources or reality.
   - **Expired snapshots** — any page carrying a _derived snapshot, as of `<date>`_ banner whose date is old. Re-derive it, or graduate it to a pointer. This is the most common rot in a work store.
   - **Graduation due** — a page whose content the real system of record now carries; shrink it to a pointer plus the reasoning that home does not hold.
   - **Orphan** — a real concept with no inbound links; wire it in or retire it.
   - **Duplicate** — two thin pages that should be merged into one dense one.
   - **Missing** — a page the tree clearly implies but does not yet have.
   - **Stale todos** — open `- [ ]` items with text (ignore an empty checkbox) in `daily/`, `meetings/`, or `todos/`, dated more than 30 days ago — by the note's date, or for `todos/index.md` by the source link on the item. Advisory: list them and ask whether each is still live, done, or dropped; never tick or delete one unasked.
   - **Not rolled up** — only when `me/working-setup.md` has `todo_mode: rollup`: open items in daily notes or meeting pages dated before today. Offer to run the `todos` skill.
   - **Unfilled context** — anything in `me/` still carrying `filled: false`, or a filled page whose role, stack, or priorities have since moved. These are read at the start of every task, so they rot loudest.
   - **Leakage** — anything that reads like a secret, customer data, or an HR matter. Raise it immediately; do not quietly delete, because the file is already in history and the user needs to know.
4. **Auto-apply only mechanical fixes** (fix a broken link, add missing frontmatter, correct `okf_version` placement). Raise everything judgemental with the user before changing it.
5. **Log the pass** — prepend a dated `log.md` entry noting what was checked and changed.

## Guardrails

- Never edit `raw/`.
- Mechanical fixes only without asking; structural/content changes need a nod.
