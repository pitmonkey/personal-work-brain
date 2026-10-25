---
title: CLAUDE.md — editorial policy (work brain)
description: The schema and editorial policy the agent follows for this store.
---

# CLAUDE.md — editorial policy (work brain)

The **schema and editorial policy** for this store. It is not a concept. The rationale behind these rules is in [README.md](README.md); this file is the rules themselves. When in doubt, prefer _fewer, denser_ pages over many thin ones.

## What this store is

A **private, personal** knowledge store on work topics.

- **Private by default.** Nobody else reads it. That is what makes it safe to be candid.
- **Sharing is a fork, not a permission change.** Copy a page out, scrub it, post it to the team's system of record. Never hand over the store or a directory of it.
- **One-way.** Work repos, tickets, and team docs must **not** learn this store exists — no links or references pointing back here.

## The three layers

1. **`raw/`** — immutable source material. Never edited, never a concept, skipped by the linter.
2. **The concept tree** — the section directories and the `.md` concepts in them. Agent-owned: created, edited, linked, pruned.
3. **`CLAUDE.md`** — this policy. Governs 1 and 2, part of neither.

Agent scratch lives under `.claude/`, **never** in the concept tree. [`AGENTS.md`](AGENTS.md) is a reserved cross-vendor pointer to this file.

[`inbox/`](inbox/README.md) is **not a layer** — it is the doorstep. Uncommitted, unscanned, a place to drop a source before it has been read or redacted. Ingest promotes a redacted copy into `raw/`; nothing is ever ingested straight from `inbox/` into the tree.

## Confidentiality

**Never record, in `raw/` or the tree:**

- **Secrets** — credentials, tokens, API keys, private keys, connection strings. Reference _where_ a secret lives, never its value.
- **Customer or personal data** — PII, customer records, user identifiers.
- **Privileged or held material** — legal hold, legal advice, NDA-covered content.
- **HR and compensation matters** — salaries, performance material, complaints.

**Redact before the file lands, not after.** `raw/` is immutable _and_ committed, so a secret pasted there is in git history for good. That is what `inbox/` is for: redaction happens on the way from `inbox/` to `raw/`, while the file is still uncommitted. `TODO:` each removal rather than keeping the original. If something slipped in, say so immediately — the fix gets harder the longer it waits.

**People are a special case.** [`people/`](people/index.md) records what helps you work with someone. It never records judgements you would not say to their face, and never HR material. If a note would embarrass you if read aloud to its subject, it does not go in.

## The OKF file format

Every non-reserved `.md` file is a **concept**: Markdown opening with YAML frontmatter delimited by `---`.

- The **only required field is a non-empty `type`.**
- Optional: `title`, `description`, `resource`, `tags`, `timestamp`, `status` (`active` | `paused` | `archived` | `idea`).
- **Extra keys and unknown types are allowed.** Consumption is permissive — never reject a file for unknown keys or broken links. Flag, don't fail.

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
| `Daily` | `daily/` | One day's tasks, meetings, and notes — user-authored, from the template. |
| `Meeting` | `meetings/` | A meeting big enough to stand alone, linked both ways with its day. |
| `Concept` | anywhere | General notes and synthesis pages tying others together. |

**`decisions/` vs `me/`.** `decisions/` records _what was decided and why_ — one ADR per choice. `me/` records _how you decide_ — your reasoning style, as standing context. A specific choice is always a `Decision`; never file one in `me/`.

### Adding a section

The tree starts small. **Do not pre-create sections.** When something genuinely has nowhere to live: add the directory, give it an `index.md`, link it from the root [`index.md`](index.md), add a row above, and log it. `projects/`, `ideas/`, `orgs/` earn their place by being needed, not predicted. `daily/` and `meetings/` ship pre-created because Obsidian writes to them; `todos/` is created on first use in rollup mode.

## Todos, daily notes, and meetings

The store **may track todos.** Why, and the full workday flow: [docs/daily-notes.md](docs/daily-notes.md); the choice itself is [ADR 0004](decisions/0004-store-tracks-todos-via-daily-notes.md).

