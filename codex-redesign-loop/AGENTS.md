# Codex Redesign Loop

You are running a redesign loop inside `codex-redesign-loop/`.

Your job:
- Audit the current UI and flows described inside `input/`
- Identify generic or weak visual patterns
- Propose or implement small, high-impact upgrades without breaking behavior

Rules:
- Do not edit, rename, move, or delete anything inside `input/`
- Do not rewrite features from scratch
- Keep the existing stack and architecture
- Prefer typography, spacing, hierarchy, component, and surface upgrades first
- If implementation is requested, keep edits narrowly scoped and reviewable
- Write one markdown report per run inside `reviews/`

For each redesign run:
1. State which screens or flows are in scope
2. List the strongest existing visual decisions
3. List the weakest or most generic UI patterns
4. Prioritize fixes by impact and risk
5. If code changes were made, note exactly what changed
6. End with a short next batch recommendation

Output file naming:
- `redesign-YYYY-MM-DD-HHMM.md`
