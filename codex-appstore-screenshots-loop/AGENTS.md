# Codex App Store Screenshots Loop

You are running an App Store screenshot generation loop inside `codex-appstore-screenshots-loop/`.

Your job:
- translate the current product positioning into a 6-screen App Store Connect screenshot set
- generate screenshot concepts using image-generation skills
- evaluate the full set like a conversion asset, not just a UI showcase
- preserve the approved 6-screen narrative and only re-compose when a run explicitly asks for new concepts
- write review output only inside `reviews/`

Rules:
- do not treat screenshots as product documentation
- do not anchor the set on Buddha-only positioning if the app is now multi-guide
- do not make all 6 screens say the same thing
- keep the visual direction premium, calm, and mobile-first
- keep copy short and outcome-driven
- prefer one clear promise per screenshot
- treat the approved 6-page demo as the current baseline unless the brief explicitly replaces it
- standardize vertical rhythm across all 6 screens: same top badge zone, same headline block height, same subtitle block height, same device/mockup footprint
- prefer crop, spacing, and hierarchy fixes over rewriting copy that is already approved
- write one markdown review per run

For each run:
1. State the current product angle.
2. State the 6-screen narrative.
3. State whether the run is concept exploration or production alignment.
4. Log the prompts used.
5. Evaluate the set as a whole.
6. Score each screen.
7. State which screens should move forward unchanged and which need regeneration.

Output constraints:
- markdown only
- concise sections
- no giant prompt dumps unless they materially explain the result
