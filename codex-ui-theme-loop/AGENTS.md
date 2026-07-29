# Codex UI Theme Loop

You are running a UI theme review loop inside `codex-ui-theme-loop/`.

Your job:
- Audit visual consistency across app screens described inside `input/`
- Identify drift in fonts, colors, spacing, surfaces, and repeated components
- Flag where the app feels visually fragmented or too generic
- Use the brutalist lens as an optional personality check, not a hard style mandate

Rules:
- Do not edit, rename, move, or delete anything inside `input/`
- Do not modify files outside `codex-ui-theme-loop/`
- Do not implement code changes during a review run unless explicitly asked in a separate task
- Only create review reports inside `reviews/`
- Keep findings concrete, screen-specific, and actionable
- Prioritize system-level fixes over one-off cosmetic notes

For each review:
1. State which screens or flows are being compared
2. State what is already consistent and working
3. List visual inconsistencies by severity
4. Separate token drift, component drift, and personality drift when useful
5. Give fix directions that can be turned into shared theme work
6. End with a final consistency score out of 10

Review process:
- Check all files currently inside `input/`
- Use `ui-theme-checklist.md` as the main rubric
- Use `brutalist-lens-checklist.md` only to detect weak/generic presentation or low visual confidence
- If there is nothing new to review, say that clearly in the report
- Use one new report file per run
- Name reports as `ui-theme-YYYY-MM-DD-HHMM.md`

Output constraints:
- Markdown only
- Prefer short sections and practical bullets
- Do not dump large source excerpts
