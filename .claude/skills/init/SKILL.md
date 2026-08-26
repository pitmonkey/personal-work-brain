---
name: init
description: Set this store up on a machine — wire it into the user's Claude config with a user-level skill and a global CLAUDE.md pointer, install the git hooks, and check what still needs filling in. Run once per machine; safe to re-run.
---

# Init

One-time setup for this store on a machine. **Not one of the four operations** —
those act on the concept tree; this acts on the machine around it. Safe to
re-run: everything it does is idempotent.

## Steps

### 1. Wire the store into the user's Claude config

Two artifacts, installed by `bin/install-pointer.sh`:

- **A user-level skill** at `~/.claude/skills/<label>/SKILL.md`. This is the
  load-bearing part. Its *description* sits in context in every session, but its
  *body* loads only when a session is actually about the store — so the user does
  not pay for the full instructions in unrelated sessions.
- **A two-line pointer** in the global `~/.claude/CLAUDE.md`, for discoverability.
  Deliberately tiny; the skill carries the detail. `--no-claude-md` skips it.

**Always dry-run first and show the user before writing.** These files live
outside the repo, in the user's global config:

```
bin/install-pointer.sh --dry-run
```

Show them the proposed skill and pointer block, then apply once they agree:

```
bin/install-pointer.sh
```

**If the user already keeps other knowledge stores** (a personal second brain is
the common case), check `~/.claude/CLAUDE.md` for existing
`<!-- BEGIN claude-brain pointer: ... -->` blocks first. Each store needs a
**distinct `--label`**; stores installed under the same label overwrite each
other. The blurb is read from each store's own root `index.md` `description:`,
so side-by-side stores describe themselves correctly — override with
`--description` if that frontmatter is wrong or missing.

To remove: `bin/install-pointer.sh --uninstall --label <label>`.

### 2. Install the git hooks

```
bin/install-hooks.sh
```

Wires the strict OKF gate plus a secret scan into a pre-commit hook.

### 3. Check for a secret scanner

`install-hooks.sh` reports whether `gitleaks` or `trufflehog` is on PATH. If
neither is, **say so plainly and recommend installing one before the first
ingest.** `raw/` is immutable and committed, so the hook is the last cheap place
to stop a pasted credential from entering history permanently. Do not treat a
missing scanner as a detail.

### 4. Report what still needs filling

- Any page in `me/` with `filled: false` — these are read at the start of every
  task, so an unfilled context layer is the biggest gap on a fresh store. Offer
  to run the interview embedded in each page, starting with `identity.md` then
  `communication-style.md`.
- Whether `decisions/` is still empty. The most useful first page is usually a
  choice already made, written up while the reasoning is still recoverable.

### 5. Verify and log

Run `bin/okf-lint.sh` and confirm a clean report. If init changed anything inside
the repo, prepend a `log.md` entry; wiring the user's machine alone is not a
change to the store and does not need one.

## Guardrails

- **Never write outside the repo without showing the user first.** The global
  `CLAUDE.md` and `~/.claude/skills/` belong to them, not to this store.
- **Never put store content in the global pointer** — a path and a rule, nothing
  more. The pointer is loaded into every session, including ones the store's
  confidentiality rules never anticipated.
- The pointer gives an agent filesystem access to the store, which is read
  **and write** — that is deliberate, since the maintenance loop needs to write.
  If the user asks about exposing the store over MCP instead, that is a different
  trade-off and wants a `Decision` page, not a default.
