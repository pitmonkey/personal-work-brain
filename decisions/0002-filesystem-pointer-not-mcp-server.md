---
type: Decision
title: "ADR 0002 — Reach the store by filesystem pointer, not an MCP server"
description: Agents reach the store through a user-level skill and a path, rather than through an MCP server exposing it as a resource.
status: active
tags: [adr, mcp, agents, access, scaffold]
timestamp: 2026-08-26
---

# ADR 0002 — Reach the store by filesystem pointer, not an MCP server

**Status:** Accepted — 2026-08-26. Inherited from the scaffold.

## Context

A knowledge store nobody's agents can reach is just a folder of documents. Some
mechanism has to tell an agent that the store exists, where it is, and how to use
it — otherwise every session starts by re-explaining it, which is the friction
the store was built to remove.

## Options considered

1. **Paste content in manually.** No setup, works everywhere, and completely
   defeats the point — the user does the retrieval, every time.
2. **Describe the store in the global agent config.** A block in the user's
   global `CLAUDE.md`. Simple and always available, but it is loaded into *every*
   session, including the majority that have nothing to do with the store. The
   fuller the description, the higher the standing cost.
3. **A user-level skill, plus a two-line pointer.** (Chosen.) The skill's
   description sits in context always; its body loads only when a session is
   actually about the store. The global pointer stays tiny and exists only for
   discoverability.
4. **An MCP server exposing the store as a resource.** Works across clients and
   over a network; any MCP-capable agent can read it without filesystem access.

## Decision

**Option 3.** Agents reach the store through a **path on the filesystem**,
advertised by a user-level skill that `bin/install-pointer.sh` installs.

Three things decided against MCP:

- **The maintenance loop writes.** Ingesting a source means updating concepts,
  updating an index, appending to the log, running the linter, and committing. A
  filesystem path gives read, write, grep, and git history for free. A typical MCP
  resource exposure gives read. Serving the store over MCP would turn a
  *maintained* store into a *lookup table*.
- **Blast radius.** A path that only a local agent can see is a narrower surface
  than a server any connected client can query. For a store whose whole value
  rests on being private enough to be candid in, fewer access paths is the
  correct direction.
- **Reach is MCP's only real advantage**, and it is reach from clients that
  cannot see the filesystem — which for a private store is the case to avoid, not
  to enable.

## Consequences

- The store works wherever the agent has filesystem access to it, and nowhere
  else. Getting at it from a phone, a web client, or another machine is not
  supported.
- Setup is one script and no running process. Nothing to serve, authenticate,
  monitor, or keep patched.
- The agent has **write** access to the store, deliberately. The confidentiality
  rules in [CLAUDE.md](../CLAUDE.md) are the control, not the access boundary.
- Multiple stores coexist under distinct labels, each advertised by its own skill.

## When to revisit

Revisit if the store is genuinely needed from a client that cannot see the
filesystem, or if it stops being single-reader — at which point the selective
exposure MCP offers becomes a feature rather than an extra surface. Superseding
this ADR then is the right move; editing it is not.

## Related

- `bin/install-pointer.sh` and the `init` skill implement this decision.
