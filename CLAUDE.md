---
title: CLAUDE.md — editorial policy (work brain)
description: The schema and editorial policy the agent follows for this store.
---

# CLAUDE.md — editorial policy (work brain)

The **schema and editorial policy** for this store. It is not a concept. The
rationale behind these rules is in [README.md](README.md); this file is the rules
themselves. When in doubt, prefer *fewer, denser* pages over many thin ones.

## What this store is

A **private, personal** knowledge store on work topics.

- **Private by default.** Nobody else reads it. That is what makes it safe to be
  candid.
- **Sharing is a fork, not a permission change.** Copy a page out, scrub it, post
  it to the team's system of record. Never hand over the store or a directory of it.
- **One-way.** Work repos, tickets, and team docs must **not** learn this store
  exists — no links or references pointing back here.

## The three layers

1. **`raw/`** — immutable source material. Never edited, never a concept, skipped
   by the linter.
2. **The concept tree** — the section directories and the `.md` concepts in them.
   Agent-owned: created, edited, linked, pruned.
3. **`CLAUDE.md`** — this policy. Governs 1 and 2, part of neither.

Agent scratch lives under `.claude/`, **never** in the concept tree.
[`AGENTS.md`](AGENTS.md) is a reserved cross-vendor pointer to this file.

## Confidentiality

**Never record, in `raw/` or the tree:**

- **Secrets** — credentials, tokens, API keys, private keys, connection strings.
  Reference *where* a secret lives, never its value.
- **Customer or personal data** — PII, customer records, user identifiers.
- **Privileged or held material** — legal hold, legal advice, NDA-covered content.
- **HR and compensation matters** — salaries, performance material, complaints.

**Redact before the file lands, not after.** `raw/` is immutable *and* committed,
so a secret pasted there is in git history and deleting the file does not remove
it. `TODO:` the redaction rather than preserving the original "just in case". If
something slipped in, say so immediately — the fix gets harder the longer it waits.

**People are a special case.** [`people/`](people/index.md) records what helps you
work with someone. It never records judgements you would not say to their face,
and never HR material. If a note would embarrass you if read aloud to its
subject, it does not go in.

## The OKF file format

Every non-reserved `.md` file is a **concept**: Markdown opening with YAML
frontmatter delimited by `---`.

- The **only required field is a non-empty `type`.**
- Optional: `title`, `description`, `resource`, `tags`, `timestamp`, `status`
  (`active` | `paused` | `archived` | `idea`).
- **Extra keys and unknown types are allowed.** Consumption is permissive — never
  reject a file for unknown keys or broken links. Flag, don't fail.

## Type taxonomy

Soft and extensible — invent a type when a concept genuinely needs one.

| Type | Home | What it captures |
| --- | --- | --- |
| `Decision` | `decisions/` | ADR-style record of a choice + consequences. **Highest-value section.** |
| `System` | `systems/` | A running system, service, or piece of infrastructure. |
| `Runbook` | `runbooks/` | An operational procedure. |
| `Reference` | `references/` | External or internal material distilled into a concept. |
| `Person` / `Org` | `people/` | Who owns what, who to ask, how a team or vendor operates. |
| `Context` | `me/` | Who you are and how you work — the operating manual agents read. |
| `Concept` | anywhere | General notes and synthesis pages tying others together. |

**`decisions/` vs `me/`.** `decisions/` records *what was decided and why* — one
ADR per choice. `me/` records *how you decide* — your reasoning style, as standing
context. A specific choice is always a `Decision`; never file one in `me/`.

### Adding a section

The tree starts small. **Do not pre-create sections.** When something genuinely
has nowhere to live: add the directory, give it an `index.md`, link it from the
root [`index.md`](index.md), add a row above, and log it. `projects/`, `todos/`,
`ideas/`, `meetings/`, `orgs/` earn their place by being needed, not predicted.

## Point, don't mirror

This store is **not a copy** of the ticket tracker, wiki, repo, or dashboard.

- **Point at** — status, ticket state, config values, metrics, API docs, org
  charts; anything with a live owner elsewhere.
- **Keep** — why the approach was chosen and what was rejected; the constraint
  written down nowhere; the failure mode found the hard way; the gotcha where the
  obvious reading is silently wrong; what "done" was agreed to mean.

A page that mirrors an external source **says so at the top**: *derived snapshot,
as of `<date>`, source: `<link>`*.

**Graduation.** When the real home carries the content, the page here shrinks to a
pointer plus whatever reasoning that home does not hold. Shrinking is a win.

## The relative-link rule

**Relative Markdown links only** — `[k8s](../systems/k8s.md)` — never wikilinks.
Ignore `http(s)://` links and `#anchors` when reasoning about internal structure.

## Reserved files

- **`index.md`** — directory listing / progressive disclosure. One per section, plus root.
- **`log.md`** — append-only changelog, newest first, date-prefixed.
- **`AGENTS.md`** — cross-vendor pointer to this policy. Root only; not scanned.
- **`okf_version`** — permitted **only** in the root `index.md`.

## The four operations

**1. Ingest** — fold a `raw/` source into the tree. Read it in full; redact on
capture; discuss takeaways before writing; enrich an existing dense page over
spawning a thin one; run the reaction pass; flag contradictions with
`> ⚠️ CONTRADICTION:` rather than overwriting; update `index.md`; prepend to
`log.md`; verify with `bin/okf-lint.sh`.

**2. Query** — answer from the concept tree first, fall back to `raw/` only when
insufficient, cite what the answer rests on, offer to file it back.

**3. Synthesize** — write overview / comparison pages tying concepts together, and
push cross-links **back** into the pages being connected.

**4. Lint** — run `bin/okf-lint.sh`, then apply judgement the linter cannot
(stale, expired snapshots, graduation due, duplicate, missing, leakage).
Auto-apply mechanical fixes only; raise the rest. Log the pass.

## Writing rules

- **Be specific, not aspirational.** Record how things actually work, not how they
  should. Confident wrong context is worse than none.
- **The reaction pass.** After drafting, present it and ask what is wrong. If the
  user says it looks good with no changes, ask them to name the weakest or most
  generic sentence and fix that. **One push, not two.**
- **Short beats long.** A dense page outperforms a sprawling one.

## Guardrails

- **Fewer, denser pages.** Consolidate before you fragment.
- **Never invent facts.** Unknown details are written `TODO:`, never guessed.
- **`raw/` is immutable.** Derive concepts from it.
- **Secrets and personal data never land**, in `raw/` or the tree.
- **Nothing at work points back here.**
