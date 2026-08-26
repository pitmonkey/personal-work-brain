---
name: synthesize
description: Write connecting overview / comparison / concept pages that tie existing concepts together, and push back-links into the pages being connected.
---

# Synthesize

Improve the store's connective tissue by writing pages that relate existing
concepts to one another.

## Steps

1. **Pick the connection.** Identify a theme, comparison, or overview that spans
   several existing concepts (e.g. "homelab stack overview", "dispatcher options
   compared").
2. **Write the page.** Create an overview / comparison / concept page with a
   non-empty `type` (often `Concept`, or `Reference` for distilled external
   material) in the most fitting section.
3. **Link outward.** Reference every concept it draws on with relative Markdown
   links.
4. **Push back-links.** Add a link *back* to the new synthesis page from each
   concept it connects, so the graph densifies in both directions.
5. **Update `index.md`** where the new page lives, and **prepend a `log.md`
   entry**.
6. **Verify:** run `bin/okf-lint.sh`.

## Guardrails

- Synthesise only from what the tree (and, if needed, `raw/`) actually says —
  never invent connections or facts; mark gaps as `TODO:`.
- Prefer strengthening an existing overview over creating a competing one.
