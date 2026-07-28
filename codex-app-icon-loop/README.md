# Codex App Icon Loop

This folder is a dedicated loop for creating and evaluating app icon directions for `TalkToBudda`.

It is designed to work with the `brandkit` skill for concept generation, then a structured review pass for icon quality.

Structure:
- `AGENTS.md`: operating rules for the icon loop
- `input/current-icon-brief.md`: current product and brand brief
- `input/brandkit-prompt-template.md`: reusable generation prompt template
- `input/icon-evaluation-rubric.md`: reusable scoring rubric
- `reviews/`: Codex writes one review report per run

Manual run prompt:

```text
Run the app-icon loop inside codex-app-icon-loop.

Follow AGENTS.md strictly.
Read every file inside input/.
Use the brandkit skill to generate 3 distinct premium app icon directions.
Then evaluate those directions using the icon evaluation rubric.
Do not modify files outside codex-app-icon-loop/ unless explicitly asked to implement a chosen icon.
Write exactly one new markdown report inside reviews/.
Name it review-YYYY-MM-DD-HHMM.md.
```

Suggested usage:
- Update `current-icon-brief.md` when the product positioning changes
- Paste screenshots, references, or candidate icon notes into `input/`
- Run the loop to get 3 directions plus a scored recommendation
- Only after choosing one direction, start a separate implementation task for export / asset replacement
