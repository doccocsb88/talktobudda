# TalkToBudda UI Review Checklist

Use this checklist when reviewing any new or updated screen in `TalkToBudda`.

Scope:
- Quotes
- Meditation
- History
- Scriptures
- Character selection
- Chat
- Meditation session
- Audio / picker flows

How to use:
1. Review one user flow at a time, not isolated screens only.
2. Capture at least one screenshot per key state.
3. Mark findings as `P0`, `P1`, or `P2`.
4. Write the finding as a ticket-sized statement with a concrete fix direction.
5. Re-run the checklist after changes on the same screenshots and on-device if possible.

Severity:
- `P0`: broken flow, blocked action, misleading state, or severe readability/accessibility issue
- `P1`: weak hierarchy, confusing CTA, inconsistent state, or issue likely to hurt conversion or trust
- `P2`: polish, consistency drift, density, spacing, copy tightness, or visual cleanup

## 1. Flow Framing

- Is the screen purpose clear within 3 seconds?
- Is the primary action obvious without reading everything?
- Does the screen continue the previous step logically?
- Does the user know what to do next?
- Is there one dominant action, not several competing ones?

## 2. Hierarchy

- Is the page title visually dominant?
- Is supporting copy clearly secondary?
- Do cards, controls, and CTA buttons have a clear top-to-bottom order?
- Does the eye land on the most important content first?
- Is any decorative layer stronger than the content layer?

## 3. CTA Clarity

- Is the main CTA the highest-contrast actionable element?
- Are secondary actions visually quieter than the primary CTA?
- Are disabled actions clearly disabled, not just low-contrast?
- Is button copy action-oriented and specific?
- If there are multiple actions, is their relationship obvious?

## 4. Content Density

- Is any card trying to show too much text at once?
- Are truncation points acceptable, or do they hide meaningful information?
- Can the user scan the content quickly?
- Does any block feel visually heavy relative to its value?
- Should copy be split into title, subtitle, and detail instead of one dense block?

## 5. Readability

- Are body text, placeholders, metadata, and timestamps readable at normal viewing distance?
- Is contrast high enough against the background?
- Do decorative backgrounds reduce legibility?
- Are long lines or narrow line spacing making text harder to parse?
- Are italic or stylized fonts limited to short accent content?

## 6. Spacing And Alignment

- Are outer margins consistent across sections?
- Are card paddings consistent from screen to screen?
- Are icons, avatars, and text baselines aligned cleanly?
- Is there any empty gap that feels accidental rather than intentional?
- Is bottom spacing safe above the tab bar or input controls?

## 7. Component Consistency

- Do cards share a consistent radius, stroke, and shadow model?
- Are chips, tags, and badges built from the same visual rules?
- Do icon sizes and stroke weights feel related?
- Does the tab bar active state behave consistently on every tab?
- Do repeated rows follow one layout system instead of slight variations?

## 8. State Design

- Can the user distinguish default, selected, active, playing, paused, disabled, and saved states?
- Is the currently selected tab, guide, mood, or sound unmistakable?
- Do screens with audio preview show active playback clearly?
- Does the UI explain quota, upsell, or locked state without hijacking the main task?
- Are empty and first-time states intentionally designed?

## 9. Theming

- Does the warm spiritual theme support content instead of overpowering it?
- Are accent colors used consistently?
- Is any single screen off-theme relative to the rest of the app?
- Are patterns and illustrations subtle enough?
- Are premium or upsell elements still on-brand?

## 10. Input And Reachability

- Are touch targets comfortably tappable?
- Are back, save, send, preview, and play controls easy to discover?
- Is the keyboard/input region clean and not visually cramped?
- Are bottom actions reachable without precision taps?
- Does the flow remain usable on a smaller device height?

## 11. Conversion And Trust

- Does the screen help the user continue, start, save, or send with confidence?
- Is upsell placed so it does not interrupt the primary task too early?
- Are recommendation labels helpful rather than manipulative?
- Does quota messaging feel clear and calm?
- Does premium messaging fit the tone of the app?

## 12. Ticket Format

For each issue, write:

- `Severity`: `P0`, `P1`, or `P2`
- `Screen`: exact screen name
- `Problem`: one-sentence user-facing issue
- `Why it matters`: impact on clarity, conversion, trust, or consistency
- `Fix direction`: concrete next step, without prescribing code structure

Example:

- `P1`
- `Screen`: Meditation Session
- `Problem`: The upsell card competes with the timer and action controls while the session is in progress.
- `Why it matters`: It weakens focus during the core meditation task and makes the session screen feel commercially noisy.
- `Fix direction`: Reduce upsell prominence during active sessions or move it behind a completed-session moment.

## 13. Release Gate

Before closing a UI review, confirm:

- Primary flow is understandable without explanation
- Main CTA is obvious on every reviewed screen
- Active/selected states are consistent
- Text is readable across decorative backgrounds
- Tab bar behavior is visually consistent
- Upsell does not interrupt the main task
- No open `P0`
- Any remaining `P1` has an owner and a decision
