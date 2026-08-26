---
title: Capture — getting things into the store
description: How a source travels from inbox/ through raw/ into the concept tree, and what survives a meeting.
---

# Capture — getting things into the store

The two-step path from a dropped file to a concept, and the rules about what is
worth keeping. Policy lives in [CLAUDE.md](../CLAUDE.md); the step-by-step is in
the `ingest` skill.

```
inbox/           →   raw/clippings/       →   the concept tree
(you drop it)        (agent promotes a         (agent derives
 uncommitted          redacted copy)            concepts)
```

Drop a file in [`inbox/`](../inbox/README.md) and tell the agent it is there, with
whatever context the file does not carry itself — a transcript rarely states its
own date, attendees, or purpose:

> *"New meeting transcript in `inbox/` — quarterly planning, 26 Aug, me plus the
> platform leads. Mostly about whether we keep the shared staging cluster."*

The agent reads it in full, talks the takeaways over with you, promotes a
**redacted** copy into `raw/clippings/` with a provenance header, and folds what
matters into concepts. You clear `inbox/` afterwards; the agent never deletes
from it.

**Two steps, not one, because `raw/` is committed.** A file that lands there is in
git history for good. Meeting transcripts are the likeliest thing in any work
store to carry a name, a customer, or an offhand remark that should never have
been written down, so the redaction happens while the file is still uncommitted.

**What survives a meeting** is narrower than the notes: what was *decided* (a
`Decision` — the rejected options exist nowhere else once the room empties), what
you *learned about a system*, and *who owns what*.

**Action items are extracted, then handed off — never stored.** The agent files
them in your tracker where it can, otherwise presents them ready to paste, and
the `log.md` entry names where they went. That entry is the receipt: the raw file
holds what was said forever, so *"what were the actions from that meeting?"* stays
answerable, while done-or-not lives only in the tracker. If they could not be
filed in the session, the entry carries a `> ⏳ UNFILED:` marker that the lint
pass raises until a later entry names where they landed.
