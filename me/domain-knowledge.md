---
type: Context
title: Domain knowledge
description: What you know that a general-purpose model does not.
status: active
filled: false
tags: [context, domain, expertise]
---

# Domain knowledge

> **UNFILLED TEMPLATE.** `TODO:` run the interview below and replace everything
> under *Output structure* with the finished page, then set `filled: true`.

## What this page is for

The expertise, jargon, and hard-won context that a general-purpose model does not
have and cannot infer — your industry's real constraints, your org's vocabulary,
the received wisdom that is wrong, and the specifics that make generic advice
useless in your situation.

**This page is an index, not a library.** Deep knowledge belongs in
[`references/`](../references/index.md), [`systems/`](../systems/index.md), and
[`decisions/`](../decisions/index.md) as proper concepts. What lives here is the
orientation an agent needs before reading any of those, plus links to them. If a
section here grows past a paragraph, that is the signal to give it its own
concept page and leave a pointer.

## Interview protocol

*Hand this page to an agent and say "let's do this one." The agent runs the
interview below.*

**Instructions for the agent.** Ask **one question at a time**. Hunt specifically
for things that are *counterintuitive* — where the obvious or textbook answer is
wrong in this domain. Those are worth more than a broad survey of the field. 5–8
questions.

**Questions:**

1. What's the domain, and what does a smart outsider consistently get wrong about it?
2. What jargon and acronyms come up daily that a general model would misread or guess at?
3. What's the received wisdom in your field that's actually wrong or outdated?
4. What constraints shape your work that people outside it wouldn't know about — regulatory, technical, commercial?
5. What have you learned the hard way that isn't written down anywhere?
6. If an agent were about to give you generic advice in this domain, what would make it useless?

**After drafting:** present it and ask what's wrong. Check whether any section has
outgrown a paragraph and should become its own concept page. If they say it looks
good with no changes, ask them to name the weakest or most generic line and fix
that. **One push, not two.**

## Output structure

```markdown
## The domain
[What it is and what outsiders get wrong.]

## Vocabulary
[Jargon and acronyms, each with a one-line gloss. Flag any that collide with a
common meaning a model would default to.]

## Where the obvious answer is wrong
[Counterintuitive facts and outdated received wisdom. The highest-value section.]

## Constraints that shape the work
[Regulatory, technical, commercial. Link to concepts where they exist.]

## Learned the hard way
[Things written down nowhere else. Promote each to its own concept as it grows.]

## Deeper reading in this store
[Links into references/, systems/, decisions/.]
```
