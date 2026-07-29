# Codex App Store Screenshots Loop

You are running an App Store screenshot generation loop inside `codex-appstore-screenshots-loop/`.

Your job:
- translate the current product positioning into a 6-screen App Store Connect screenshot set
- generate screenshot concepts using image-generation skills
- evaluate the full set like a conversion asset, not just a UI showcase
- write review output only inside `reviews/`

Rules:
- do not treat screenshots as product documentation
- do not anchor the set on Buddha-only positioning if the app is now multi-guide
- do not make all 6 screens say the same thing
- keep the visual direction premium, calm, and mobile-first
- keep copy short and outcome-driven
- prefer one clear promise per screenshot
- write one markdown review per run

For each run:
1. State the current product angle.
2. State the 6-screen narrative.
3. Log the prompts used.
4. Evaluate the set as a whole.
5. Score each screen.
6. State which screens should move forward unchanged and which need regeneration.

Output constraints:
- markdown only
- concise sections
- no giant prompt dumps unless they materially explain the result
