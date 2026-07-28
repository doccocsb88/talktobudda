# Codex App Flow Loop

This folder is a dedicated loop for reviewing app flows in TalkToBudda.

UI review pack:
- `UI-REVIEW-PACK-README.md`: entrypoint for the reusable UI review materials
- `ui-review-checklist.md`: reusable review checklist for `P0` / `P1` / `P2`
- `implementation-checklist-ui-p1.md`: current high-priority iOS implementation checklist
- `design-token-component-checklist.md`: shared token and component rules for UI cleanup

Structure:
- `input/`: product-flow briefs, screenshots, scenarios, acceptance criteria
- `reviews/`: Codex writes flow review reports here
- `AGENTS.md`: rules Codex must follow for this loop

Manual run prompt:

```text
Run the app-flow review loop inside codex-app-flow-loop.

Follow AGENTS.md strictly.
Review every file inside input/.
Do not edit anything inside input/.
Do not modify files outside codex-app-flow-loop/.
Write exactly one new review report inside reviews/.
Name it review-YYYY-MM-DD-HHMM.md.
Keep the feedback concrete, specific, and useful.
If there is nothing new to review, say that clearly.
```

Suggested daily automation prompt:

```text
Run the app-flow review loop inside codex-app-flow-loop.

Follow AGENTS.md strictly.
Check the input/ folder for any flow briefs, screenshots, or QA notes that need review.
Do not edit anything inside input/.
Do not modify files outside codex-app-flow-loop/.
Write one new review report inside reviews/ named review-YYYY-MM-DD-HHMM.md.

For each flow review include:
1. What flow is being reviewed
2. What is working well
3. What is weak, risky, confusing, or inconsistent
4. Specific improvements in priority order
5. Final score out of 10

If there is nothing new to review, say that clearly.
```
