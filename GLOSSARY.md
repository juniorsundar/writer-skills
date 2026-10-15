# Writer Skills

A set of agent skills for planning long-form prose fiction. The skills plan; the author writes.

## Language

**Manuscript**:
The prose of the novel itself. Written only by the author; no skill writes prose into it (**Adopt** only imports the author's existing files verbatim).
_Avoid_: draft (when meaning the prose the skills produce: they produce none)

**Destination**:
Where the story is headed: ending state (one per **Volume** in a serial, plus a faint serial ending), **Scale**, **Grounding**, genre and its obligatory scenes, theme as a Lie → Truth argument, protagonist arc type, and the overarching plot in brief. Fixed enough to write toward; redrawn only by an explicit, logged act. Planning never starts without one.
_Avoid_: ending (the destination is more than the literal last scene)

**Volume**:
A run of chapters in a web serial with its own sharp ending and acts. A serial has a faint overall ending and a sharp ending per volume. Standalone novels have no volumes.
_Avoid_: book, arc (when meaning a volume)

**Scale**:
How wide or narrow the story is: target length, number of POV characters, geographic and temporal span, number of subplots. Recorded in the **Destination**; every skill sizes its ceremony to it (a narrow story gets a lean **Codex** and few tickets).
_Avoid_: scope (reserved for what is in or out of a planning effort)

**Grounding**:
What the story stands on that the author did not invent: source canon (fanfiction), historical events and periods, real places, real conditions, professions, real people. Listed in the **Destination**; facts resting on it come from research or a **Grounding policy**, never invention.
_Avoid_: background, references

**Grounding policy**:
The author's standing rules for their **Grounding**, set in the **Destination**: which kinds of fact the author vouches for from their own knowledge, which always need research, and any story-wide **Divergence** stance.
_Avoid_: exemption, whitelist

**Supersede**:
What a later chapter does to a **Codex** fact when the story moves it on (a goal shifts, someone dies, a name is revealed): the new fact replaces the old in its field, with the chapter cited. Unlike a contradiction, both were true at their point in the story.
_Avoid_: overwrite, correct

**Strand**:
Which line of the story a chapter belongs to: the main line, backstory in the same world, or an alternate timeline. Tagged per chapter in the outline; differences between strands are not contradictions.
_Avoid_: timeline (reserved for `codex/timeline.md`)

**Divergence**:
A deliberate, recorded departure of the story from its **Grounding** (an AU choice, a changed historical detail), noted on the **Codex** entry with what and why.
_Avoid_: error, inaccuracy (a divergence is intended)

**Redraw**:
The explicit act of changing the **Destination**: confirmed by the author, reason logged, followed by a sweep flagging **Codex** entries and **Threads** the change may invalidate.

**Map**:
The open questions standing between the current plan and the **Destination**. One per novel, persistent: it never fully closes while the book is unfinished. Holds only what is undecided.

**Codex**:
The store of settled story facts: characters, locations, world, timeline, **Threads**. Facts enter it the moment they are decided, whether in planning or discovered in the **Manuscript**.
_Avoid_: bible, story bible, lore

**Thread**:
Something the text has set up for later: a promise (Chekhov's gun), callback, foreshadowing, mystery, motif, or red herring. Carries a stable ID (`T07`), a MICE tag, an emphasis level, where it was planted and progressed, and a status: open, paid, or dropped.
_Avoid_: setup, plant (as nouns for the whole entry)

**Author voice**:
How the author writes sentences in one novel: rhythm, diction, distance, comedic devices. Captured per novel in the **Codex** once enough **Manuscript** exists, with a **Register** for each scene type the author deliberately writes differently. It evolves as the author confirms deliberate changes.
_Avoid_: style, tone (tone is the reader's felt register, recorded in the **Destination**), voice alone (character voice tags are a different thing)

**Register**:
A scene type (exposition, set-piece action, ritual) whose measurements the author confirms differ on purpose. It has its own baseline chapters, so its chapters are not flagged as deviations.
_Avoid_: variant, mode

**Voice anchor**:
A short excerpt of the author's own **Manuscript**, cited by chapter, that shows the **Author voice** at its most characteristic. Imitation and deviation checks compare against anchors, not adjectives.

**Passage**:
Short agent-written prose in the **Author voice** (a description, ambience) for one scene, written to `passages/` and never to the **Manuscript**. The author rewrites or pastes it in themselves.
_Avoid_: sketch (a sketch ticket is 2–3 alternatives to react to), draft, filler

**Chapter skeleton**:
The structure of one chapter, scene by scene, with no prose. The most detailed planning artifact: "plan, don't do" holds for every skill except `passage`, whose output is a **Passage**.
_Avoid_: chapter draft, scene draft, outline (outline is the whole-book plot)

**Summary**:
A reverse outline condensed from a finished **Manuscript** chapter: per scene, what happens, its function, its value shift, and the **Threads** it touches.
_Avoid_: recap, synopsis

**Adopt**:
Reverse-engineering a story written before these skills: condensing its existing **Manuscript** in order to build the **Codex**, then charting forward from the last written chapter.
_Avoid_: import (import is only Adopt's first step), onboarding

**Value shift**:
The change a scene causes in some charged value (trust → suspicion, safe → hunted). A scene with no value shift is flagged.

**Lens**:
A craft framework (four-act midpoint, promise/progress/payoff, MICE nesting, character arcs) used as a source of diagnostic questions, never as mandatory slots.
_Avoid_: template, beat sheet (when meaning something enforced)

## Relationships

- One repo holds exactly one novel (or one serial), one **Destination**, one **Map**, one **Codex**.
- A serial's **Destination** holds one ending per **Volume**; a **Chapter skeleton** sits in exactly one volume.
- The author writes the **Manuscript** from **Chapter skeletons**; no skill writes into it. **Passages** sit beside it, never inside.
- Each finished **Manuscript** chapter yields one **Summary**, which updates the **Codex** and **Threads** and may raise **Map** questions.
- **Codex** facts resting on **Grounding** link to the research file that backs them, or cite the author where the **Grounding policy** allows; departures are recorded as **Divergences**.
- **Summaries** and **Chapter skeletons** reference **Threads** by ID and **Codex** entries by link.

## Flagged ambiguities

- "bible" rejected as the term for the settled-facts store (too religious). Resolved: **Codex**.
- "voice" meant three things: a character's speech (voice tags), the reader's felt register (**Tone**), and how the author writes. Resolved: the last is **Author voice**.
