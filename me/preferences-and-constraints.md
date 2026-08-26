---
type: Context
title: Preferences and constraints
description: Hard rules, strong opinions, and real limits any agent should respect.
status: active
filled: false
tags: [context, preferences, constraints]
---

# Preferences and constraints

> **UNFILLED TEMPLATE.** `TODO:` run the interview below and replace everything
> under *Output structure* with the finished page, then set `filled: true`.

## What this page is for

The rules an agent should treat as non-negotiable, and the real-world limits it
should work within. This is the page that stops an agent confidently proposing
something you cannot do — the wrong tool, a banned dependency, a workflow your
org forbids, a meeting slot you will never take.

Keep the distinction sharp: a **preference** is a default you would override in a
good enough case; a **constraint** is a wall. Say which is which, because an agent
cannot tell from tone.

## Interview protocol

*Hand this page to an agent and say "let's do this one." The agent runs the
interview below.*

**Instructions for the agent.** Ask **one question at a time**. For each item the
user gives you, ask whether it is a preference or a hard constraint — do not
infer it. Push for the *reason* behind a constraint; an agent that knows why can
find an alternative that still satisfies it. 5–8 questions.

**Questions:**

1. What are your hard rules — things that are never OK regardless of the reason?
2. What tools, languages, or approaches are off the table, and why? Policy, taste, or something else?
3. What does your organisation require or forbid that an outsider wouldn't guess?
4. What are your strong defaults — the things you'd want chosen unless there's a good reason not to?
5. What are the real limits on your time and attention?
6. What's the fastest way for someone to annoy you or waste your time?

**After drafting:** present it and ask what's wrong. Check specifically that each
item is filed under the right heading — preference vs. constraint is the thing
most likely to be misplaced. If they say it looks good with no changes, ask them
to name the weakest or most generic line and fix that. **One push, not two.**

## Output structure

```markdown
## Hard constraints
[Walls. Never negotiable, whatever the reason. Give the reason for each.]

## Organisational requirements
[Policy, compliance, and process rules an outsider would not guess.]

## Strong defaults
[Preferences — what to choose absent a good reason otherwise.]

## Time and attention
[Real limits on availability, focus, and how you want to be interrupted.]

## Anti-patterns
[The fastest ways to waste your time.]
```
