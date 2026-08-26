---
title: CLAUDE.md — editorial policy (work brain)
description: The schema and editorial policy the agent follows for this store.
---

# CLAUDE.md — editorial policy (work brain)

This file is the **schema and editorial policy** for the store. It is not a
concept; it tells the agent how concepts are shaped and how the collection is
grown and kept coherent. When in doubt, prefer *fewer, denser* pages over many
thin ones.

This store is **private and personal**. It is about work, but it is not a team
artifact — see [What this store is](#what-this-store-is) and
[Confidentiality](#confidentiality), which are the two rules that make it safe
to be honest in here.

## What this store is

A **personal** knowledge store on work topics: the reasoning, context, and
operational knowledge that would otherwise live only in your head.

- **Private by default.** Nobody else reads it. That is what lets it hold a
  candid read on a decision, a bet you are not ready to defend, or the real
  reason something is the way it is.
- **Sharing is a fork, not a permission change.** If a page becomes worth
  publishing to the team, it is copied out, scrubbed, and posted to the system
  of record the team actually uses. Never hand over the store — or a directory
  of it — wholesale.
- **One-way.** Work repos, tickets, and team docs must **not** learn this store
  exists: no links, notes, or references pointing back here. Nothing in a shared
  system should depend on a store only you can read.

## The three layers

1. **`raw/` — immutable source material.** Clippings, exports, meeting notes,
   thread dumps, and assets. Never edited in place, never treated as concepts,
   skipped by the linter. Everything else is *derived from* raw sources.
2. **The concept tree — agent-owned Markdown.** The section directories
   (`decisions/`, `systems/`, …) and the concept `.md` files inside them. This is
   what the agent creates, edits, links, and prunes.
3. **`CLAUDE.md` — the policy.** This file. It governs layers 1 and 2 but is not
   part of the concept tree.

Agent scratch (notes-to-self, work-in-progress) lives under `.claude/`, **never**
in the concept tree.

## Confidentiality

The store is private, but git history is forever and laptops get imaged. Some
things never get written down here at all.

**Never capture, in `raw/` or the tree:**

- **Secrets** — credentials, tokens, API keys, private keys, connection strings,
  session cookies. Reference *where* a secret lives, never its value.
- **Customer or personal data** — PII, customer records, user identifiers,
  support-ticket contents containing either.
- **Privileged or held material** — anything under legal hold, legal advice, or
  covered by an NDA that does not permit personal copies.
- **HR and compensation matters** — salaries, performance material, complaints,
  anything about a person that is theirs and not yours.

**`raw/` immutability cuts both ways.** A clipping is immutable *and* committed,
so a secret pasted into `raw/` is now in git history and removing the file does
not remove it. **Redact before the file lands**, not after. If something slipped
in, say so immediately — the fix is history rewriting or a fresh repo, and it
gets harder the longer it waits.

**Scrub on capture, not on review.** When ingesting a thread, an export, or a
meeting note, strip the above *as you write the raw file*. `TODO:` a redaction
rather than preserving the original "just in case".

**People are a special case.** [`people/`](people/index.md) records what helps
you work with someone — what they own, what they care about, how they decide,
what they have said publicly. It does not record judgements about them you would
not say to their face, and never HR material. If a note would embarrass you if
read aloud to its subject, it does not go in.

## The OKF file format

Every non-reserved `.md` file is a **concept**: a Markdown document that opens
with YAML frontmatter delimited by `---` lines.

- The **only required field is a non-empty `type`.**
- Optional fields: `title`, `description`, `resource` (a canonical URI),
  `tags` (a list), `timestamp` (ISO 8601), and a local `status`
  (`active` | `paused` | `archived` | `idea`).
- **Extra keys and unknown types are allowed.** Consumption is *permissive*:
  never reject a file for unknown keys, unknown types, or broken links — flag,
  don't fail.

## Type taxonomy

Soft and extensible — invent new types when a concept genuinely needs one.

| Type | Home directory | What it captures |
| --- | --- | --- |
| `Decision` | `decisions/` | An ADR-style record of a choice + consequences. **The highest-value section here** — see below. |
| `System` | `systems/` | A running system, service, or piece of infrastructure. |
| `Runbook` | `runbooks/` | An operational procedure. |
| `Reference` | `references/` | External or internal material distilled into a concept. |
| `Person` / `Org` | `people/` | Who owns what, who to ask, how a team or vendor operates. |
| `Concept` | anywhere | General notes and synthesis pages that tie others together. |

**Why `decisions/` leads.** Turnover and time destroy *why we did it this way*
faster than they destroy anything else. Code, tickets, and dashboards record
what is true now; almost nothing records the options that were rejected and what
made them lose. An ADR is the only artifact that survives the people who made
the call. When a page could be a decision record, make it one.

### Adding a section

The tree starts deliberately small. **Do not pre-create sections.** When
something genuinely has nowhere to live, add the directory, give it an
`index.md`, link it from the root [`index.md`](index.md), add a row to the table
above, and log it. Likely next arrivals — `projects/`, `todos/`, `ideas/`,
`meetings/`, `orgs/` — earn their place by being needed, not by being predicted.

## Point, don't mirror

Work is full of systems of record — the ticket tracker, the wiki, the repo, the
dashboard. **This store is not a copy of them.** Duplicating a source of truth
produces a page that is wrong within a fortnight and that nobody trusts.

Write down **the reasoning that would be expensive to lose**, and link out for
the facts:

- **Point at** — current status, ticket state, config values, metrics, API docs,
  org charts, anything with a live owner elsewhere.
- **Keep** — why the approach was chosen and what was rejected; the constraint
  that is not written anywhere; the failure mode discovered the hard way; the
  gotcha where the obvious reading is silently wrong; what "done" was agreed to
  mean.

A page that mirrors an external source must **say so at the top** — a one-line
*derived snapshot, as of `<date>`, source: `<link>`* banner — so a stale copy is
never mistaken for current truth.

**Graduation.** When the real home catches up and owns the content, the page here
**shrinks to a pointer** plus whatever reasoning the real home does not carry.
Shrinking a page is a win, not a loss.

## The relative-link rule

Link concepts with **relative Markdown links**, e.g.
`[the build cluster](../systems/build-cluster.md)` — **never** wikilinks. This
keeps the bundle OKF-portable while Obsidian still renders a graph. Ignore
`http(s)://` links and `#anchors` when reasoning about internal structure.

## Reserved files

- **`index.md`** — a directory listing / progressive-disclosure page. One per
  section, plus the root.
- **`log.md`** — the append-only changelog, newest first, date-prefixed.
- The **`okf_version`** field is permitted **only** in the root `index.md`.

## The four operations

### 1. Ingest

Fold a `raw/` source into the concept tree.

1. **Read the source in full** — do not skim.
2. **Redact on capture.** Apply [Confidentiality](#confidentiality) to the raw
   file *before* it lands. `TODO:` the redaction; never keep the original.
3. **Discuss takeaways first** with the user; agree on what matters before writing.
4. **Create or update concepts**, preferring to enrich an existing dense page
   over spawning a new thin one. Apply [Point, don't mirror](#point-dont-mirror).
5. **Flag contradictions, never silently overwrite.** If a source conflicts with
   an existing concept, surface it (inline `> ⚠️ CONTRADICTION:` note or a TODO)
   and let the user resolve it.
6. **Update the relevant `index.md`** and **prepend a `log.md` entry.**
7. **Verify with `bin/okf-lint.sh`.**

### 2. Query

Answer questions from the store.

1. Answer from the **concept tree first**.
2. **Fall back to `raw/`** only when the tree is insufficient.
3. **Cite sources** — link the concepts and/or raw files used.
4. When an answer is good and reusable, **offer to file it back** as a concept.

### 3. Synthesize

Improve the store's connective tissue.

1. Write **overview / comparison / concept pages** that tie existing concepts
   together.
2. **Push cross-links back** into the pages being connected, so the graph
   densifies in both directions.

### 4. Lint

Keep the store healthy.

1. Run **`bin/okf-lint.sh`** for the mechanical checks (frontmatter, `type`,
   `okf_version` placement, broken links, orphans).
2. Apply **judgement** on top: stale pages, duplicates, missing pages the tree
   clearly implies, and **derived snapshots past their date**. Auto-apply only
   mechanical fixes; raise the rest.
3. **Log the pass** in `log.md`.

## Guardrails

- **Fewer, denser pages** beat many thin ones. Consolidate before you fragment.
- **Never invent facts.** If a detail is unknown, write `TODO:` — do not guess.
- **`raw/` is immutable.** Never edit anything under it; derive concepts instead.
- **Secrets and personal data never land**, in either `raw/` or the tree.
- **Nothing at work points back here.** This store is downstream of everything
  and upstream of nothing.
