---
name: passage
description: Write a short, author-voice passage for a planned scene, using the novel's voice profile and Codex.
disable-model-invocation: true
---

Write one **Passage** for an existing scene. Input: chapter and scene from `skeletons/chNN.md`, plus an optional kind such as description or ambience.

Read `codex/voice.md`, its **Voice anchors**, the skeleton, and relevant Codex entries. Use only their voice, scene plan, and facts; a needed but unset fact becomes a question for the author. If `codex/voice.md` is absent, stop: voice capture begins after three Manuscript chapters.

Write only `passages/chNN-<slug>.md`. Begin with a header identifying it as agent-written, the source scene, and today's date. Keep it short. Do not edit `manuscript/`.

After writing, run `../codex/scripts/voice-stats.sh passages/chNN-<slug>.md` for its measurement report, then its `--outliers <the Baseline chapters in voice.md> -- passages/chNN-<slug>.md` mode. Report every measured feature outside the profile's Measured range and every outlier sentence. The author rewrites or pastes the Passage into the Manuscript.
