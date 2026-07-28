# TalkToBudda UI P1 Implementation Checklist

Source review:
- `reviews/review-2026-07-28-2245.md`

Goal:
- Convert current `P1` UI findings into an implementation-first checklist for the iOS team
- Keep scope limited to high-impact clarity, hierarchy, and consistency fixes

## Delivery Order

- `P1-1`: Unify bottom-tab active state
- `P1-2`: Simplify `Meditation Session` hierarchy
- `P1-3`: Rebalance `Chat` layout and bottom stack
- `P1-4`: Clarify `Sound Picker` completion state
- `P1-5`: Reduce `History` background competition

## P1-1 Bottom Tab Active State

Problem:
- Root tabs do not share one active-state pattern.
- `Scriptures` uses a cyan active label that breaks the app palette.
- `Quotes`, `Meditation`, and `History` also differ in active pill and emphasis behavior.

Implementation checklist:
- Define one canonical active-tab visual rule for all root tabs.
- Use one shared accent color system across all tabs.
- Standardize active icon tint, active label tint, label weight, and active background pill.
- Standardize inactive icon tint and inactive label tint.
- Remove the cyan active state from `Scriptures`.
- Verify the active state looks identical in `Quotes`, `Meditation`, `History`, and `Scriptures`.
- Check safe-area spacing and pill alignment on all four root screens.

QA:
- Active tab is recognizable instantly on every root screen.
- Switching tabs does not change the visual language of the tab bar.
- No tab uses a one-off color or one-off active shape.

## P1-2 Meditation Session Hierarchy

Problem:
- `Meditation Session` has too many competing emphasis layers during the core activity.
- Quote, timer, illustrated background, sound control, action buttons, and upsell all compete.

Implementation checklist:
- Make the timer the dominant focal point on the session screen.
- Keep `Pause` and `Finish` as the next most important actions after the timer.
- Reduce visual strength of decorative background art behind the core session area.
- Reduce the visual weight of the quote block so it supports the session instead of leading it.
- Re-style the sound control so it reads as a selected ambient-audio module, not a search field.
- Review vertical spacing so timer, controls, and sound module read as one coherent session cluster.
- Keep the screen calm under active-session conditions, not content-dense.

QA:
- The first read of the screen is `session in progress`, not `content + controls + upsell`.
- Timer and controls remain the dominant cluster across the full viewport.
- Decorative artwork no longer competes with timer legibility.

## P1-3 Chat Layout And Bottom Stack

Problem:
- The conversation area feels under-filled while the bottom area is overloaded.
- Quota card and composer compete in the same lower region.

Implementation checklist:
- Rebalance the screen vertically so the conversation surface feels intentionally occupied.
- Reduce unnecessary empty space between the first assistant response and the lower controls.
- Review the placement and spacing of the guide handoff card relative to the first message.
- Reduce the visual competition between quota card and composer.
- Decide whether quota should be inline support, a lighter banner, or a less persistent secondary surface.
- Ensure the composer remains the most immediate actionable control near the bottom.
- Preserve a calm, readable chat rhythm rather than stacking multiple boxed modules too tightly.

QA:
- The screen feels like a live chat surface, not a sparse top section plus a crowded footer.
- The send flow remains visually clearer than the monetization message.
- Bottom controls still feel comfortable on smaller device heights.

## P1-4 Sound Picker Completion State

Problem:
- `Save` is so faint that it risks reading as disabled or inactive.

Implementation checklist:
- Define the enabled style for top-right navigation actions on selection screens.
- Use faint styling only for truly disabled state.
- Make the current `Save` state visually unambiguous when the user can commit.
- If `Save` depends on selection changes, ensure the disabled-to-enabled transition is explicit.
- Add a clear selected-row treatment so the user knows what will be saved.
- Keep row preview actions visually secondary to selected-state clarity.

QA:
- Users can tell immediately whether `Save` is available.
- Users can tell which sound is currently selected.
- Enabled and disabled action states are visually distinct and consistent.

## P1-5 History Background Competition

Problem:
- The `History` background pattern is stronger than the rest of the app and competes with content cards.

Implementation checklist:
- Reduce contrast or opacity of the decorative background pattern on `History`.
- Re-check card fill, stroke, and shadow so cards remain primary over the background.
- Keep the `History` tab visually aligned with the calmer surfaces used in other root screens.
- Review text contrast on top of the adjusted background.
- Verify that preview text and timestamps remain easier to scan than the decorative layer.

QA:
- Cards read as the primary layer immediately.
- `History` still feels on-brand, but no longer feels like a separate visual system.
- Background detail does not compete with message preview scanning.

## Cross-Screen Verification

- Re-capture screenshots for `Quotes`, `Meditation`, `History`, `Scriptures`, `Chat`, `Meditation Session`, and `Sound Picker`.
- Compare all updated screens side by side for accent color consistency, card language, and state behavior.
- Validate the updated hierarchy on a smaller-height device as well as the current simulator size.
- Confirm no new `P1` visual regressions were introduced while fixing the current list.

## Suggested Ship Order

1. Bottom-tab active state
2. Meditation Session hierarchy
3. Chat layout and bottom stack
4. Sound Picker save and selection state
5. History background cleanup
