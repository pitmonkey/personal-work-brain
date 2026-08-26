---
title: Changelog
description: Append-only log of changes to the knowledge store, newest first.
---

# Log

Append-only. Newest entries first. Each entry is date-prefixed (ISO 8601).

An entry records **what changed and why it mattered** — not a diff. Git already
holds the diff; what git cannot hold is the reasoning, the contradiction you
found, or the judgement call you made. Write that.

```markdown
## YYYY-MM-DD — short description of the change

What was created, updated, or retired, with relative links to the pages
involved. Why it mattered: the trigger, the reasoning worth keeping, any
contradiction surfaced, and anything deliberately left out.

> ⏳ UNFILED: <only if action items were extracted and not yet filed in the
> tracker — one line each. The lint pass raises this until a later entry
> names where they landed.>
```

Every ingest, synthesis, and lint pass gets an entry. Nothing is recorded below
yet — the first entry is written when the first source is ingested.
