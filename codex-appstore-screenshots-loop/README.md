# Codex App Store Screenshots Loop

This folder is a dedicated loop for generating and evaluating a 6-image App Store Connect screenshot set for `TalkToBudda`.

Use this loop when:
- the app positioning changes
- the app name or splash direction changes
- the product expands beyond Buddha-only guidance
- the App Store page needs a stronger ad-driven screenshot set

Structure:
- `AGENTS.md`: operating rules for the screenshot loop
- `input/current-screenshot-brief.md`: current product and positioning brief
- `input/six-shot-plan.md`: the required 6-screenshot sales narrative
- `input/generation-prompt-template.md`: reusable prompt template for screenshot generation
- `input/evaluation-rubric.md`: reusable scoring rubric for screenshot quality
- `reviews/`: one review note per run

Manual run prompt:

```text
Run the App Store screenshots loop inside codex-appstore-screenshots-loop.

Follow AGENTS.md strictly.
Read every file inside input/.
Generate a 6-image App Store screenshot direction for iPhone.
Treat screenshots as advertisements, not UI documentation.
Evaluate the full set and each screen using the rubric.
Write exactly one markdown report inside reviews/.
Name it review-YYYY-MM-DD-HHMM.md.
```

Expected outcome per run:
- one coherent 6-screen direction
- headline/copy intent for each screenshot
- generation prompts used
- evaluation of which screens are strongest or weak
- recommendation on whether the set is ready for a final export pass
