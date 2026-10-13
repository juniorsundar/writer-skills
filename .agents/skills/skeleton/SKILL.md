---
name: skeleton
description: Grill and plan one chapter as a scene-by-scene chapter skeleton, without writing prose.
disable-model-invocation: true
---

Plan **one chapter** at a time. A **Chapter skeleton** is the structure, not the Manuscript: the author writes the prose.

## Refuse while affected questions are open

Before planning, inspect `map/tickets/`. If any ticket not yet `Status: resolved` (open or claimed) has an `Affects:` item that covers this chapter, list those tickets and stop. An item covers the chapter when it names it (`chNN`), or names the act, volume, or volume ending the outline places it in (`act II`, `vol 1`, `vol 1 act II`, `vol 1 ending`; an ending is its volume's last act). If the outline cannot place the chapter, treat the act or volume item as covering it. Ask the author to resolve them first. Do not guess around open questions.

## Plan, don't do

Read `codex/destination.md`, `codex/outline.md`, relevant Codex entries and `codex/threads.md`, plus prior `summaries/chNN.md`. Check the chapter's position against the four-act shape and midpoint as a diagnostic, not a required beat. Call the Skill tool for "grilling" and "codex"; the author decides. Use [LENSES.md](../codex/LENSES.md) as questions, not mandatory slots. New settled facts go into Codex via the "codex" Skill. New unresolved questions become Map tickets through "storymap".

Create `skeletons/chNN.md`:

```markdown
# ch07 — <working title>
POV: Mara (close third) · Where/when: … · Act/position: II-a, pre-midpoint
Hook-in: …                      Hook-out: …
## Scene 1
Goal / Conflict / Disaster: …
Crisis (the impossible choice): …   Value shift: trust → suspicion
Sequel (reaction → dilemma → decision): … (or "compressed")
Setting function: …   Dialogue wants/tactics (no lines): …
Threads: plants T12 · progresses T07   Codex: [[mara]], [[the-archive]]
```

Use one scene section per scene. Ask about goal, conflict, disaster/turn, crisis and enacted choice, value shift, sequel function, setting pressure, dialogue wants/tactics, chapter hook, and Threads. P/P/P is a diagnostic for progress and payoff. Bridge scenes may leave fields blank with a note. A one-scene chapter is fine.

## Fog of war

Do not settle facts by implication or invent missing Codex canon. Keep the skeleton at the ceiling of “plan, don't do.” New open questions are tickets, not fabricated answers.

## Scope

One chapter per session. The whole-book plan lives in `codex/outline.md`, owned by Storymap.
