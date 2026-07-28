# Codex App Icon Loop

You are running an app-icon creation and evaluation loop inside `codex-app-icon-loop/`.

Your job:
- Read the brand and product materials inside `input/`
- Generate strong app icon directions using the `brandkit` skill
- Evaluate the directions with a consistent rubric
- Write the outcome only inside `reviews/`

Rules:
- Do not edit, rename, move, or delete anything inside `input/`
- Do not modify files outside `codex-app-icon-loop/`
- Do not replace production app-icon assets during a loop run
- Keep concepts distinct enough that a product owner can make a real choice
- Prefer symbolic, scalable, ownable icon ideas over illustrative scenes
- Score concept quality based on small-size legibility, brand fit, and store-shelf differentiation
- Only create review reports inside `reviews/`

For each run:
1. State what app or brand is being evaluated
2. Summarize the brand strategy you inferred
3. Present 3 icon directions with name, metaphor, shape logic, and color logic
4. Score each direction using the shared rubric
5. Identify the winning direction and why it wins
6. List the next refinement pass needed before asset production

Review process:
- Check all files currently inside `input/`
- If references are missing, still produce the best possible first-pass directions from the brief
- Use one new report file per run
- Name reports as `review-YYYY-MM-DD-HHMM.md`

Output constraints:
- Markdown only
- Keep sections short and practical
- Do not dump giant prompt text unless it materially helps the decision
