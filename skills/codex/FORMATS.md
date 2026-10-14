# Codex entry formats

Create only the entries the story needs. These are decision aids, not required fields to fill mechanically. Link entries with Obsidian wikilinks; note first-reveal chapter and reader-knowledge level where useful.

Any entry may carry knowledge fields when the story runs on who knows what (dramatic irony, secrets, mysteries):

- `Known to: <characters or groups>` and `Hidden from: <characters or groups>`, each with the chapter or volume where that changes.
- `Reader knows:` when the reader's knowledge differs from every character's.

Any entry may carry two Grounding fields:

- `source: [[research/<topic>]]`: the research file that backs a real-world or canon fact. `source: author` instead only for a kind of fact the Destination's **Grounding policy** lists.
- `Diverges: <what>, because <why>`: a deliberate **Divergence** from Grounding. Settle the why with the author when the Divergence is settled.

## Destination — `codex/destination.md`

```markdown
# Destination

## Ending state
- Serial (faint; serials only):
- Vol N (sharp; one line per planned volume, serials only):
## Scale
- Target length:
- POV count:
- Geographic / temporal span:
- Subplot count:
- Width: narrow | wide
- Volumes (serials only):
## Grounding
- <source canon / event / place / condition / profession / person>: [[research/<topic>]]
- Policy: <kinds of fact the author vouches for (source: author)>; <kinds that always need research>; <story-wide Divergence stance, with why>
## Genre and obligatory scenes
## Tone
## Theme: Lie → Truth
## Protagonist arc: positive | flat | disillusionment | fall | corruption
## Overarching plot
```

A standalone novel has one ending state. A web serial has a faint serial ending plus a sharp ending per **Volume**: each volume ends on a turn, not only an achievement. Unsettled sections read `_Open._` with a matching item in the Map's Not yet specified. Tone is the reader's felt register (e.g. light-hearted despite grimdark), distinct from genre. The last three arc types are Weiland's negative arcs: disillusionment learns a hard Truth and stays sympathetic; fall and corruption embrace the Lie.

Record the ending state and plot in enough detail to plan toward, not as prose. Scale determines the ceremony of every skill: narrow means lean Codex and few tickets; wide means fuller machinery.

## Character — `codex/characters/<name>.md`

```markdown
# <Name>
- Identity (when the prose withholds who they are): <true identity>; named on the page from chNN | not yet | never
- Role / story function:
- Want vs. Need:
- Ghost / Wound → Lie:
- GMC: goal / motivation / conflict
- Arc: positive | flat | disillusionment | fall | corruption; endpoint:
- Proactivity / likability-or-relatability / competence: low–high
- Voice tags: <2–3>
- Relationships as forces; competence domain and limits:
- First reveal / reader knowledge (if useful):
```

Keep only decision-driving fields. Appearance and other continuity trivia are filled lazily when fixed by the Manuscript. Summaries and skeletons call a character what the prose calls them at that chapter; the Identity field alone holds what the page withholds.

## Ensemble — `codex/characters/<group>.md`

A group that functions as one story unit, such as a POV ensemble of castaways.

```markdown
# <Group>
- Role / story function:
- Shared goal and shared arc:
- Members: one line each; promote a member to their own character entry once they carry decisions alone
- POV carriers:
- Internal fault lines:
```

## Location — `codex/locations/<name>.md`

```markdown
# <Name>
- Setting as pressure (how it constrains choices):
- Sensory anchors:
- First reveal / reader knowledge (if useful):
```

## World, magic, or technology — `codex/world/<topic>.md`

```markdown
# <Topic>
- Limits:
- Costs / consequences:
- Powers or capabilities (only as needed):
- Reader-knowledge level:
- First reveal (if useful):
```

Prefer limits to powers. For magic that resolves conflict, track how much the reader understands; mysterious magic can complicate, not conveniently resolve. Expand existing elements before adding new ones.

## Timeline — `codex/timeline.md`

Record dated or ordered events only when sequence matters to continuity. Use a consistent date/time convention and link people, places, and Threads. Flag uncertainty instead of inventing precision.

## Research — `research/<topic>.md`

Research files sit outside the Codex: they record the world's or the source's truth, and the Codex records the story's. Brief for every research subagent:

- Answer the question the story leans on, citing a source per claim. Prefer primary sources: original canon text, archives and historians, clinical and lived-experience sources over pop articles.
- Source canon (fanfiction) goes in `research/canon/<topic>.md`, citing work and chapter or episode.
- For real conditions, cultures, traumas, or living people, add a `## Common misportrayals` section: stereotypes and tropes the affected community objects to.
- Flag where sources disagree or are uncertain; never smooth over it.
- Done when every question asked is either answered with a source or listed under `## Unanswered`. Write each promised file before reporting.
- When the research resolves a ticket, append `## Answer` (a gist plus a link to the research file) and set `Status: resolved`. The dispatching agent appends the gist to the Map's Decisions so far.

## Thread ledger — `codex/threads.md`

One entry per promise, callback, foreshadow, mystery, motif, or red herring. IDs are stable. Kinds: `promise`, `callback`, `foreshadow`, `mystery`, `motif`, `red-herring`. MICE tag: `M` (Milieu), `I` (Inquiry/Idea), `C` (Character), or `E` (Event). Status is `open`, `paid (chNN)`, or `dropped (reason)`. Before chapters exist, `planted:` and `due:` take any `Affects:` value marked `(planned)` (e.g. `planted: vol 1 act II (planned)`). Condense replaces the marker with the real chapter once the Manuscript plants it.

```text
T07 · promise · E · emphasis: high · due: by ch18
  planted: ch03 — Mara pockets the brass key from her father's desk
  progress: ch09 (key mentioned, unused)
  status: open
```

Track each meaningful recurrence, not just first and last appearance. High emphasis creates a stronger expectation of payoff; a red herring is deliberate, not an unacknowledged dropped promise.
