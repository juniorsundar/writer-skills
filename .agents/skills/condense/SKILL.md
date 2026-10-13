---
name: condense
description: Condense finished manuscript chapters into reverse-outline Summaries and update continuity records; Adopt reverse-engineers an existing story into a Codex.
disable-model-invocation: true
---

Input is finished Manuscript: `manuscript/chNN.md`. Read it only. This skill creates **Summaries**, updates settled facts and Threads, and flags questions for the author. Size the ceremony to the novel's Scale.

Two modes. **Condense** handles one new chapter in a charted repo. **Adopt** reverse-engineers an existing story that has no Codex yet.

## Condense

1. Read the chapter, `codex/destination.md`, relevant Codex entries, `codex/threads.md`, outline, prior summaries, and `skeletons/chNN.md` if it exists. Call the Skill tool for "codex" and "grilling" when facts or author decisions need settling. Consult [LENSES.md](../codex/LENSES.md) for diagnostic questions.
2. Write `summaries/chNN.md` as a [reverse outline](https://owl.purdue.edu/owl/general_writing/the_writing_process/reverse_outlining.html): per scene, record what happens, its function, value shift, and Threads touched by ID. Note drift from the chapter's skeleton, if any.
3. Update `codex/threads.md`: record new plants, progress, and payoffs; replace any `(planned)` placement this chapter fulfils with the real chapter. Maintain stable IDs and statuses. Add settled new facts straight to the appropriate Codex entries.
4. Raise contradictions with the Codex as questions to the author. Never silently fix either side; the author decides which wins. If a change moves plot or Destination, raise a Map ticket with Storymap.
5. Run a continuity check: overdue Threads; high-emphasis unpaid Threads; MICE Threads closed out of nesting order; characters acting against their Codex entry without a visible choice; scenes with no value shift; and real-world or canon claims with no backing research, unrecorded Divergences, or known misportrayals (Grounding lens). Unbacked claims become research per the codex skill's "Ground, don't invent" rule. Flag findings; do not force a fix.

## Adopt

For a story written before these skills: build the Codex from the Manuscript, then hand off to Storymap to chart forward. The Manuscript is the source of truth here; the Codex starts empty, so it records rather than challenges.

1. **Import.** Ask the author where the story lives. Map it into `manuscript/ch01.md`, `ch02.md`, … in reading order by symlink or verbatim copy; split a single file only at the author's chapter breaks. Import never alters a word. Confirm the chapter list with the author before going on.
2. **Condense in order.** For each chapter from the first without a summary: run Condense steps 2–3 (summary, Threads, new Codex facts) and the Grounding check from step 5. Skip the overdue-Thread check: nothing has a due date yet. A later chapter contradicting an earlier one is a Manuscript inconsistency: append it to `map/adopt-queue.md` (chapter, both versions, the Codex entry) rather than asking mid-run (create `map/` and the queue on the first entry). Adopt is resumable: the chapters with summaries are done.
3. **Draft the plan.** Done when every Manuscript chapter has a summary. Then write:
   - `codex/outline.md`: one line per existing chapter (what it does, Threads it touches). Leave act positions to the author.
   - `codex/destination.md`: an inferred draft of Scale, Grounding, genre, tone, theme, and arc type, each section headed `_Inferred:_` with the chapters it rests on. Leave the ending `_Open._`: where the story goes next is the author's call. This draft predates the Map, so its `_Open._` sections need no Not yet specified items until Chart creates them.
4. **Hand off.** Tell the author to run Storymap's Chart mode, which confirms the draft Destination, turns the adopt queue and the open Threads into tickets, and charts forward from the last written chapter.

## Summary shape

```markdown
# chNN — <working title>

## Scene 1 — <identifier or brief label>
- What happens:
- Function:
- Value shift:
- Threads: T07, T12

## Continuity and drift
- ...
```

Use the leanest form that preserves useful retrieval. A Chapter skeleton is a plan, not a constraint that overwrites what the Manuscript actually did.

## Evidence, then ask

The Manuscript is evidence. Record what it shows, and let the author decide which discrepancies become canon.
