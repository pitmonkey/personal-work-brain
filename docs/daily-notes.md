---
title: Daily notes, meetings, and todos
description: The workday flow — how daily notes, meeting pages, and the two todo modes fit together, and why.
---

# Daily notes, meetings, and todos

The rules are in [CLAUDE.md](../CLAUDE.md) under _Todos, daily notes, and meetings_; the decision behind them is [ADR 0004](../decisions/0004-store-tracks-todos-via-daily-notes.md). This page is the walkthrough.

## A workday

1. **Open Obsidian.** The core Daily notes plugin creates `daily/YYYY-MM-DD.md` from [the template](../templates/daily.md) and opens it. Settings ship in `.obsidian/daily-notes.json`, so nothing needs configuring.
2. **Type as the day goes.** Todos go under _Tasks_ as checkboxes. Short meetings go under _Meetings_ as a `###` heading with a few lines. Everything else goes under _Notes_.
3. **Promote a big meeting.** When a meeting is long, recurring, or produced decisions, ask the agent to promote it. It moves the block into `meetings/YYYY-MM-DD-slug.md` (from [the meeting template](../templates/meeting.md)), leaves a one-line link in the daily note, links back to the day from the meeting page, lists it in [meetings/](../meetings/index.md), and offers to write up any decision as an ADR.
4. **Gather todos.** Run the `todos` skill. What it does depends on your mode.

## The two todo modes

Set once, in [`me/working-setup.md`](../me/working-setup.md) (`todo_mode:`). The `init` skill asks; so does `todos` the first time if it is still `unset`.

- **`in-place`** — nothing moves. The skill searches `daily/`, `meetings/`, and `todos/` for open `- [ ]` items and lists them grouped by day, each with a link and its age. You tick them where they are. Good if you think in days and like each note to stay a true record of that day.
- **`rollup`** — open todos from notes older than today are moved into `todos/index.md` under area headings. The original line becomes `- [>] <text> → [todos](../todos/index.md)`, which core Obsidian renders as a checked box and which no longer matches `- [ ]`, so nothing is counted twice. Good if you want one list to work from.

Switching modes later is fine. Going from rollup to in-place leaves `todos/index.md` as a normal page of open checkboxes, which the in-place search still finds.

## Trackers

If `tracker:` names one, a todo someone else is waiting on is offered for filing there — the person waiting can see a tracker, not your private notes. Once filed, the store keeps a link to the ticket, never a copy, so the two lists cannot drift. With no tracker, the todo stays a checkbox here, and that is fine.

## Confidentiality

Daily notes are the one place you type straight into a committed folder: no `inbox/`, no redaction step. So the never-record rules — secrets, customer and personal data, privileged material, HR matters — apply _while you type_. The pre-commit secret scan catches credentials, not names or judgements about people.

## Optional: the Tasks plugin

The community [Tasks](https://github.com/obsidian-tasks-group/obsidian-tasks) plugin adds a live query block, for example every open todo across the vault, rendered inside a note. It covers in-place mode inside Obsidian without asking the agent. The scaffold does not depend on it; core plugins are enough.
