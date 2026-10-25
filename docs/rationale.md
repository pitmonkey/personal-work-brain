---
title: Why the rules are what they are
description: The reasoning behind the rules in CLAUDE.md that look arbitrary.
---

# Why the rules are what they are

[CLAUDE.md](../CLAUDE.md) states the rules; this page holds the reasoning behind the ones that look arbitrary. It lives here rather than in the policy so a human can read it without an agent paying for it in every session.

**Three layers, strictly separated.** Mixing immutable sources, derived concepts, and the policy governing both is what turns note stores into sludge. Sources can be trusted precisely because they are never edited; concepts can be rewritten freely precisely because the sources survive.

**Fewer, denser pages.** Thin pages fragment a topic across files nobody reassembles. This cuts against the atomic-note tradition deliberately: atomicity optimises for linking, density optimises for an agent loading one page and having the whole picture.

**`decisions/` leads.** Turnover and time destroy _why we did it this way_ faster than anything else. Code, tickets, and dashboards all record what is true now; almost nothing records the options that lost. An ADR outlives the people who made the call.

**Point, don't mirror.** Duplicating a system of record produces a page that is wrong within a fortnight and that nobody trusts. Worse, a stale page is not neutral — it hands an agent confident but wrong context.

**Relative links, never wikilinks.** Wikilinks are more pleasant to type and bind you to one editor. Relative links keep the bundle portable while Obsidian renders the graph anyway.

**Private, and one-way.** Candour is the whole value of a personal store, and candour survives only while the audience is one person. Nothing shared may depend on a store only you can read.

**A context budget on the instruction files.** `CLAUDE.md`, `AGENTS.md`, and the skills are loaded into context rather than searched, so every line is paid for in every session that touches the store — unlike a concept page, which costs nothing until something reads it. Published guidance on agent-instruction files puts the point of diminishing returns near 150 lines; this store budgets **200**, trading a little efficiency for rules that stay legible. The linter reports overruns as advisory, never blocking, and `OKF_CONTEXT_BUDGET` overrides it. The pressure valve is that rationale belongs in this README and rules belong in `CLAUDE.md` — when the budget bites, move explanation here rather than deleting a rule.

**Todos live where you will see them.** Most people keep their todos in the day's note, typed as the day goes, and a store that forbade that would push the list somewhere the agent cannot read. So the store may hold todos — see [ADR 0004](../decisions/0004-store-tracks-todos-via-daily-notes.md). The one exception is preference, not ban: an item someone else is waiting on belongs where _they_ can see it, so if you have a tracker it is offered there, and the store keeps a link rather than a copy. Two lists that both hold the item is how neither gets trusted.
