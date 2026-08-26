---
title: raw/ — immutable source material
description: What belongs in raw/, why it is never edited, and what must be redacted before it lands.
---

# raw/

This directory holds **immutable source material**: meeting notes, thread dumps,
exports, clippings, transcripts, PDFs, images, and other artifacts that concepts
are derived *from*.

- **Not concepts.** Files here are inputs, not knowledge-tree pages. They do not
  need OKF frontmatter.
- **Immutable.** Never edit a raw source in place. If a source changes upstream,
  add a new file alongside the old one.
- **Skipped by the linter.** `bin/okf-lint.sh` excludes `raw/` entirely, so its
  contents are never checked for frontmatter, `type`, or links.

## Who puts things here

**Normally the agent, not you.** Drop sources into [`inbox/`](../inbox/README.md)
— uncommitted — and the ingest step promotes a redacted copy here with an
ISO-date name and a provenance header. Writing into `raw/` yourself means
committing to a file before anything has read it, which is the one thing this
directory's immutability makes expensive to undo.

The exception: a source carrying **nothing sensitive** and already in good shape
— a public article, your own vendor-neutral notes — can go straight into
`clippings/` with an ISO-date prefix. Meetings, exported threads, and anything
involving named people or customers should go through `inbox/`.

## Redact before it lands

Immutability cuts both ways: a file here is committed, and deleting it later does
**not** remove it from git history. Strip secrets, customer and personal data,
privileged material, and HR content **as you write the file** — leave a `TODO:`
marking the redaction rather than the original. See *Confidentiality* in
[../CLAUDE.md](../CLAUDE.md).

## Naming

Prefix every capture with an ISO date and note its source inside the file, so a
snapshot is never mistaken for current truth:

```
raw/clippings/2026-08-26-payments-oncall-handover-notes.md
```

## Layout

- `clippings/` — text sources (notes, threads, transcripts, exports).
- `assets/` — binaries (images, PDFs, archives). Consider Git LFS if these grow.

To turn a raw source into knowledge, ask the agent to **ingest** it — see the
ingest operation in [../CLAUDE.md](../CLAUDE.md).
