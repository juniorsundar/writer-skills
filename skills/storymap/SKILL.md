---
name: storymap
description: Plan one long-form fiction novel as a persistent map of open decision tickets, from a settled destination toward chapter skeletons.
disable-model-invocation: true
---

A novel is too large for one planning session, and the way from here to its **Destination** is partly fogged. **Storymap** charts that way as a persistent **Map** of decision tickets. The author writes the **Manuscript**; this skill plans, never writes prose.

## Plan, don't do

The **Destination** is settled first, recorded only in `codex/destination.md`, and linked from `map/map.md`. The Map never duplicates it and never fully closes while the book is unfinished. The Destination records ending state (for a serial: a faint serial ending plus a sharp ending per **Volume**); **Scale** (target length, POV count, geographic and temporal span, subplot count, wide or narrow); **Grounding** (source canon, historical events, real places, real conditions, professions, real people the story stands on); genre and obligatory scenes; tone; theme as Lie → Truth; protagonist arc type; and overarching plot in 1–3 paragraphs. Scale sizes every skill's ceremony: a narrow story gets a lean Codex and few tickets; a wide story gets the full machinery.

Planning produces decisions, Codex facts, tickets, an outline, and chapter skeletons—not Manuscript. Call the Skill tool for "codex" as the active discipline throughout every session: challenge contradictions, sharpen facts, and record each settled fact immediately. Use the minimum machinery Scale can support. Draw grilling questions from [LENSES.md](../codex/LENSES.md): diagnostics, never mandatory beats. Formats for every Codex file are in [FORMATS.md](../codex/FORMATS.md).

## Novel repo

One repo holds one novel, one Destination, one Map, and one **Codex**. Create this layout lazily, only as files are needed:

```text
codex/{destination.md, outline.md, threads.md, timeline.md, characters/, locations/, world/}
map/{map.md, tickets/}
research/<topic>.md  # sourced real-world facts
research/canon/<topic>.md  # source-canon facts (fanfiction)
skeletons/chNN.md
summaries/chNN.md
manuscript/chNN.md  # author only; skills never write prose here (condense Adopt imports verbatim)
```

Use Obsidian wikilinks such as `[[mara]]` for Codex references.

## Map and tickets

`map/map.md` links to `[[destination]]` and has `## Notes`, `## Decisions so far`, `## Not yet specified`, and `## Out of scope`. It indexes settled decisions without restating the Destination. Fog is in-scope but not yet sharp enough to ticket; ticket a question as soon as it can be stated precisely. Out-of-scope work never graduates unless the Destination is redrawn.

Tickets are `map/tickets/NN-slug.md`, numbered from 01, with this header and body:

```markdown
Type: grilling|research|sketch|task
Status: open|claimed|resolved
Blocked by: NN, NN
Affects: ch07, ch09

## Question

...
```

`Affects:` is a comma-separated list; each item is `chNN`, `act <I-IV>`, `vol N`, `vol N act <I-IV>`, or `vol N ending`. An act or volume covers every chapter the outline places in it; write a range as separate items (`vol 1 act I, vol 1 act II`). On resolution append `## Answer`, set status resolved, and append to Decisions so far one line of the form `[[ticket]]: <one clause, at most 25 words> [[detail]]`; the detail lives in the Answer and the Codex. Claim first by setting `Status: claimed`. Wire `Blocked by` only after all tickets exist; a ticket is on the frontier when open, unclaimed, and every blocker is resolved. List it with this skill's bundled `scripts/check.sh --frontier <novel>`.

## Ticket types

- **Grilling** (HITL, default): call the Skill tool for "grilling" and "codex". The author makes the decisions; never answer for them.
- **Research** (AFK): investigate real-world facts the story leans on. Dispatch research subagents to call the Skill tool for "research", passing the research brief in [FORMATS.md](../codex/FORMATS.md); record findings in `research/<topic>.md` or `research/canon/<topic>.md`.
- **Sketch** (HITL, replaces prototype): offer 2–3 cheap alternatives for the author to react to: outline-level plot turns, backstory chains, or interview the author-as-character. Never write prose.
- **Task** (HITL or AFK): manual work that must happen before a decision can be made. The agent does it alone where it can (AFK: e.g. collate every codex mention of a character); otherwise it hands the author a precise checklist (HITL: read a comp title, visit a place, write a test scene themselves). Record what was done and the resulting facts, never author-written prose.

## Fog of war

Do not ticket what cannot yet be phrased as a decision. Record that patch in Not yet specified; resolving frontier tickets may make it sharp. Charting is breadth-first, not an attempt to plan every chapter in advance.

## Outline and chapter numbers

`codex/outline.md` is one line per planned chapter, noting act position and Threads it plans to plant/pay. A written chapter's line starts `- chNN — <title> ·` and carries a **Strand** tag after the title when it is `backstory` or `alternate` (main is the default): `- ch10 — Born of Blood · alternate · …`. Summaries take their title from this line. A serial groups chapters under `## Vol N` headings, each volume with its own acts; chapter numbers run continuously across volumes. Chapter numbers stay provisional until drafted. Renumbering requires a mechanical sweep across outline, tickets, skeletons, and summaries.

## Invocation

Three modes. Work resolves one ticket per session, except research.

### Chart

1. Call the Skill tool for "grilling" and "codex" to settle the Destination. If condense Adopt left a draft, confirm or correct each `_Inferred:_` section with the author instead of starting blank. Grill breadth-first. Fire research subagents mid-grill when a question waits on a fact. Done when Scale (including width and, for a serial, volumes), Grounding, genre, tone, and arc type are settled, and the ending is sharp for the first volume (or the whole book, if not a serial). Every other section may read `_Open._` with a matching item in Not yet specified.
2. Write `codex/destination.md`; create `map/map.md` with its link, Notes, Decisions so far, Not yet specified, and Out of scope.
3. Create currently specifiable tickets, including, after condense Adopt, one per `Status: open` entry and one research ticket per `→ research` line in `map/adopt-queue.md` (if present; settled entries are already recorded in the Codex; then delete the queue) and per open Thread that needs a decision, and wire `Blocked by` in a second pass. Seed a research ticket for each Grounding item the plan leans on, then dispatch one subagent per research ticket with the research brief. Each subagent resolves its own ticket; append each gist to Decisions so far, and check that every promised research file exists.
4. Stop. Charting resolves only research tickets.

### Work

1. Load the Map and Destination; choose the first frontier ticket or the ticket the author named. Claim it before work.
2. Resolve it by its type. Read related Codex entries as needed; call the named Skills.
3. Record the answer, append to Decisions so far, graduate newly sharp fog into tickets, and clear that fog. Resolve only one ticket, except research. The author may chain straight into another ticket; the agent never starts the next one itself.

Filling an `_Open._` or faint section of the Destination is ordinary Work: record it there and in the Answer. Changing anything already settled is a Redraw.

### Redraw

Only redraw on an explicit, author-confirmed change to a settled part of the Destination (ending, Scale, genre, tone, theme, arc type, or plot spine). Log the reason in `map/map.md`, then sweep for Codex entries, Threads, and tickets the change may invalidate. Raise questions as tickets; do not silently edit affected canon or decisions.

## Index, not store

The Map holds open questions and gists that link to their detail; every decided fact lives once, in the Codex or a ticket's Answer.
