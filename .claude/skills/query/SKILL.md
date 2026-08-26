---
name: query
description: Answer a question from the concept tree first, fall back to raw/ only when needed, cite sources, and offer to file good answers back as concepts.
---

# Query

Answer a question using the store.

## Steps

1. **Answer from the concept tree first.** Search the section directories and
   read the relevant concepts.
2. **Fall back to `raw/`** only when the concept tree is insufficient — the raw
   sources are ground truth but unrefined.
3. **Cite sources.** Link the concepts and/or raw files the answer rests on so it
   is traceable.
4. **Flag gaps.** If the store cannot answer, say so plainly rather than
   guessing; suggest what source would need to be ingested.
5. **Offer to file it back.** When the answer is good and reusable, offer to
   capture it as a new or updated concept (then follow the ingest/synthesize
   discipline).

## Guardrails

- Never invent facts to fill a gap — mark unknowns as `TODO:`.
- Prefer citing a dense concept over quoting raw material directly.
