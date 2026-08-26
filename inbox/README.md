# inbox/

**The doorstep. Not part of the store.**

Drop anything here that you want folded into the knowledge store: meeting notes
and transcripts, exported threads, clippings, screenshots, a voice-memo
transcription, a document someone sent you.

**Nothing in this directory is committed.** `.gitignore` excludes everything
except this README. That is the whole point: it is a place to put a file that has
not been read, judged, or redacted yet, without that file becoming permanent.

## Why this exists

[`raw/`](../raw/README.md) is immutable **and** committed — a file that lands
there is in git history for good, and deleting it later does not remove it.
Meeting transcripts are the most likely thing in any work store to carry a name,
a customer, a credential, or an offhand remark about a person that should never
have been written down.

So there are two steps, not one:

```
inbox/           →   raw/clippings/       →   the concept tree
(you drop it)        (agent promotes a         (agent derives
 uncommitted          redacted copy)            concepts)
```

## How to use it

1. Drop the file in. Any format, any name — this is a doorstep, not an archive.
2. Tell the agent it is there, with whatever context is not in the file itself:

   > *"New meeting transcript in `inbox/` — quarterly planning, 26 Aug, me plus
   > the platform leads. Mostly about whether we keep the shared staging cluster."*

   Or just run the **ingest** skill and point it at the file.
3. The agent reads it in full, talks the takeaways over with you, promotes a
   redacted copy into `raw/clippings/` with an ISO-date name and a provenance
   header, and folds what matters into concepts.
4. Once it is ingested, delete the original from here. `inbox/` should be empty
   most of the time; a file sitting here is a thing not yet dealt with.

## When to skip the inbox

If a source carries **nothing sensitive** and is already in good shape — a public
article, a page of your own vendor-neutral notes — putting it straight into
`raw/clippings/` yourself with an ISO-date prefix is fine. The inbox exists for
the case where a human eye and the redaction policy need to run *before* the
thing becomes permanent, which is most work sources and nearly every meeting.

## What actually survives a meeting

Most of a transcript is not worth keeping, and the notes themselves are not the
deliverable. What matters is:

- **What was decided** → a [`Decision`](../decisions/index.md). Meetings are the
  single most common source of ADRs, and the rejected options are the part that
  exists nowhere else once the room empties.
- **What you learned about a system** → [`systems/`](../systems/index.md).
- **Who owns what, and who to ask** → [`people/`](../people/index.md).
- **Actions you agreed to** → your tracker, **not** here. This store is not a
  task list, and nothing at work links back to it.

Everything else is context that the raw file already holds.
