---
name: codex
description: Maintain the fiction Codex of settled facts, challenge contradictions, sharpen vague claims, and record decisions as they settle.
---

The **Codex** is the store of settled story facts. It is an active discipline during every planning session, not an encyclopedia: keep only decision-driving facts and continuity the story needs. Create files lazily, at the scale the Destination calls for.

## During the session

- Challenge claims that contradict the Codex. Surface the mismatch and ask which fact is true; never silently overwrite either side.
- Sharpen vague facts and test them with edge cases: “What does Mara do if the key is lost?”
- Write facts the moment they settle, whether discovered in planning or from the Manuscript. Record first-reveal chapter and reader-knowledge level when useful.
- Add only what helps decide or preserve story continuity. Defer trivia such as appearance until the Manuscript fixes it.
- Use the formats in [FORMATS.md](./FORMATS.md).

## Ground, don't invent

When a fact rests on **Grounding** (source canon, history, a real place, condition, profession, or person), check `research/` first and cite it with `source: [[research/<topic>]]`. If research doesn't cover it, never invent the fact:

- **A decision in this session depends on it**: dispatch a background research subagent (Skill tool, "research", with the brief in FORMATS.md) and keep grilling whatever doesn't depend on it.
- **Nothing depends on it yet**: raise a research ticket on the Map via Storymap.

When the story departs from its Grounding, record a **Divergence** on the entry (what and why). An unrecorded departure is a contradiction to raise, not a choice.

## Codex shape

```text
codex/
  destination.md
  outline.md
  threads.md
  timeline.md
  characters/
  locations/
  world/
```

Use Obsidian wikilinks for Codex entries. A **Thread** has a stable ID and one ledger entry; skeletons and summaries refer to Threads by ID.

## Iceberg

The Codex records what the story needs, not everything that could be true. The Destination changes only through an author-confirmed Redraw in Storymap.

The diagnostic questions every planning skill draws on are in [LENSES.md](./LENSES.md).
