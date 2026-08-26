---
title: Reaching the store from an agent
description: How bin/install-pointer.sh wires the store into a Claude setup, and why a filesystem pointer rather than an MCP server.
---

# Reaching the store from an agent

How an agent finds and uses the store. The decision behind it is
[ADR 0002](../decisions/0002-filesystem-pointer-not-mcp-server.md).

`bin/install-pointer.sh` installs two things into your Claude config:

- a **user-level skill** at `~/.claude/skills/<label>/` — its description is
  always in context, its body loads only when a session is actually about the
  store, so unrelated sessions pay almost nothing;
- a **two-line pointer** in your global `~/.claude/CLAUDE.md` for discoverability.

Both are idempotent and marker-delimited, so re-running updates in place. Several
stores can live side by side under distinct `--label`s, each taking its blurb
from its own root `index.md`. Remove one with `--uninstall --label <name>`.

This is deliberately a **filesystem pointer rather than an MCP server**. The
maintenance loop needs to *write* — ingest, update indexes, prepend to the log,
run the linter, commit — and a path gives read, write, grep, and git history for
free, where an MCP resource would mostly give read. It is also the narrower
surface: a path only local Claude Code can see, rather than a server any
connected client can query. MCP earns its place only if you need the store from
somewhere that cannot see the filesystem.
