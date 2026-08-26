---
type: Decision
title: "ADR 0003 — Keep a separate me/ context layer"
description: Personal working context lives in its own small fixed section rather than being folded into the knowledge sections or omitted.
status: active
tags: [adr, context, structure, scaffold]
timestamp: 2026-08-26
---

# ADR 0003 — Keep a separate `me/` context layer

**Status:** Accepted — 2026-08-26. Inherited from the scaffold.

## Context

The store answers *what do I know*. There is a second, orthogonal question every
agent needs answered before it can be useful — *who am I working with and how do
they work* — and it has none of the same properties. It is first-person, small,
rewritten rather than appended to, and read at the **start** of a task rather
than searched during one.

Without somewhere to put it, that context gets re-explained at the beginning of
every session, and the cost compounds with the number of agents in use.

## Options considered

1. **Omit it.** Keep the store purely about knowledge. Simplest, and leaves the
   original friction entirely unaddressed.
2. **Fold it into the knowledge sections.** A page about yourself in
   `references/`, preferences scattered through `systems/`. No new section, but
   two kinds of content with opposite lifecycles end up mixed, and neither an
   agent nor a human can tell which pages to read first.
3. **A separate, small, fixed section.** (Chosen.)
4. **A full personal-context portfolio.** A larger fixed schema covering identity,
   role, projects, team, tools, communication, goals, preferences, domain, and
   decision style. Comprehensive, but most of it duplicates sections this store
   already has, and pre-creating that many files produces thin pages on day one —
   the exact failure the density rule exists to prevent.

## Decision

A separate `me/` section holding **four** pages: identity, communication style,
preferences and constraints, and domain knowledge. Type `Context`.

Everything else a fuller portfolio would cover already has a home — projects,
people, and tooling are knowledge, and belong in the knowledge sections where
they can grow without bound.

Each page ships as a **template with its interview protocol embedded**: what the
page is for, the questions an agent should ask, and the output structure. A blank
page becomes a guided session rather than a staring contest. Pages carry
`filled: false` until completed, and the lint pass flags them.

**`me/` is not `decisions/`.** This section records *how you decide*, as standing
context; a specific choice is always a `Decision`. Without that rule stated on
both index pages, the two drift into each other.

## Consequences

- These pages are read at the start of every task, so their length is a running
  cost on every session. They are kept to one page each, deliberately.
- They are the pages most likely to be pasted into a tool that is not yours, so
  they carry the tightest confidentiality expectations in the store.
- They rot loudest. A stale context page does not fail silently — it hands agents
  confident but wrong context, which is worse than none. Re-run the interview
  when role, stack, or priorities move.
- Four pages is a floor, not a ceiling. A fifth earns its place the same way any
  new section does: something has nowhere to live.
