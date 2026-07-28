# Codex Review Loop

This folder is a self-contained review-only loop for Codex.

Structure:
- `input/`: drop files here that you want reviewed.
- `reviews/`: Codex writes review reports here.
- `AGENTS.md`: rules Codex must follow for this loop.

Manual run prompt:

```text
Run the review-only loop inside codex-review-loop.

Follow AGENTS.md strictly.
Review every file inside input/.
Do not edit anything inside input/.
Do not modify files outside codex-review-loop/.
Write exactly one new review report inside reviews/.
Name it review-YYYY-MM-DD-HHMM.md.
Keep the feedback clear, specific, and useful.
If there is nothing new to review, say that clearly.
```

Suggested daily automation prompt:

```text
Run the review-only loop inside codex-review-loop.

Follow AGENTS.md strictly.
Check the input/ folder for anything that needs review.
Do not edit anything inside input/.
Do not modify files outside codex-review-loop/.
Write one new review report inside reviews/ named review-YYYY-MM-DD-HHMM.md.

Each review should include:
1. What the file is about
2. What is good
3. What is weak, risky, or unclear
4. Specific improvements
5. Final score out of 10

If there is nothing new to review, say that clearly.
```
