---
title: Changelog
description: Append-only log of changes to the knowledge store, newest first.
---

# Log

Append-only. Newest entries first. Each entry is date-prefixed (ISO 8601).

## 2026-08-26 — added an init skill and a Claude-config pointer installer

New `bin/install-pointer.sh` and an [init](.claude/skills/init/SKILL.md) skill,
closing the `TODO:` from the previous entry about how an agent reaches the store.

**Settled: a filesystem pointer, not an MCP server.** The two are not equivalent.
The maintenance loop *writes* — ingest, update indexes, prepend to the log, lint,
commit — and a path gives read, write, grep and git history natively, where an
MCP resource exposure is mostly read; serving the store over MCP would turn a
maintained store into a lookup table. It is also the narrower surface, which the
confidentiality rules argue for: a path only local Claude Code can see beats a
server any connected client can query. MCP's one real advantage is reach from a
client that cannot see the filesystem — which is exactly the case this store does
not want. Recorded here for now; it should graduate to a `Decision` page.

**The skill is the load-bearing half, not the global `CLAUDE.md` line.** A global
pointer is loaded into every session, including the many with nothing to do with
the store. A user-level skill keeps its one-line description always in context but
loads its body only when a session is actually about the store. So the installer
writes both: the skill carries the instructions, and the global pointer is two
lines for discoverability, skippable with `--no-claude-md`.

**Mechanical work in `bin/`, judgement in the skill** — the same split the store
already uses for `okf-lint.sh` versus the `lint` skill. The script is idempotent
and marker-delimited, supports `--dry-run` and `--uninstall`, and validates its
`--label`. The skill drives it: dry-run first, show the user before touching
anything in their global config, then apply.

**A bug found by testing the case that actually applies here.** The first version
hardcoded the pointer blurb as "private *work* knowledge store", which is wrong
for any other store installed beside it — and a personal second brain alongside
this one is the expected setup. The blurb is now read from each store's own root
`index.md` `description:` frontmatter, so side-by-side stores describe themselves
correctly; `--description` overrides it.

Verified against a throwaway `CLAUDE_HOME`: dry-run writes nothing, install is
idempotent across re-runs, pre-existing global `CLAUDE.md` content survives, two
stores install side by side under distinct labels, uninstalling one leaves the
other intact, and a shell-metacharacter label is rejected.

## 2026-08-26 — added the me/ context layer, split the policy, added AGENTS.md

Reviewed [nlwhittemore/personal-context-portfolio](https://github.com/nlwhittemore/personal-context-portfolio)
(MIT) and the [AGENTS.md](https://github.com/agentsmd/agents.md) convention, and
folded three things in. The podcast episode behind the portfolio was not readable
from here — the audio host and the transcript mirror are both egress-blocked — so
this rests on the repository, which is the substance anyway.

**The portfolio is not a competing store; it is a layer this one was missing.**
The work brain answers *what do I know* — third person, durable, unbounded. The
portfolio answers *who am I and how do I work* — first person, an operating
manual, fixed and small. The store had nothing of the second kind. New section
[me/](me/index.md), four pages: identity, communication style, preferences and
constraints, domain knowledge. Their other six files map onto sections that exist
or are deliberately deferred, so they were not copied.

**The fixed ten-file schema was rejected.** It contradicts *fewer, denser pages*
and *add a section when something has nowhere to live* — pre-creating ten files
buys ten thin pages on day one, the exact failure this store's policy exists to
prevent. Also rejected: their lack of frontmatter, linter, and changelog (fine at
ten files, not at sixty) and the web app, which would mean handing work context
to a third party the confidentiality section was written against.

**Two mechanics borrowed outright.** The *embedded interview protocol* — each
`me/` page carries what it is for, the questions an agent should ask, and the
output structure, so a blank page becomes a guided session. And the *reaction
pass*: present the draft, ask what is wrong, and when the answer is "looks good",
ask for the weakest sentence instead. One push, not two. That is now step 11 of
the ingest skill and a standing writing rule. Their framing of staleness — a
stale page is worse than none, because it gives agents confident but wrong
context — sharpened the lint skill; it is the reason the derived-snapshot banner
exists, stated better than the banner rule stated it.

**`me/` vs `decisions/` disambiguated before they could collide.** The portfolio's
`decision-log.md` records *how you decide*; this store's `decisions/` records
*what was decided*. Both are worth having and the names would have drifted into
each other, so the rule is written on both index pages: a specific choice is
always a `Decision`.

**The policy was too long, and the AGENTS.md spec is what surfaced it.** Research
across 2,500+ repositories reports diminishing returns past ~150 lines;
`CLAUDE.md` was at 212. It was doing two jobs — operational rules *and* the
reasoning behind them. The rules stayed and are now 151 lines; the reasoning moved
to a *Why the rules are what they are* section in [README.md](README.md), where a
human reads it and an agent does not pay for it every session.

**`AGENTS.md` added** as a thin cross-vendor pointer, so the store is legible to
Codex, Cursor, Jules and the rest rather than Claude only. The spec is plain
Markdown, so forcing OKF frontmatter onto it would have broken the convention:
`bin/okf-lint.sh` now excludes the root `AGENTS.md` from its scan, and the file is
listed as a reserved meta-doc.

The `me/` pages ship **unfilled**, marked `filled: false`, with a `TODO:` and
their interview protocol intact — writing them would have meant inventing facts
about their subject.

`TODO:` how the store is reached from an agent — a pointer in a global
`CLAUDE.md`, a user-level skill, or an MCP server — is still undecided and wants
a decision record rather than a default.

## 2026-08-26 — scaffolded the work brain

Initial scaffold, adapted from a personal OKF + Karpathy knowledge store that had
run for roughly two months. What carried over unchanged: the three-layer
separation (immutable `raw/` / agent-owned concept tree / policy), the OKF file
contract, the relative-link rule, the reserved `index.md` and `log.md`, the four
operations, and the split between `bin/okf-lint.sh` (report, judgement) and
`--strict` (deterministic gate).

What is new for work:

- **[Confidentiality](CLAUDE.md).** An explicit never-capture list — secrets,
  customer/personal data, privileged material, HR and compensation — plus the
  rule that redaction happens *on capture*, because `raw/` is immutable and
  committed, so a secret pasted there is in git history for good.
- **Private-and-one-way.** The store is personal, sharing a page is a
  fork-and-scrub rather than a permission change, and nothing at work links back
  here. This is the work analogue of the source store's rule that project repos
  must never learn the store exists.
- **`decisions/` leads the taxonomy.** Turnover destroys *why* faster than
  anything else, and an ADR is the only artifact that outlives the people who
  made the call.
- **[Point, don't mirror](CLAUDE.md).** Work is full of systems of record, so the
  store keeps the reasoning that would be expensive to lose and links out for
  facts. Pages that do mirror a source carry a *derived snapshot, as of `<date>`*
  banner, and graduate to a pointer once the real home catches up. The source
  store learned this the slow way, over several rewrites of the same page.
- **Five sections, not nine.** `decisions/ systems/ runbooks/ references/
  people/`. In the source store, two of the most-used sections were not in the
  original scaffold at all — they were added when something had nowhere to go.
  *Adding a section* is now a documented operation instead of a guess.
- **Secret scanning in the pre-commit hook.** `bin/install-hooks.sh` runs the
  strict linter and then `gitleaks` or `trufflehog` on the staged diff if either
  is installed, warning when neither is.

`TODO:` decide where this repo lives (work-hosted git vs. personal) — that choice
is what actually enforces the privacy rule, and it has not been made.
