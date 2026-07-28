# TalkToBudda UI Review Pack

This pack groups the current reusable UI review materials for `TalkToBudda`.

Use it when:
- reviewing a new screen
- reviewing a changed flow
- converting UI findings into implementation work
- aligning visual cleanup across iOS screens

## Files In This Pack

### 1. Review Checklist

File:
- `ui-review-checklist.md`

Use for:
- running a reusable UI review on any screen or flow
- checking hierarchy, CTA clarity, readability, consistency, state, theming, and conversion impact

Output:
- `P0`, `P1`, `P2` findings written in ticket-ready format

### 2. P1 Implementation Checklist

File:
- `implementation-checklist-ui-p1.md`

Use for:
- turning current high-priority UI findings into iOS implementation work
- sequencing the most important fixes first

Current focus:
- bottom-tab active state
- meditation session hierarchy
- chat layout and bottom stack
- sound picker save and selection state
- history background cleanup

### 3. Design Token And Component Checklist

File:
- `design-token-component-checklist.md`

Use for:
- preventing one-off fixes
- aligning shared visual rules before or during UI cleanup
- checking tokens, shared components, and state behavior

Current focus:
- color and typography tokens
- spacing, radius, stroke, and shadow rules
- shared tab bar, button, card, chip, input, and nav-action behavior
- selected, active, disabled, and monetization states

## Recommended Usage Order

### For A New UI Review

1. Start with `ui-review-checklist.md`
2. Write findings as `P0`, `P1`, `P2`
3. Create a dated review report inside `reviews/`

### For Implementing Existing P1 Issues

1. Start with `implementation-checklist-ui-p1.md`
2. Use `design-token-component-checklist.md` while implementing shared fixes
3. Re-capture screenshots and re-run `ui-review-checklist.md`

### For Shared UI Refactors

1. Start with `design-token-component-checklist.md`
2. Normalize tokens and reusable components first
3. Re-validate flows with `ui-review-checklist.md`
4. Re-check remaining priorities in `implementation-checklist-ui-p1.md`

## Suggested Team Workflow

### Product / Design

- Use `ui-review-checklist.md` to identify problems and assign severity.
- Keep review comments tied to screen purpose and user action, not just visual taste.

### iOS

- Use `implementation-checklist-ui-p1.md` to drive fix order.
- Use `design-token-component-checklist.md` to decide whether a fix belongs in a shared component or only in one screen.

### QA

- Re-capture before/after screenshots for root tabs and key flows.
- Verify that fixes improve consistency without creating new state regressions.

## Current Related Files

- `reviews/review-2026-07-28-2245.md`

This review is the source audit for the current `P1` implementation checklist.

## Maintenance Rule

When a new UI review cycle happens:

1. Add a new dated review in `reviews/`
2. Update or replace implementation checklists only if priorities change
3. Keep token/component rules shared rather than duplicating them into screen-specific notes
