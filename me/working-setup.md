---
type: Context
title: Working setup
description: Your tracker, if any, and how open todos are gathered — read by the todos, ingest, lint, and init skills.
status: active
filled: false
tracker: none
todo_mode: unset
tags: [context, todos, tracker]
---

# Working setup

> **UNFILLED TEMPLATE.** `TODO:` run the interview below, set the `tracker` and `todo_mode` frontmatter, replace everything under _Output structure_ with the finished page, then set `filled: true`.

## What this page is for

Two settings the skills read before touching a todo, plus the reasoning behind them. The **frontmatter is the machine-readable part** — skills read `tracker` and `todo_mode` from it, so keep those keys exact:

- `tracker:` `none`, or the tracker's name and URL (`Jira — https://…`). When set, a todo someone else is waiting on is offered for filing there, and the store keeps a link rather than a copy.
- `todo_mode:` one of
  - `in-place` — todos stay where you wrote them, usually the daily note. The `todos` skill finds every open checkbox and lists them; you tick them where they are.
  - `rollup` — open todos older than today are moved into one grouped page, `todos/index.md`, and the original line is left as `- [>] … → todos`. You work from that one list.
  - `unset` — not chosen yet. Skills ask rather than guess.

## Interview protocol

_Hand this page to an agent and say "let's do this one." The agent runs the interview below._

**Instructions for the agent.** Ask **one question at a time**. Explain the two todo modes in one sentence each before asking question 3; do not recommend one unless asked. 3–5 questions.

**Questions:**

1. Do you have a tracker for work items — Jira, Linear, GitHub Issues, something else — and what is its URL?
2. When a todo is really a commitment to someone else, do you want it pushed to that tracker, or kept here with everything else?
3. Do you prefer to leave todos where you wrote them and have them found for you, or to have them gathered into one list?
4. Is there anything you track that should _never_ go in either place?

**After drafting:** write the frontmatter values, present the page, and ask what's wrong. If they say it looks good with no changes, ask them to name the weakest line and fix that. **One push, not two.**

## Output structure

```markdown
## Tracker

[Which one, its URL, and which kinds of item go there rather than here.]

## Todo mode

[in-place or rollup, and why it suits how you work.]

## Exceptions

[Anything that goes in neither place.]
```
