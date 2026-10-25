---
name: todos
description: Gather open todos from daily notes, meeting pages, and todos/ — either listing them where they are (in-place mode) or moving them into one grouped list (rollup mode), per me/working-setup.md. Also offers items someone else is waiting on to the user's tracker.
---

# Todos

Show the user what is still open. **Not one of the four operations** — it works on checkboxes, not concepts. Policy: _Todos, daily notes, and meetings_ in [CLAUDE.md](../../../CLAUDE.md); walkthrough in [docs/daily-notes.md](../../../docs/daily-notes.md).

## Steps

### 1. Read the settings

Read the frontmatter of `me/working-setup.md`: `todo_mode` and `tracker`.

If `todo_mode` is `unset`, **ask** — explain each mode in one sentence, do not recommend one unless asked:

- `in-place` — todos stay where you wrote them; this skill lists them.
- `rollup` — open todos older than today move into one list, `todos/index.md`.

Write the answer into the frontmatter. Set `filled: true` only if the tracker question is also answered; if it is not, ask it now (`none` is a fine answer).

### 2a. In-place mode

Search `daily/`, `meetings/`, and `todos/` for open items — lines matching `- [ ]` (any indent). Skip `templates/`. List them:

- grouped by source note, newest first;
- each with a relative link to its note and its age in days (from the filename date, or the note's `timestamp`);
- items older than 30 days called out at the top.

**Never move or edit anything in this mode.** Closing an item is the user ticking it in Obsidian; tick one yourself only when asked.

### 2b. Rollup mode

For each open `- [ ]` in a daily note or meeting page **dated before today**:

1. Append it to `todos/index.md` under an `## <Area>` heading. Reuse an existing area when one fits; ask when it is unclear. Keep a link to the source note after the text: `- [ ] <text> ([2026-10-25](../daily/2026-10-25.md))`.
2. Replace the original line with `- [>] <text> → [todos](../todos/index.md)` (fix the relative path for the note's folder). `[>]` renders as checked in core Obsidian and no longer matches `- [ ]`, so nothing is counted twice.

Leave today's note alone — the day is still in progress. Then list `todos/index.md` by area.

**First run:** if `todos/` does not exist, create `todos/index.md` with frontmatter (`title`, `description`; it is a reserved index, no `type` needed) and a one-line purpose, and link it from the root `index.md` Sections list.

### 3. Offer the tracker

If `tracker` is not `none`, point out items that read as someone else's work or a commitment to someone. Offer to file them there; on the user's nod, file them with the _why_ in the body, then replace the checkbox with `- [x] <text> → <ticket link>`. Never file anything the user has not seen; never invent an owner or date.

### 4. Log and verify

- **Rollup mode, or any tracker filing:** prepend a dated `log.md` entry naming how many items moved or were filed, and where.
- **In-place listing only:** no log entry — nothing changed.
- Run `bin/okf-lint.sh` and confirm no FAIL or BROKEN.

## Guardrails

- **Never rewrite daily-note prose.** Only checkbox lines and links change.
- Never delete a todo. Moving is the only removal, and it always leaves the `[>]` marker.
- Inline `TODO:` markers are gaps in a page, not tasks — do not list them.
- Links stay relative Markdown links, never wikilinks.
