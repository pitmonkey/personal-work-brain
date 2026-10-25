---
name: ingest
description: Fold a raw/ source into the concept tree — read it in full, redact on capture, discuss takeaways, create/update dense concepts, flag contradictions, update index.md + log.md, and verify with the linter.
---

# Ingest

Turn a source into knowledge in the concept tree.

Sources arrive one of two ways. Most come through [`inbox/`](../../../inbox/README.md) — the uncommitted doorstep where the user drops something that has not been read or redacted yet. Some are already in `raw/`, promoted earlier or placed there directly because they carried nothing sensitive. **A source in `inbox/` is promoted into `raw/` as part of this skill** (step 2); a source already in `raw/` skips that step.

## Steps

1. **Read the source in full.** Do not skim. If it is binary (in `raw/assets/`), read whatever text/metadata is available and note what you cannot inspect.
2. **Promote from `inbox/` to `raw/`, redacting on the way.** Skip if the source is already in `raw/`.

   Write a **new, redacted** file at `raw/clippings/<YYYY-MM-DD>-<short-slug>.md`. Strip secrets, customer and personal data, privileged material, and HR content as you write it — `raw/` is immutable _and_ committed, so deleting the file later does not remove it from history. Mark each removal with a `TODO:` rather than preserving the original.

   Open the promoted file with a provenance header, so a snapshot is never mistaken for current truth:

   ```markdown
   > **Source:** <what this is — meeting, thread, export, article> **Captured:** <YYYY-MM-DD> · **Occurred:** <YYYY-MM-DD, if different> **Present / author:** <who, where relevant> **Redacted:** <what was removed, or "nothing">
   ```

   Ask the user for anything the file does not carry itself — a transcript rarely states its own date, attendees, or what the meeting was for. Then tell them the original can be deleted from `inbox/`; **never delete it yourself.**

3. **Discuss takeaways first.** Summarise the key points to the user and agree on what is worth keeping _before_ writing any concept. Prefer a handful of dense points over an exhaustive dump.
4. **Create or update concepts.** Enrich an existing page when one fits; only create a new concept when the topic genuinely stands alone. Give every new concept a non-empty `type` and place it in the right section directory. If nothing fits, follow _Adding a section_ rather than forcing it.
5. **Point, don't mirror.** Keep the reasoning that would be expensive to lose; link out for status, config, metrics, and anything with a live owner elsewhere. If the page does mirror a source, put a **derived snapshot, as of `<date>`, source: `<link>`** banner at the top.
6. **Prefer a decision record.** If the source records a choice, write it up in `decisions/` — including the options that lost and why.

   **Meetings especially.** A meeting is the most common source of ADRs in a work store, and the rejected options are the part that exists nowhere else once the room empties. From a meeting, look for: what was **decided** (→ `decisions/`), what was **learned about a system** (→ `systems/`), and **who owns what** (→ `people/`). A meeting big enough to find again may also get a `meetings/` page (`type: Meeting`, from `templates/meeting.md`), linked both ways with that day's daily note. Everything else is context the raw file already holds; do not restate the transcript.

   **Action items become todos** — see step 12.

7. **Flag contradictions — never overwrite.** If the source conflicts with an existing concept, add a visible `> ⚠️ CONTRADICTION:` note (or a `TODO:`) and let the user resolve it. Do not silently replace prior content.
8. **Never invent facts.** Anything the source does not establish is written as `TODO:`.
9. **Cross-link.** Add relative Markdown links to and from related concepts.
10. **Update `index.md`** for any section whose contents changed.
11. **Run the reaction pass.** Present the draft and ask what is wrong — what feels off, what you assumed, what is missing. If the user says it looks good with no changes, ask them to name the weakest or most generic sentence and fix that one. **One push, not two**; if they say it is genuinely fine a second time, accept it and move on. A rubber-stamped page is a mediocre page, and the corrections are where the real signal is.
12. **Turn the action items into todos — never merely mention them.** Read `tracker` and `todo_mode` from `me/working-setup.md` (if `todo_mode` is `unset`, ask, and write the answer back). Then, for each action:

    - **Someone else is waiting, and a tracker is set:** offer to file it there (GitHub Issues, or an MCP server for Jira, Linear, or similar) and do so on the user's nod, with the _why_ from the source in the body. The store keeps a link, never a copy.
    - **Otherwise:** add it as a `- [ ]` checkbox to the meeting page if step 6 made one, else to today's daily note, with the raw source linked. If today's note does not exist, create it from `templates/daily.md` and fill in the placeholders (`{{date:…}}` with today's date in the given format).

    Do **not** invent an owner or a due date the source did not state, and do not file an action the user has not seen.

13. **Prepend a `log.md` entry** (dated, newest first) describing the ingest, and **name the actions and where they went** — which note, page, or tracker.

14. **Verify:** run `bin/okf-lint.sh` and confirm no FAIL / no BROKEN.

## Guardrails

- **Be specific, not aspirational.** Record how things actually work, not how they should. Confident wrong context is worse than no context.
- `raw/` is immutable — read from it, never edit it. Promotion _creates_ a new file there; it never edits an existing one.
- **Never delete from `inbox/`.** Say when a file is done with; the user clears it.
- **Never let an extracted action vanish** — it lands as a checkbox or a tracker link, and the log entry says which.
- Secrets and personal data never land, in `raw/` or the tree.
- Fewer, denser pages beat many thin ones.
- Links stay relative Markdown links, never wikilinks.
