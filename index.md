---
okf_version: "0.1"
title: Work Brain
description: A private, git-backed knowledge store for work — decisions, systems, runbooks, references, and people.
---

# Work Brain

A **private** git-backed knowledge store for work, built on the Open Knowledge
Format file contract and an LLM-maintained wiki loop. This root `index.md` is the
progressive-disclosure entry point: start here and drill into a section.

> **Private and personal.** This store is not a team artifact and nothing at work
> links back to it. Sharing a page means copying it out and scrubbing it, never
> handing over the store. See [CLAUDE.md](CLAUDE.md).

## Sections

- [Decisions](decisions/index.md) — ADR-style records of choices and their consequences.
- [Systems](systems/index.md) — running systems, services, and infrastructure.
- [Runbooks](runbooks/index.md) — operational procedures.
- [References](references/index.md) — external and internal material distilled into concepts.
- [People](people/index.md) — who owns what, who to ask, how teams and vendors operate.
- [Me](me/index.md) — who you are and how you work; the context layer agents read first.

The tree starts deliberately small. New sections are added when something
genuinely has nowhere to live — not in advance. See *Adding a section* in
[CLAUDE.md](CLAUDE.md).

Apart from the decision records describing how the store works, the sections
start empty. [log.md](log.md) records changes from the first ingest onward.

## Raw sources

The [`raw/`](raw/README.md) directory holds **immutable** source material —
clippings, exports, meeting notes, thread dumps, and assets. It is never edited
in place and is skipped by the linter. Concepts are derived *from* raw sources,
not stored there. Redact secrets and personal data **before** a raw file lands.

## Conventions

The schema and editorial policy live in [CLAUDE.md](CLAUDE.md). The append-only
changelog is [log.md](log.md). Run `bin/okf-lint.sh` to check conformance.
