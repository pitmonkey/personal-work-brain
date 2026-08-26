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
| `log.md` | Append-only changelog, newest first. |
| `raw/` | **Immutable** source material — notes, exports, clippings, assets. Never edited; skipped by the linter. Redact *before* a file lands. |
| `decisions/` | ADR-style decision records (type `Decision`). **The highest-value section.** |
| `systems/` | Running systems, services, infrastructure (type `System`). |
| `runbooks/` | Operational procedures (type `Runbook`). |
| `references/` | External and internal material distilled into concepts (type `Reference`). |
| `people/` | Who owns what, who to ask, how teams and vendors operate (`Person` / `Org`). |
| `bin/` | The linter and git-hook installer. |
| `.claude/` | Agent skills and scratch — never part of the concept tree. |

The tree starts deliberately small — five sections. New ones are added when
something genuinely has nowhere to live, not in advance. See *Adding a section*
in [CLAUDE.md](CLAUDE.md).

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
5. **Write the first decision record.** The most useful starting page is usually
   a choice already made, written up while the reasoning is still recoverable.
6. **Lint before committing.** `bin/okf-lint.sh` for a full report.

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

## Credits

Adapted from a personal OKF + Karpathy knowledge store, with the work-specific
additions recorded in the first [log.md](log.md) entry.
