# Character Selection V1 Implementation Checklist

Source brief:
- `input/first-review.md`

## Design

- Add one short role description under each character name.
- Keep each role description within two lines on smaller devices.
- Preserve readable layout under dynamic type and localization expansion.
- Add exactly one `Recommended` badge on `Buddha` for first-time users.
- Use moderate visual emphasis for the badge so it guides choice without overpowering the rest of the list.
- Keep the existing character selection layout; do not redesign the full screen for V1.
- Finalize role-description copy for the full live character roster.
- Define the exact visual style and placement of the `Recommended` badge.
- Define the returning-user screen state with no recommendation badge shown.

## iOS

- Show short role descriptions in the existing `Character Selection` UI.
- Show the `Recommended` badge only for first-time users.
- Hide the badge permanently after the user sends their first chat message.
- Do not reorder characters dynamically in V1.
- Do not add personalization logic in V1.
- Allow users to select any character directly without extra confirmation friction.
- Preserve existing last-selected-character behavior unless a product rule explicitly changes it.
- Confirm where first-time state is stored and how it is persisted reliably.
- Confirm how `first_chat_started` is detected from the live chat flow.
- Resolve the edge case where a first-time user opens character selection, leaves without messaging, and returns later.

## Analytics

- Fire `character_selection_viewed` when the character selection screen becomes visible.
- Fire `character_selected` when the user taps a character and enters that character's chat flow.
- Fire `first_chat_started` when the user sends the first message in chat.
- Measure drop-off from `character_selection_viewed` to `character_selected`.
- Measure drop-off from `character_selected` to `first_chat_started`.
- Compare post-release conversion from `character_selection_viewed` to `first_chat_started` against the pre-release baseline.
- Monitor whether the `Recommended` treatment over-concentrates selection share into `Buddha`.
- Use one consistent definition of "chat started" across implementation, dashboards, and review.

## Release Decision

- Keep V1 if first-chat conversion improves and character exploration remains acceptable.
- Reduce badge emphasis and re-measure if conversion improves but character selection becomes too concentrated in one character.
- Redesign or remove the recommendation treatment if conversion does not improve.
