---
title: Decisions
description: ADR-style records of choices and their consequences.
---

# Decisions

ADR-style records. Each decision is a `Decision` concept, numbered and named:
`0001-short-slug.md`.

**This is the highest-value section in the store.** Code and tickets record what
is true now; almost nothing records the options that lost and why. An ADR is the
artifact that outlives the people who made the call. When a page could be a
decision record, make it one.

**Not to be confused with `me/`.** This section records *what was decided and
why* — one ADR per choice. [`me/`](../me/index.md) records *how you decide*, as
standing context. A specific choice is always a `Decision`, never a `me/` page.

## Shape

Frontmatter carries `type: Decision`, a `status`, and a `timestamp`. The body
runs: **Context → Options considered → Decision → Consequences**. Record the
rejected options and what made them lose — that is the part nobody else writes
down.

<!-- No decisions recorded yet. The first one is often the most useful:
     write up a choice already made, while the reasoning is still recoverable. -->
