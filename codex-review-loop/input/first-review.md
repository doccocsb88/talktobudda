# Character Selection Review Brief

This is a revised product brief for improving the `Character Selection` experience in TalkToBudda.

## Problem

Users open the app and see multiple spiritual or philosophical characters, but it may not be obvious who to choose first or why each option is different.

## Goal

Improve first-session clarity and increase the percentage of users who select a character and send a first chat message.

## Success Metrics

- Track `character_selection_viewed`
- Track `character_selected`
- Track `first_chat_started`
- Measure drop-off from screen view to character selection
- Measure drop-off from character selection to first sent message

## V1 Success Criteria

- Treat V1 as successful if the conversion from `character_selection_viewed` to `first_chat_started` improves versus the current baseline after release.
- Also check whether the recommended starter increases first-chat conversion without collapsing exploration of other characters too aggressively.
- Treat the recommendation treatment as too strong if first-chat conversion improves but selection share becomes overly concentrated in one character and materially reduces discovery of the rest of the roster.
- If conversion does not improve, or if character exploration drops too sharply, iterate on badge emphasis before expanding scope.

## V1 Decision Rule

- Ship V1 with description text plus one recommended starter badge.
- Review the first post-release funnel against the pre-release baseline.
- If conversion improves and character exploration remains acceptable, keep the treatment.
- If conversion improves but recommendation concentration is too strong, reduce badge emphasis and re-measure.
- If conversion does not improve, remove or redesign the recommendation treatment before adding V2 ideas.

## Analytics Event Definitions

- `character_selection_viewed`: fire when the character selection screen becomes visible to the user.
- `character_selected`: fire when the user taps a character and enters that character's chat flow.
- `first_chat_started`: fire when the user sends the first message in chat, not when the chat screen simply opens.

## Primary UX Behavior

- First-time users see one recommended starter badge on `Buddha`.
- Returning users do not see the recommended starter badge.
- Users can select any character directly without confirmation friction added by this feature.
- The feature should help guide the first choice, not block exploration of other characters.

## V1 Scope

- Keep the existing character selection layout.
- Add one short role description under each character name.
- Highlight one recommended starter character for first-time users.

## V1 Recommendation Rule

- Recommend `Buddha` for all first-time users.
- Do not personalize recommendation logic in V1.
- Do not reorder the full list dynamically in V1.
- Use Buddha as the default because it is the broadest and lowest-friction entry point for first-time users.

## V1 UI Constraints

- Show only one recommended starter badge on the screen.
- Show the badge only for first-time users.
- Hide the badge permanently after the user sends their first chat message.
- Keep each role description within two lines on smaller devices.
- Preserve readable layout under dynamic type and localization expansion.
- Use moderate visual emphasis for the recommended badge so it guides choice without overpowering the rest of the list.

## Non-Goals

- Do not build a full character profile system.
- Do not add AI-generated previews in V1.
- Do not redesign the entire onboarding or chat entry flow.
- Do not introduce personality personalization yet.

## V2 Candidates

- Add a small "best for" label such as "Calm advice", "Deep reflection", or "Practical wisdom".
- Add a lightweight preview before entering chat.
- Test alternative recommended starter logic after V1 data is available.

## Preview Direction For Later Version

- If preview is added later, prefer a bottom sheet over a separate detail screen.
- The preview should be curated, static, and short in the first version that uses it.
- The preview should show one sample user question and one example of response tone.

## Copy Principles

- Keep descriptions short.
- Keep tone respectful and non-preachy.
- Make each character feel distinct in a consistent format.
- Follow this pattern where possible: `[core trait] + [type of guidance]`.
- Avoid wording that feels reductive toward religious or philosophical figures.

## Proposed V1 Copy Examples

- Buddha: Gentle guidance for calm, balance, and mindfulness
- Socrates: Questions that help you think more clearly
- Jesus: Compassion, forgiveness, and moral reflection
- Marcus Aurelius: Grounded advice for discipline and inner strength

## Edge Cases To Define In Product And UX

- How easily should users switch characters later?
- If users switch characters, should chat context stay separate by character or feel continuous?
- What should the UI show if a first-time user opens character selection, leaves without messaging, and returns later?

## Returning User State

- After a user sends their first chat message, treat them as no longer first-time for this feature.
- On later visits, do not show the recommended starter badge.
- Preserve the existing product behavior for last selected character unless another product rule already overrides it.
- Switching characters later should remain allowed and should not be blocked by the recommendation treatment.

## Delivery Notes

- Product should finalize the full role-description copy set for the complete character roster before implementation starts.
- Design should define the exact visual style of the recommended badge within the existing screen hierarchy.
- Engineering should confirm where first-time state is stored and how `first_chat_started` is persisted reliably.
- Analytics should use the same event semantics defined in this brief without introducing a second interpretation of "chat started".

## Open Questions For Later Validation

- Do short descriptions improve selection confidence without making the screen feel crowded?
- Does recommending Buddha improve first-chat conversion or reduce exploration of other characters too much?
- After V1, is a preview actually needed, or are descriptions enough?
- Which character distinctions are easiest for users to understand in a few seconds?
