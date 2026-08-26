---
title: docs/ — the overflow
description: Where explanation goes when an agent-instruction file hits its context budget.
---

# docs/

**Explanation that would otherwise sit in a file an agent loads every session.**

`CLAUDE.md`, `AGENTS.md`, `README.md`, and each `SKILL.md` carry a **200-line
context budget** — they are loaded rather than searched, so every line costs on
every session. When one hits the budget, the *rationale* moves here and the file
keeps the *rules*, with a link back.

Nothing here is loaded automatically. It is read when someone follows the link,
which is why the budget does not apply to these pages.

## What belongs here

- The *why* behind a rule, when the rule itself must stay in the policy.
- A how-to too long for a README section.
- Design background that is true of the store's machinery, not of your work.

## What does not

- **Knowledge.** Anything you learn about your work is a concept — it belongs in
  the section directories, under the OKF file contract.
- **Decisions.** A choice and its consequences is a
  [`Decision`](../decisions/index.md), not a docs page. Docs explain how the
  store works; ADRs record why it was built that way.

## Conventions

These are meta-docs, not concepts. They carry `title` and `description`
frontmatter but **no `type`** — the linter exempts `docs/` from the `type`
requirement, the same way it exempts `README.md` and `CLAUDE.md`. Links are still
checked, and a docs page nothing links to shows up as an orphan.

## Pages

- [Why the rules are what they are](rationale.md)
- [Capture — getting things into the store](capture.md)
- [Reaching the store from an agent](agent-access.md)
