# Adopt

For a story written before these skills: build the Codex from the Manuscript, then hand off to Storymap to chart forward. The Manuscript is the source of truth here; the Codex starts empty, so it records rather than challenges.

1. **Import.** Ask the author where the story lives. Map it into `manuscript/ch01.md`, `ch02.md`, … in reading order by symlink or verbatim copy; split a single file only at the author's chapter breaks. Import never alters a word. Write the chapter list as the first draft of `codex/outline.md`, one line per chapter with its original title, its volume heading, and its **Strand** when not main (see Storymap's outline format). Confirm the list with the author; ask the Strand of any interlude or out-of-sequence chapter the author has not named.
2. **Sort the author's other material.** Planning notes, research, prefaces and plot plans each take one role: research becomes a `source:`; a plan for a written chapter becomes the baseline its summary's drift is measured against; a plan for unwritten chapters becomes a candidate for Chart; a stated stance becomes part of the Grounding policy. Facts enter the Codex from the prose alone. Then settle a draft **Grounding policy** with the author in `codex/destination.md`: what they vouch for, what always needs research. None of the author's files are edited.
3. **Condense in order.** For each chapter from the first without a summary: run Condense steps 2–3 (summary, Threads, new Codex facts) and the Grounding check from step 5, measuring drift against the chapter's plan if one exists. Skip the overdue-Thread check: nothing has a due date yet. Append to `map/adopt-queue.md` (create `map/` on the first entry): a later chapter contradicting an earlier one in the same Strand (chapter, both versions, the Codex entry), and each Grounding flag. A chapter is done when its summary and Codex changes match the page: who did what to whom, named versus epithet, claimed versus stated. Adopt is resumable: the chapters with summaries are done. For a Manuscript larger than one context, follow **Batches** below.
4. **Draft the plan.** Done when every Manuscript chapter has a summary. First consolidate: every Codex entry reads as current state, and every Thread the page answered is paid. Then write:
   - `codex/outline.md`: add to each chapter's line what it does and the Threads it touches. Leave act positions to the author.
   - `codex/destination.md`: an inferred draft of Scale, genre, tone, theme, and arc type, each section headed `_Inferred:_` with the chapters it rests on; Grounding is already settled. Infer the ending of each finished volume; leave the rest `_Open._`: where the story goes next is the author's call. This draft predates the Map, so its `_Open._` sections need no Not yet specified items until Chart creates them.
5. **Hand off.** Tell the author to run Storymap's Chart mode, which confirms the draft Destination, turns the queue's open entries, research lines and open Threads into tickets, and charts forward from the last written chapter.

## The adopt queue

Each entry: `## QNN · inconsistency|grounding · chNN`, then `Claim/versions:`, `Codex entry:`, `Note:`, `Status: open`. When the author settles one, record the decision in the Codex (a Divergence carries its why) and set `Status: settled. <gist>`; add a `→ research: <question>` line for anything settled as needing research.

## Batches

When the Manuscript exceeds one context, condense each chapter in a **fresh context**: a subagent, a new session, or a cleared context, whichever the harness offers. Every unit gets the same brief, saved as `map/adopt-brief.md` so a resumed run reuses it. The brief carries the steps above, the evidence rule, the Grounding policy, and every convention the author has settled so far.

- **Unit**: one chapter. It reads the Codex as the previous chapter left it.
- **Checkpoint**: after each unit, confirm its summary exists and the count of Thread IDs has not dropped, then save the state (a commit, or a copy) before the next unit. A unit that fails or stops partway is discarded back to the last checkpoint and redone.
- **Calibration**: run the first three chapters, then stop for the author to review the summaries and Codex shape. Fold their corrections into the brief.
- **Batch**: about ten chapters, or fewer when the author asks. At the end of each batch, verify each chapter against the page (a fresh-context reviewer is ideal), then settle that batch's open queue entries with the author and fold every new convention into the brief before the next batch.
