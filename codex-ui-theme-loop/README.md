# Codex UI Theme Loop

This folder is a dedicated loop for reviewing visual consistency in `TalkToBudda`.

Focus:
- Font consistency across screens
- Color and accent consistency
- Shared component consistency
- Theme drift between modules
- Visual personality, including an optional brutalist-inspired review lens

Structure:
- `AGENTS.md`: operating rules for the loop
- `input/`: screenshots, screen lists, review briefs, and UI goals
- `reviews/`: Codex writes one review report per run
- `ui-theme-checklist.md`: reusable checklist for typography, color, spacing, and component consistency
- `brutalist-lens-checklist.md`: optional rubric for stronger visual personality without forcing a full brutalist redesign

Manual run prompt:

```text
Run the UI theme review loop inside codex-ui-theme-loop.

Follow AGENTS.md strictly.
Review every file inside input/.
Do not edit anything inside input/.
Do not modify files outside codex-ui-theme-loop/.
Write exactly one new review report inside reviews/.
Name it ui-theme-YYYY-MM-DD-HHMM.md.
Focus on font, color, surface, spacing, and component consistency across screens.
Use the brutalist lens only as a secondary critique, not as a mandatory redesign direction.
If there is nothing new to review, say that clearly.
```

Suggested usage:
- Add screenshots grouped by flow or module into `input/`
- Add a short brief describing which screens feel inconsistent
- Run this loop before any UI polish pass or token refactor
- Convert `P1` findings into shared theme or component work instead of per-screen patches
