# AGENTS.md

This repository is a **private personal knowledge store** — a "work brain". It is
not a software project: there is nothing to build, test, run, or deploy. The
deliverable is the Markdown itself.

**Read [CLAUDE.md](CLAUDE.md) before writing anything.** It is the schema and
editorial policy — how concepts are shaped, what may never be recorded, and the
four operations that grow the store.

## Orientation

- [`index.md`](index.md) is the entry point. Drill into a section from there.
- [`log.md`](log.md) is the append-only changelog, newest first.
- Sections: `decisions/`, `systems/`, `runbooks/`, `references/`, `people/`, `me/`, `daily/`, `meetings/`. Todos are checkboxes, mostly in `daily/`; read `me/working-setup.md` before touching one.
- [`raw/`](raw/README.md) is immutable source material. Read from it; never edit it.
- [`docs/`](docs/README.md) explains how the store works — capture, agent access,
  and the reasoning behind the rules. Read on demand, not up front.

## The four operations

**Ingest** a `raw/` source into concepts · **Query** the tree and cite sources ·
**Synthesize** pages that connect existing concepts · **Lint** with
`bin/okf-lint.sh`. Full definitions are in [CLAUDE.md](CLAUDE.md).

## Non-negotiables

- **Never record** secrets, credentials, customer or personal data, privileged
  material, or HR and compensation matters — in `raw/` or the tree. Redact
  **before** a file lands; `raw/` is immutable and committed.
- **Never invent facts.** Unknowns are written `TODO:`, never guessed.
- **Never edit `raw/`.** Derive concepts from it instead.
- **Relative Markdown links only** — `[k8s](../systems/k8s.md)` — never wikilinks.
- **Every concept** carries YAML frontmatter with a non-empty `type:`.
- **Nothing at work points back here.** This store is downstream of everything
  and upstream of nothing.

## Before committing

Run `bin/okf-lint.sh` and resolve every FAIL and BROKEN. `bin/install-hooks.sh`
wires the strict gate plus a secret scan into a pre-commit hook.
