# Codex Redesign Loop

This folder is a dedicated loop for redesigning `TalkToBudda` with small, reviewable UI upgrades.

Structure:
- `AGENTS.md`: operating rules for the redesign loop
- `input/`: product briefs, screenshots, goals, and screen priorities
- `reviews/`: redesign audits and implementation notes written per run

Manual run prompt:

```text
Run the redesign loop inside codex-redesign-loop.

Follow AGENTS.md strictly.
Read every file inside input/.
Do not edit anything inside input/.
If implementation is requested, keep changes small and reviewable.
Write exactly one new markdown report inside reviews/.
Name it redesign-YYYY-MM-DD-HHMM.md.
```

Suggested usage:
- Add current screenshots or UX goals into `input/`
- Run the loop to get an audit and a prioritized redesign batch
- Apply one batch at a time instead of rewriting the app
