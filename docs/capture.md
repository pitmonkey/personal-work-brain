---
title: Capture — getting things into the store
description: How a source travels from inbox/ through raw/ into the concept tree, and what survives a meeting.
---

# Capture — getting things into the store

The two-step path from a dropped file to a concept, and the rules about what is worth keeping. Policy lives in [CLAUDE.md](../CLAUDE.md); the step-by-step is in the `ingest` skill.

```
inbox/           →   raw/clippings/       →   the concept tree
(you drop it)        (agent promotes a         (agent derives
 uncommitted          redacted copy)            concepts)
```

Drop a file in [`inbox/`](../inbox/README.md) and tell the agent it is there, with whatever context the file does not carry itself — a transcript rarely states its own date, attendees, or purpose:

> _"New meeting transcript in `inbox/` — quarterly planning, 26 Aug, me plus the platform leads. Mostly about whether we keep the shared staging cluster."_

The agent reads it in full, talks the takeaways over with you, promotes a **redacted** copy into `raw/clippings/` with a provenance header, and folds what matters into concepts. You clear `inbox/` afterwards; the agent never deletes from it.

**Two steps, not one, because `raw/` is committed.** A file that lands there is in git history for good. Meeting transcripts are the likeliest thing in any work store to carry a name, a customer, or an offhand remark that should never have been written down, so the redaction happens while the file is still uncommitted.

**What survives a meeting** is narrower than the notes: what was _decided_ (a `Decision` — the rejected options exist nowhere else once the room empties), what you _learned about a system_, and _who owns what_.

**Action items become todos.** If [`me/working-setup.md`](../me/working-setup.md) names a tracker and you agree, the agent files an item someone else is waiting on there and the store keeps a link. Otherwise each lands as a checkbox in today's daily note, or in the meeting page if one was made, with the source linked. The `log.md` entry names where they went, so nothing extracted can quietly vanish.

**The everyday path skips all of this.** Most capture is typed straight into the day's note in Obsidian — no `inbox/`, no promotion. That is fine for your own notes, and it is why the confidentiality rules apply while you type. See [daily-notes.md](daily-notes.md).
