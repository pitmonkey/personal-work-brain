---
type: Decision
title: "ADR 0001 — OKF file contract + agent-maintained wiki loop"
description: Adopt a portable Markdown file contract for shape, and an agent-run maintenance loop for growth.
status: active
tags: [adr, okf, knowledge-management, scaffold]
timestamp: 2026-08-26
---

# ADR 0001 — OKF file contract + agent-maintained wiki loop

**Status:** Accepted — 2026-08-26. Inherited from the scaffold.

## Context

A knowledge store that is worth maintaining for years has to be (a) durable and
portable — plain files, git-backed, no lock-in; (b) pleasant to browse and graph
in an editor like Obsidian; and (c) a good working substrate for an LLM agent.

Two separate questions have to be answered, and conflating them is a common
mistake: **how is each file shaped?** and **how does the collection grow without
turning into note sprawl?**

## Options considered

1. **Plain Markdown vault.** Freeform notes and wikilinks. Excellent authoring
   experience, but no file contract — so the bundle is not portable or
   machine-consumable — and no discipline against sprawl.
2. **A file contract only.** Frontmatter, a required `type`, reserved filenames,
   permissive consumption. Portable, but nothing keeps the tree dense and
   coherent as it grows.
3. **A maintenance loop only.** An agent reads sources, discusses takeaways, and
   folds them into concepts. Keeps the tree coherent, but without a file contract
   the bundle is not portable and consumption rules are undefined.
4. **Both.** (Chosen.)

## Decision

Adopt **both**, because they answer different questions.

The **Open Knowledge Format** defines the file shape: Markdown with YAML
frontmatter carrying a non-empty `type`, optional everything else, reserved
`index.md` and `log.md`, `okf_version` only in the root index, and permissive
consumption — flag, never fail.

The **agent-maintained wiki loop** defines how the collection grows: read a
source in full, discuss takeaways before writing, fold them into a small set of
dense cross-linked concepts, flag contradictions rather than overwriting, update
the index, and append to the log.

Links are **relative Markdown links, never wikilinks**. Wikilinks are pleasanter
to type and bind the store to one editor; relative links keep the bundle portable
while an editor still renders the graph.

## Consequences

- The store is a plain folder of Markdown. It survives any tool that reads it, and
  can be handed to any agent without conversion.
- The `type` requirement is mechanically checkable, so `bin/okf-lint.sh` can gate
  commits without any judgement about content.
- Density is a policy, not a mechanism. Nothing stops thin pages except the
  editorial rule and the lint pass; expect to consolidate periodically.
- Permissive consumption means broken links and unknown types are reported, never
  fatal. A store that refuses to load because one link rotted is worse than one
  that tells you which link rotted.

## Related

- [CLAUDE.md](../CLAUDE.md) — the policy this decision produced.
- [ADR 0003](0003-separate-me-context-layer.md) — the one section that is not
  knowledge, and why it is separate.
