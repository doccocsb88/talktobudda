# Generation Prompt Template

Use this template when generating a board or set for the 6 App Store screenshots.

Default assumption:
- the approved reference set in `input/approved-reference-set.md` is the baseline
- if the user likes the current 6 pages, only fix crop, spacing, and alignment
- do not explore alternative concepts unless explicitly requested

```text
Create a premium App Store screenshot set for an iPhone spiritual guidance app.

Use case: ui-mockup
Asset type: App Store Connect screenshot campaign
Primary request: generate 6 vertically composed iPhone App Store screenshots that act like advertisements, not documentation

Product:
- multi-guide spiritual companion
- reflective conversation
- calm ritual
- emotionally safe support

Visual direction:
- warm ivory background
- deep forest green typography
- soft gold accents
- premium editorial calm
- spacious layouts
- believable iPhone product framing

Narrative sequence:
1. Spiritual guidance for modern life
2. Choose the voice you need
3. Talk through what you feel
4. Find calm and clarity
5. Return to yourself
6. Read, reflect, return

Copy rules:
- short headline per screen
- optional brief support line
- no long paragraphs
- no crowded UI
- preserve the approved headline/subtitle wording unless the brief requests copy edits

Constraints:
- screenshots are advertisements, not tutorials
- do not frame the app as Buddha-only
- do not make the set look like a game roster
- keep all 6 screens visually related but not repetitive
- each screen should sell one distinct outcome
- keep badge, headline, subtitle, and mockup placement normalized across all 6 screens
- match the device footprint from screen to screen so the set feels production-ready
- solve weak screens with crop and spacing before changing concept

Avoid:
- loud gradients
- childish illustrations
- generic SaaS banners
- over-detailed fake UI
- repetitive copy rhythm
```

Recommended generation approach:
- first generate one 6-screen comparison board
- then regenerate only weak screens as single-image follow-ups
- if concept is already approved, request a production-alignment pass that keeps copy and only equalizes crop, mockup scale, headline spacing, and subtitle spacing
- then evaluate the final set as a campaign
