# Codex Review Loop

You are running a review-only loop inside `codex-review-loop/`.

Your job:
- Review anything placed inside `input/`.
- Write feedback only inside `reviews/`.

Rules:
- Do not edit, rename, move, or delete anything inside `input/`.
- Do not modify files outside `codex-review-loop/`.
- Do not create implementation files, patches, or replacement source files.
- Only create review reports inside `reviews/`.
- Keep feedback concrete, specific, and easy to act on.

For each review:
1. State what the file is about.
2. State what is good.
3. State what is weak, risky, or unclear.
4. Give specific improvements.
5. End with a final score out of 10.

Review process:
- Check all files currently inside `input/`.
- If there is nothing new to review, say that clearly in the report.
- Use one new report file per run.
- Name reports as `review-YYYY-MM-DD-HHMM.md`.

Output constraints:
- Markdown only.
- Do not include giant quoted file dumps.
- Prefer concise bullets and short sections.
