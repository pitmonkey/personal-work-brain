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

**This repository is a scaffold.** Copy it, then make it yours. It ships with the
file contract, the linter, the agent skills, the section skeleton, and three
decision records describing how it works — but **no content**. The changelog is
empty by design: the first entry is written when you ingest your first source,
not by the act of setting the store up.

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
| `inbox/` | The doorstep. Drop sources here; **nothing in it is committed**. Cleared as things are ingested. |
| `raw/` | **Immutable** source material — notes, exports, clippings, assets. Never edited; skipped by the linter. Redact *before* a file lands. |
| `decisions/` | ADR-style decision records (type `Decision`). **The highest-value section.** |
| `systems/` | Running systems, services, infrastructure (type `System`). |
| `runbooks/` | Operational procedures (type `Runbook`). |
| `references/` | External and internal material distilled into concepts (type `Reference`). |
| `people/` | Who owns what, who to ask, how teams and vendors operate (`Person` / `Org`). |
| `me/` | Who you are and how you work — the context layer agents read first (type `Context`). |
| `docs/` | Explanation moved out of the files agents load — read on demand, not budgeted. |
| `bin/` | The linter (conformance, links, orphans, context budget), the git-hook installer, and the Claude-config pointer installer. |
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

1. **Run init.** From this directory, run `claude` and invoke the `init` skill.
   It wires the store into your Claude config, installs the git hooks, and tells
   you what still needs filling in. Safe to re-run. To do it by hand instead:
   `bin/install-pointer.sh --dry-run` then `bin/install-pointer.sh`, and
   `bin/install-hooks.sh`. Install [gitleaks](https://github.com/gitleaks/gitleaks)
   or `trufflehog` first — without one, the pre-commit hook warns but cannot scan.
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

## Getting things in

```
inbox/           →   raw/clippings/       →   the concept tree
(you drop it)        (agent promotes a         (agent derives
 uncommitted          redacted copy)            concepts)
```

Drop a source in [`inbox/`](inbox/README.md), tell the agent it is there, and it
promotes a **redacted** copy into `raw/` before deriving concepts. Action items
are extracted and handed off to your tracker, never stored. Full walkthrough:
[docs/capture.md](docs/capture.md).

## Reaching the store from an agent

`bin/install-pointer.sh` installs a user-level skill plus a two-line pointer in
your global `CLAUDE.md`, so agents find the store without you pasting anything.
It is a filesystem pointer rather than an MCP server, deliberately — see
[ADR 0002](decisions/0002-filesystem-pointer-not-mcp-server.md). Setup and
options: [docs/agent-access.md](docs/agent-access.md).

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
- **200-line context budget** on `CLAUDE.md`, `AGENTS.md`, `README.md`, and each
  `SKILL.md`, since those are loaded rather than searched. Over budget,
  explanation moves to [`docs/`](docs/README.md) and the rule stays put.
- **Be specific, not aspirational**, and **run the reaction pass** on every draft:
  present it, ask what's wrong, and if the answer is "looks good", ask for the
  weakest sentence instead. One push, not two.

## Why the rules are what they are

The reasoning behind the rules that look arbitrary — three strictly separated
layers, fewer and denser pages, `decisions/` leading, point-don't-mirror,
relative links, private-and-one-way, and actions living in the tracker — is in
[docs/rationale.md](docs/rationale.md).

## Making it yours

Before the first real ingest, three things are worth settling:

1. **Where the repository lives.** This is what actually enforces the privacy
   rule. A personal-account repo keeps the store yours but may collide with an
   employer's IP policy on work notes; an organisation-hosted private repo is
   policy-safe but readable by anyone with admin, which quietly kills the candour
   the store depends on. There is no default that is right for everyone — pick
   deliberately, and write it up as your first ADR.
2. **A secret scanner.** `bin/install-hooks.sh` wires one into the pre-commit
   hook if it finds `gitleaks` or `trufflehog`; without one it warns but cannot
   scan. `raw/` is immutable and committed, so this hook is the last cheap place
   to stop a pasted credential entering history permanently.
3. **The `me/` pages.** They ship unfilled. Until they are done, agents are
   working without the context layer the store exists to provide.

Then edit this README to describe *your* store rather than the scaffold, and
delete this section.

## Credits

The file contract is the Open Knowledge Format; the maintenance loop follows
Andrej Karpathy's LLM-wiki pattern — see
[ADR 0001](decisions/0001-okf-file-contract-and-agent-maintained-loop.md). The
`me/` context layer, its embedded interview protocols, and the reaction pass are
adapted from
[nlwhittemore/personal-context-portfolio](https://github.com/nlwhittemore/personal-context-portfolio)
(MIT); see [ADR 0003](decisions/0003-separate-me-context-layer.md). `AGENTS.md`
follows the [AGENTS.md](https://github.com/agentsmd/agents.md) convention.
