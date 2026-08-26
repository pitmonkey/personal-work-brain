---
title: Changelog
description: Append-only log of changes to the knowledge store, newest first.
---

# Log

Append-only. Newest entries first. Each entry is date-prefixed (ISO 8601).

## 2026-08-26 — scaffolded the work brain

Initial scaffold, adapted from a personal OKF + Karpathy knowledge store that had
run for roughly two months. What carried over unchanged: the three-layer
separation (immutable `raw/` / agent-owned concept tree / policy), the OKF file
contract, the relative-link rule, the reserved `index.md` and `log.md`, the four
operations, and the split between `bin/okf-lint.sh` (report, judgement) and
`--strict` (deterministic gate).

What is new for work:

- **[Confidentiality](CLAUDE.md).** An explicit never-capture list — secrets,
  customer/personal data, privileged material, HR and compensation — plus the
  rule that redaction happens *on capture*, because `raw/` is immutable and
  committed, so a secret pasted there is in git history for good.
- **Private-and-one-way.** The store is personal, sharing a page is a
  fork-and-scrub rather than a permission change, and nothing at work links back
  here. This is the work analogue of the source store's rule that project repos
  must never learn the store exists.
- **`decisions/` leads the taxonomy.** Turnover destroys *why* faster than
  anything else, and an ADR is the only artifact that outlives the people who
  made the call.
- **[Point, don't mirror](CLAUDE.md).** Work is full of systems of record, so the
  store keeps the reasoning that would be expensive to lose and links out for
  facts. Pages that do mirror a source carry a *derived snapshot, as of `<date>`*
  banner, and graduate to a pointer once the real home catches up. The source
  store learned this the slow way, over several rewrites of the same page.
- **Five sections, not nine.** `decisions/ systems/ runbooks/ references/
  people/`. In the source store, two of the most-used sections were not in the
  original scaffold at all — they were added when something had nowhere to go.
  *Adding a section* is now a documented operation instead of a guess.
- **Secret scanning in the pre-commit hook.** `bin/install-hooks.sh` runs the
  strict linter and then `gitleaks` or `trufflehog` on the staged diff if either
  is installed, warning when neither is.

`TODO:` decide where this repo lives (work-hosted git vs. personal) — that choice
is what actually enforces the privacy rule, and it has not been made.