- **A todo is a checkbox** (`- [ ]`), written where it arose — usually today's daily note. An inline `TODO:` is still a gap in a page, not a task.
- **Read [`me/working-setup.md`](me/working-setup.md) first.** Its `tracker` and `todo_mode` frontmatter govern everything below; if `todo_mode` is `unset`, ask.
- **Tracker preferred for others' work.** If `tracker` is set, offer to file a todo someone else is waiting on there; once filed, keep a link, never a copy. With no tracker, it stays a checkbox here.
- **Two modes.** `in-place`: todos stay put; the `todos` skill finds them. `rollup`: open todos older than today move to `todos/index.md`, leaving `- [>] <text> → [todos](../todos/index.md)` behind.
- **Daily notes are yours.** `daily/YYYY-MM-DD.md`, created by Obsidian from `templates/daily.md`. The agent never rewrites their prose; it may tick, move (rollup), promote a meeting, and add links. Daily notes are not listed in an index and are exempt from the orphan check.
- **Confidentiality applies while typing.** Daily notes skip the `inbox/` redaction step; the _Confidentiality_ rules hold anyway.
- **Big meetings graduate** to `meetings/YYYY-MM-DD-slug.md` (`type: Meeting`), linked both ways with the day. Decisions in them still become ADRs.
- **Extracted action items never vanish** — each lands as a checkbox or a tracker link, and the `log.md` entry says which.

## Point, don't mirror

This store is **not a copy** of the ticket tracker, wiki, repo, or dashboard.

- **Point at** — status, ticket state, config values, metrics, API docs, org charts; anything with a live owner elsewhere.
- **Keep** — why the approach was chosen and what was rejected; the constraint written down nowhere; the failure mode found the hard way; the gotcha where the obvious reading is silently wrong; what "done" was agreed to mean.

A page that mirrors an external source **says so at the top**: _derived snapshot, as of `<date>`, source: `<link>`_.

**Graduation.** When the real home carries the content, the page here shrinks to a pointer plus whatever reasoning that home does not hold. Shrinking is a win.

## The relative-link rule

**Relative Markdown links only** — `[k8s](../systems/k8s.md)` — never wikilinks. Ignore `http(s)://` links and `#anchors` when reasoning about internal structure.

## Reserved files

- **`index.md`** — directory listing / progressive disclosure. One per section, plus root.
- **`log.md`** — append-only changelog, newest first, date-prefixed.
- **`AGENTS.md`** — cross-vendor pointer to this policy. Root only; not scanned.
- **`okf_version`** — permitted **only** in the root `index.md`.

## The four operations

**Ingest** a source into concepts · **Query** the tree and cite what the answer rests on · **Synthesize** pages connecting existing concepts, pushing links back · **Lint** with `bin/okf-lint.sh` plus the judgement it cannot apply.

The steps live in `.claude/skills/<operation>/SKILL.md` — the single definition of each, so it cannot drift from a copy here. Rules that hold across all four:

- **Discuss takeaways before writing**, and enrich a dense page over spawning a thin one.
- **Flag contradictions** with `> ⚠️ CONTRADICTION:`; never silently overwrite.
- **Update the section `index.md`** and **prepend a `log.md` entry** for any change to the tree.
- **Verify with `bin/okf-lint.sh`** and resolve every FAIL and BROKEN.

## Writing rules

- **Be specific, not aspirational.** Record how things actually work, not how they should. Confident wrong context is worse than none.
- **The reaction pass.** After drafting, present it and ask what is wrong. If the user says it looks good with no changes, ask them to name the weakest or most generic sentence and fix that. **One push, not two.**
- **Short beats long.** A dense page outperforms a sprawling one.

## Context budget

`CLAUDE.md`, `AGENTS.md`, `README.md`, and each `SKILL.md` are **loaded into context**, not searched, so their length is a standing cost on every session. Budget: **200 lines each**, checked advisorily by `bin/okf-lint.sh` and overridable with `OKF_CONTEXT_BUDGET`.

**Over budget, move the explanation to [`docs/`](docs/README.md)** — one page per topic — and leave the rule here with a link to it. `docs/` is read on demand, so it is not budgeted; that is what makes it the pressure valve. Never cut a rule to fit; move explanation, or raise the overrun with the user.

## Guardrails

- **Fewer, denser pages.** Consolidate before you fragment.
- **Never invent facts.** Unknown details are written `TODO:`, never guessed.
- **`raw/` is immutable.** Derive concepts from it.
- **Secrets and personal data never land**, in `raw/` or the tree.
- **Nothing at work points back here.**
