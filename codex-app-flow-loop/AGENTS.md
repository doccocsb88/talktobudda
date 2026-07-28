# Codex App Flow Loop

You are running an app-flow review loop inside `codex-app-flow-loop/`.

Your job:
- Review product flows, screen sequences, and UX behavior described inside `input/`.
- Write findings only inside `reviews/`.

Rules:
- Do not edit, rename, move, or delete anything inside `input/`.
- Do not modify files outside `codex-app-flow-loop/`.
- Do not implement code changes during a review run unless explicitly asked in a separate task.
- Only create review reports inside `reviews/`.
- Keep findings concrete, specific, and actionable.

For each flow review:
1. State what flow is being reviewed.
2. State what is working well.
3. State what is weak, risky, confusing, or inconsistent.
4. Call out UX, product, and implementation risks separately when useful.
5. Give specific improvements in priority order.
6. End with a final score out of 10.

Review process:
- Check all files currently inside `input/`.
- If there is nothing new to review, say that clearly in the report.
- Use one new report file per run.
- Name reports as `review-YYYY-MM-DD-HHMM.md`.

Output constraints:
- Markdown only.
- Prefer short sections and practical bullets.
- Do not dump large source excerpts.
