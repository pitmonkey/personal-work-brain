---
name: okf-validate
description: The narrow, deterministic conformance gate — wraps `bin/okf-lint.sh --strict` for pre-commit hooks and CI. Pass/fail only, no judgement.
---

# okf-validate

A deterministic conformance gate for automation (pre-commit, CI). Unlike the
`lint` skill, it applies **no judgement** — it only runs the strict linter and
reports pass/fail.

## Usage

```
bin/okf-lint.sh --strict
```

- **Strict mode checks conformance only:** every scanned `.md` opens and closes
  frontmatter, carries a non-empty `type` (except `index.md`, `log.md`, and the
  root `README.md` / `CLAUDE.md`), and uses `okf_version` only in the root
  `index.md`.
- **Exit code is the contract:** `0` = conformant, non-zero = at least one
  failure. The pre-commit hook installed by `bin/install-hooks.sh` blocks the
  commit on non-zero.

## When to use

- As the pre-commit hook (installed via `bin/install-hooks.sh`).
- As a CI step gating merges.

Use the full `lint` skill (not this gate) for stale/orphan/duplicate/missing-page
judgement.
