---
type: Decision
title: "ADR 0004 — The store tracks todos, captured in daily notes"
description: Lift the ban on tracking outstanding work; daily notes become the everyday capture surface, and each user picks in-place or rollup todo handling.
status: active
tags: [adr, todos, daily-notes, meetings, scaffold]
timestamp: 2026-10-25
---

# ADR 0004 — The store tracks todos, captured in daily notes

**Status:** Accepted — 2026-10-25. Inherited from the scaffold.

## Context

The store previously recorded _what happened and why_, never _what is outstanding_. Action items had to go to an external tracker, a todo had to clear a three-part bar before it could live here, and a `⏳ UNFILED` marker in `log.md` policed the handoff until the tracker had the item.

That holds up for someone with a tracker they already trust for everything. Most people using a personal work store do not: they want a basic todo list, and in Obsidian they keep it in daily notes, typed during the day alongside meeting notes. The old rule told them their most common use was out of bounds, and the handoff ceremony cost more than the items were worth.

## Options considered

1. **Keep the ban.** Simple and principled, and wrong for the common case — it pushes people to keep todos somewhere the agent cannot see.
2. **Allow todos, but only in `todos/` pages.** Keeps capture deliberate, but fights the way people actually write: in the moment, in the day's note.
3. **Daily notes as the capture surface, with a per-user todo mode.** (Chosen.) Todos are checkboxes written wherever they arise. A setting in `me/working-setup.md` picks _in-place_ (todos stay put; a skill finds them) or _rollup_ (open todos are gathered into `todos/index.md`). A tracker, if the user has one, is still preferred for work someone else is waiting on.

## Decision

Option 3. Obsidian's core Daily notes plugin writes `daily/YYYY-MM-DD.md` from `templates/daily.md`, with vault settings committed so it works on first open. Big meetings graduate into `meetings/`, linked both ways with the day. The tracker preference survives as a preference: when one is configured, an item someone else is waiting on is offered there, and the store keeps a link rather than a copy.

## Consequences

- `⏳ UNFILED` is retired. Its job was to stop a commitment falling between store and tracker; now that the store may hold the item, an unfiled action is simply an open checkbox, which cannot be silently lost.
- Two lists can drift when a tracker is configured. The link-not-copy rule is the mitigation; the lint pass flags open todos older than 30 days.
- Daily notes are typed straight into a committed folder, skipping the `inbox/` redaction step. The confidentiality rules apply while typing, and the pre-commit secret scan is the backstop.
- `daily/` and `meetings/` ship pre-created, an exception to _do not pre-create sections_, because Obsidian needs its target folder. `todos/` is still created on demand.
- `me/` gains a fifth page, `working-setup.md`, under [ADR 0003](0003-separate-me-context-layer.md)'s rule that a new page earns its place when something has nowhere to live — here, two settings every todo-touching skill must read.
- Core Obsidian plugins only. The community Tasks plugin adds live in-note queries and is documented as optional, not required.
