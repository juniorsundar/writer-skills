---
name: condense
description: Condense finished manuscript chapters into reverse-outline Summaries and update continuity records; Adopt reverse-engineers an existing story into a Codex.
disable-model-invocation: true
---

Input is finished Manuscript: `manuscript/chNN.md`. Read it only. This skill creates **Summaries**, updates settled facts and Threads, and flags questions for the author. Size the ceremony to the novel's Scale.

Three modes. **Condense** handles one new chapter in a charted repo. **Adopt** reverse-engineers an existing story that has no Codex yet: for Adopt, read [ADOPT.md](./ADOPT.md) and follow it instead of the steps below. **Voice** runs step 7 alone; when `codex/voice.md` already exists, it runs one probe session on its unconfirmed features instead.

## Condense

1. Read the chapter, `codex/destination.md`, relevant Codex entries, `codex/threads.md`, outline, prior summaries, and `skeletons/chNN.md` if it exists. Call the Skill tool for "codex" and "grilling" when facts or author decisions need settling. Consult [LENSES.md](../codex/LENSES.md) for diagnostic questions.
2. Write `summaries/chNN.md` as a [reverse outline](https://owl.purdue.edu/owl/general_writing/the_writing_process/reverse_outlining.html): per scene, record what happens, its function, value shift, and Threads touched by ID. Note drift from the chapter's skeleton, if any.
3. Update `codex/threads.md`: record new plants, progress, and payoffs; replace any `(planned)` placement this chapter fulfils with the real chapter. Maintain stable IDs and statuses. Add settled new facts straight to the appropriate Codex entries.
4. Raise contradictions with the Codex as questions to the author: two facts that cannot both hold at the same point in the same **Strand**. Never silently fix either side; the author decides which wins. A fact the story has moved on is **Superseded**, not contradicted (codex skill). If a change moves plot or Destination, raise a Map ticket with Storymap.
5. Run a continuity check: overdue Threads; high-emphasis unpaid Threads; MICE Threads closed out of nesting order; characters acting against their Codex entry without a visible choice; scenes with no value shift; and real-world or canon claims with no backing research, unrecorded Divergences, or known misportrayals (Grounding lens). Unbacked claims become research per the codex skill's "Ground, don't invent" rule. Flag findings; do not force a fix.
6. When `codex/voice.md` exists, run `../codex/scripts/voice-stats.sh --outliers <Baseline chapters> -- manuscript/chNN.md` (path relative to this skill). If the summary's scenes match a **Register** in voice.md, use that register's Baseline instead. Flag every measured-threshold breach and deviation from a confirmed feature, asking one question per deviation: “chNN does X against your confirmed Y. Deliberate?” Deliberate: update the profile and cite this chapter. Mistake: leave the profile and flag the passage for the author. Record tolerant and unconfirmed observations without enforcement. A deliberate scene-type shift becomes a Register.
7. If three or more Manuscript chapters now exist and `codex/voice.md` does not, capture it once as described in [FORMATS.md](../codex/FORMATS.md), marking sections `_Inferred:_` for author confirmation. Start from `voice-stats.sh --table manuscript/ch*.md`. Run the first probe session as a dedicated session. Below three chapters, create no voice entry or voice check.

## Summary shape

```markdown
# chNN — <title from the outline line>

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
