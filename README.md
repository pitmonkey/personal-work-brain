---
title: Work Brain — README
description: What this private work knowledge store is, how it is organised, and how to use it.
---

# Work Brain

A **private, git-backed, Obsidian-friendly knowledge store** for work: the
decisions, systems, procedures, and context that would otherwise live only in
your head. It is a plain folder of Markdown files — no database, no lock-in —
that doubles as an Obsidian vault and as working context for an LLM agent.

> **This store is personal, not a team artifact.** Nothing at work links back to
> it, and sharing a page means copying it out and scrubbing it — never handing
> over the store. The rules that make it safe to be candid in here are in
> [CLAUDE.md](CLAUDE.md).

## Why OKF + Karpathy

Two ideas combine here:

1. **The Open Knowledge Format (OKF)** gives the store a portable *file
   contract*: every note is a Markdown file with YAML frontmatter, a handful of
   reserved filenames, and permissive consumption rules.
2. **Andrej Karpathy's LLM-wiki loop** gives the store a *maintenance loop*: an
   agent reads source material, discusses takeaways, and folds them into a small
   set of dense, cross-linked concept pages rather than letting notes sprawl.

OKF says *how a file is shaped*; the Karpathy loop says *how the collection grows
and stays coherent*.

## Layout

| Path | What lives there |
| --- | --- |
| `index.md` | Root progressive-disclosure entry point (carries `okf_version`). |
| `CLAUDE.md` | The schema and editorial policy the agent follows. |
| `AGENTS.md` | Cross-vendor pointer to `CLAUDE.md`, for agents that don't read it. |
| `log.md` | Append-only changelog, newest first. |
| `raw/` | **Immutable** source material — notes, exports, clippings, assets. Never edited; skipped by the linter. Redact *before* a file lands. |
| `decisions/` | ADR-style decision records (type `Decision`). **The highest-value section.** |
| `systems/` | Running systems, services, infrastructure (type `System`). |
| `runbooks/` | Operational procedures (type `Runbook`). |
| `references/` | External and internal material distilled into concepts (type `Reference`). |
| `people/` | Who owns what, who to ask, how teams and vendors operate (`Person` / `Org`). |
| `me/` | Who you are and how you work — the context layer agents read first (type `Context`). |
| `bin/` | The linter and git-hook installer. |
| `.claude/` | Agent skills and scratch — never part of the concept tree. |

The tree starts deliberately small — six sections. New ones are added when
something genuinely has nowhere to live, not in advance. See *Adding a section*
in [CLAUDE.md](CLAUDE.md).

## Two layers of context

The store answers two different questions, and keeping them apart is what stops
either from turning to mush:

- **What do I know?** — `decisions/`, `systems/`, `runbooks/`, `references/`,
  `people/`. Third person, durable, grows without bound as you learn.
- **Who am I and how do I work?** — [`me/`](me/index.md). First person, an
  operating manual, fixed and small, rewritten rather than appended to. Read at
  the *start* of a task rather than searched during one, so its length is a
  running cost on every session.

The second layer is the one that stops you re-explaining yourself to every new
agent, and the problem compounds as the number of agents you work with grows.

## Quick start

1. **Install the hooks.** Run `bin/install-hooks.sh` once. It wires the strict
   linter *and* a secret scan into a pre-commit hook. Install
   [gitleaks](https://github.com/gitleaks/gitleaks) or `trufflehog` first —
   without one, the hook warns but cannot scan.
2. **Open as an Obsidian vault.** Point Obsidian at this folder. In
   *Settings → Files & Links*, turn **"Use \[\[Wikilinks\]\]" OFF** and set
   **"New link format" = Relative path to file**. This keeps every link a
   portable relative Markdown link while Obsidian still renders the graph.
3. **Run the agent.** From this directory, run `claude`. It reads `CLAUDE.md` and
   operates the ingest / query / synthesize / lint loop.
4. **Drop sources in `raw/`.** Text in `raw/clippings/`, binaries in
   `raw/assets/`, ISO-date-prefixed. Redact secrets and personal data as you
   write the file — `raw/` is immutable *and* committed. Then ask the agent to
   *ingest* it.
5. **Fill in `me/`.** Each page in [`me/`](me/index.md) ships as a template with
   its interview protocol embedded. Open one, hand it to your agent, say *"let's
   do this one"*, and it runs the interview and drafts the page. Start with
   `identity.md`, then `communication-style.md` — that second one changes agent
   output the most, the fastest.
6. **Write the first decision record.** The most useful starting page is usually
   a choice already made, written up while the reasoning is still recoverable.
7. **Lint before committing.** `bin/okf-lint.sh` for a full report.

## Conventions in brief

- **Three layers:** immutable `raw/`, the agent-owned concept tree, and
  `CLAUDE.md` as the policy. Agent scratch lives in `.claude/`, never in the tree.
- **Every concept** is a `.md` file whose frontmatter (between `---` lines) has
  at least a non-empty `type`. Other fields — `title`, `description`, `resource`,
  `tags`, `timestamp`, `status` — are optional. Unknown keys are fine.
- **Links are relative Markdown links**, e.g. `[k8s](../systems/k8s.md)` — never
  wikilinks — so the bundle stays OKF-portable.
- **Reserved filenames:** `index.md` (directory listing) and `log.md` (changelog).
  The `okf_version` field appears only in the root `index.md`.
- **Point, don't mirror.** Keep the reasoning that would be expensive to lose;
  link out for anything with a live owner elsewhere. Pages that do mirror a
  source carry a dated *derived snapshot* banner and graduate to a pointer.
- **Never capture** secrets, customer or personal data, privileged material, or
  HR and compensation matters — in `raw/` or the tree.
- **Be specific, not aspirational**, and **run the reaction pass** on every draft:
  present it, ask what's wrong, and if the answer is "looks good", ask for the
  weakest sentence instead. One push, not two.

## Why the rules are what they are

`CLAUDE.md` states the rules; this section is the reasoning behind the ones that
look arbitrary.

**Three layers, strictly separated.** Mixing immutable sources, derived concepts,
and the policy governing both is what turns note stores into sludge. Sources can
be trusted precisely because they are never edited; concepts can be rewritten
freely precisely because the sources survive.

**Fewer, denser pages.** Thin pages fragment a topic across files nobody
reassembles. This cuts against the atomic-note tradition deliberately: atomicity
optimises for linking, density optimises for an agent loading one page and having
the whole picture.

**`decisions/` leads.** Turnover and time destroy *why we did it this way* faster
than anything else. Code, tickets, and dashboards all record what is true now;
almost nothing records the options that lost. An ADR outlives the people who made
the call.

**Point, don't mirror.** Duplicating a system of record produces a page that is
wrong within a fortnight and that nobody trusts. Worse, a stale page is not
neutral — it hands an agent confident but wrong context.

**Relative links, never wikilinks.** Wikilinks are more pleasant to type and bind
you to one editor. Relative links keep the bundle portable while Obsidian renders
the graph anyway.

**Private, and one-way.** Candour is the whole value of a personal store, and
candour survives only while the audience is one person. Nothing shared may depend
on a store only you can read.

## Credits

Adapted from a personal OKF + Karpathy knowledge store. The `me/` context layer,
its embedded interview protocols, and the reaction pass are adapted from
[nlwhittemore/personal-context-portfolio](https://github.com/nlwhittemore/personal-context-portfolio)
(MIT). `AGENTS.md` follows the [AGENTS.md](https://github.com/agentsmd/agents.md)
convention. Per-change rationale is in [log.md](log.md).
