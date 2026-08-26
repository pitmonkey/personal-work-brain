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

## Inherited from the scaffold

These came with the store and describe how it works. They are real decisions, not
examples — revisit or supersede them as your situation changes, but do not edit
them to say something they did not say.

- [0001 — OKF file contract + agent-maintained wiki loop](0001-okf-file-contract-and-agent-maintained-loop.md)
- [0002 — Reach the store by filesystem pointer, not an MCP server](0002-filesystem-pointer-not-mcp-server.md)
- [0003 — Keep a separate `me/` context layer](0003-separate-me-context-layer.md)

## Yours

<!-- Your first ADR goes here. The most useful one is usually a choice already
     made, written up while the reasoning is still recoverable.

     Supersede rather than rewrite: when a decision changes, write a new ADR that
     supersedes the old one and set the old one's status to `superseded`. The
     record of what you believed at the time is the point. -->
