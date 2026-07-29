# TalkToBudda UI Theme Checklist

Use this checklist when reviewing consistency across multiple screens in `TalkToBudda`.

Goal:
- Catch visual drift before it becomes baked into more screens
- Push fixes toward shared tokens and shared components
- Keep the app calm, readable, and stylistically coherent

Severity:
- `P0`: severe readability or interaction issue caused by styling
- `P1`: obvious inconsistency that weakens quality, trust, or hierarchy
- `P2`: polish drift or stylistic mismatch that should be cleaned up

## 1. Typography System

- Do root screens use the same title scale and weight model?
- Are body, metadata, helper text, and CTA labels following a stable hierarchy?
- Is any screen using a noticeably different font personality without a reason?
- Are italic or decorative treatments limited to short accent content?
- Are line height and text density consistent enough for side-by-side comparison?

## 2. Color System

- Is there one recognizable accent color family across tabs, CTA, chips, and selected states?
- Do background and surface colors feel like one system?
- Are any screens introducing ad hoc highlight colors?
- Do disabled states use a dedicated subdued treatment instead of arbitrary low opacity?
- Is text contrast preserved over decorative or tinted backgrounds?

## 3. Surface And Depth

- Do cards, sheets, and grouped blocks share a related radius model?
- Are borders and shadows consistent in strength and purpose?
- Does any module feel flatter or glossier than the rest of the app?
- Are premium surfaces still within the same visual family?
- Is elevation being used intentionally instead of randomly?

## 4. Spacing Rhythm

- Do root screens share the same horizontal margins?
- Are section gaps and card paddings consistent?
- Are stacked lists following the same density rules?
- Is safe-area spacing around bottom controls intentional?
- Do screens feel equally breathable, or does one module become cramped?

## 5. Component Family

- Do primary buttons look like one family?
- Do secondary buttons, chips, badges, and pills share one construction logic?
- Are repeated list rows aligned the same way across modules?
- Does the tab bar active state use one consistent pattern?
- Do search bars, composers, and selectors look distinct by purpose but related by system?

## 6. State Design

- Are selected states consistent across tabs, moods, rows, and plans?
- Are active and playing states stronger than passive states?
- Are disabled states unmistakable?
- Are locked or premium states integrated instead of visually bolted on?
- Do loading and empty states feel on-brand?

## 7. Screen-To-Screen Theme Drift

- Does `Chat` feel like the same app as `Quotes`, `Meditation`, `History`, and `Scriptures`?
- Does onboarding establish the same theme the user sees later?
- Do paywall and premium surfaces stay aligned with the core product tone?
- Is any screen noticeably more generic, more saturated, or more ornamental than the others?
- If screenshots are shuffled, do they still look like one product family?

## 8. Brutalist Lens

Use this section only as a secondary critique.

- Is any screen too soft, too generic, or too templated to feel memorable?
- Could stronger contrast or bolder type improve hierarchy without hurting readability?
- Is the app avoiding personality by overusing safe rounded cards and muted neutrals?
- Can one or two surfaces become more opinionated without fragmenting the system?
- Would a brutalist-inspired tweak improve confidence, or would it break the calm spiritual tone?

## 9. Ticket Format

For each issue, write:

- `Severity`: `P0`, `P1`, or `P2`
- `Screens`: exact screen names being compared
- `Problem`: one-sentence visual inconsistency
- `Why it matters`: impact on hierarchy, trust, readability, or brand coherence
- `Fix direction`: shared token or shared component direction first

Example:

- `P1`
- `Screens`: History, Scriptures
- `Problem`: Selected row styling uses different accent hues and different corner radii, so the two screens do not read as part of one design system.
- `Why it matters`: It makes the app feel patched together and weakens recognition of shared interaction states.
- `Fix direction`: Consolidate selected-state fill, text tint, and radius into one shared token set used by both modules.

## 10. Release Gate

Before closing a theme review, confirm:

- No open `P0`
- Major titles follow one hierarchy
- Accent color usage is consistent
- Shared cards and buttons read as one family
- Selected and disabled states are predictable
- No obvious one-off font or color decisions remain unexplained
