# Writer Skills

Agent skills for planning long-form prose fiction. The skills plan; the author writes the prose.

A novel is too large for one session, so the plan lives **on disk** rather than in anyone's head. One repo holds one novel: a settled **Destination**, a persistent **Map** of open decision tickets, a **Codex** of settled facts, chapter **Skeletons**, and **Summaries** condensed from finished manuscript chapters. The vocabulary is defined in [GLOSSARY.md](./GLOSSARY.md).

## The skills

| Skill | Invocation | What it does |
|---|---|---|
| `storymap` | `/skill:storymap` | Three modes. **Chart** settles the destination with the author, then writes the map and its decision tickets. **Work** resolves one ticket per session. **Redraw** changes a settled destination, logs why, and flags what it invalidates. |
| `codex` | model-invoked | The discipline used during any session: check claims against the codex, sharpen vague facts, test them with edge cases, and write each settled fact the moment it settles. Defines the entry formats and the diagnostic lenses. |
| `skeleton` | `/skill:skeleton` | Grills one chapter into a scene-by-scene skeleton. Refuses while any unresolved ticket affects that chapter. No prose. |
| `condense` | `/skill:condense` | Two modes. **Condense** turns a finished chapter into a summary and updates the codex, threads and continuity. **Adopt** reverse-engineers a story written before these skills, building the codex from the manuscript and handing off to `storymap`. |

## Install

Pi discovers skills through a project's `.agents/skills/` and through `~/.agents/skills/`, and can install this repo as a package:

```bash
pi install ./writer-skills             # local
pi install git:github.com/<you>/writer-skills@v0.1.0   # from git
```

Claude Code, Codex and other Agent Skills harnesses can consume the directories in `skills/` directly: copy or symlink each one into that harness's skills directory.

To use the skills while working in a story repo, point that discovery directory at this repo's `skills/`:

```bash
ln -s ../../writer-skills/skills .agents/skills
```

## The Story repo

The skills expect this layout, created lazily as files are needed:

```text
codex/{destination.md, outline.md, threads.md, timeline.md, characters/, locations/, world/}
map/{map.md, tickets/}
research/<topic>.md          # sourced real-world facts
research/canon/<topic>.md    # source-canon facts (fanfiction)
skeletons/chNN.md
summaries/chNN.md
manuscript/chNN.md           # the author's prose; only condense Adopt imports it, verbatim
```

Links between entries are Obsidian wikilinks, so a story repo can be opened as a vault.

## The check script

`skills/storymap/scripts/check.sh` lints a novel repo's map — ticket `Type`/`Status` values, that every `Blocked by` id exists, the `Affects:` syntax, that resolved tickets carry an `Answer`, and that Decisions-so-far lines stay short — and checks the skills' own frontmatter and links. It travels inside the `storymap` skill so it survives installation.

```bash
skills/storymap/scripts/check.sh <novel-dir>              # lint
skills/storymap/scripts/check.sh --frontier <novel-dir>   # list takeable tickets
```
