# Character Selection To First Message Flow Implementation Checklist

Source review:
- `reviews/review-2026-07-28-2208.md`

## Design

- Strengthen the decision moment on each character card.
- Add one small intent signal beyond the current description, such as `Best for calm reflection` or `Best for deep questions`.
- Keep the `Recommended` badge visually helpful without overpowering other characters.
- Make the first chat state feel more personalized after character selection.
- Add a stronger selected-guide cue in chat, such as a short role subtitle or a visible opening card.
- Preserve one visual bridge between selection and chat, such as avatar, role label, or a short handoff state.
- Ensure the flow still feels light and fast for first-time users.

## iOS

- Support one additional intent or role signal on the `Character Selection` cards.
- Preserve the current low-friction one-tap selection behavior unless product explicitly changes it.
- Add a stronger selected-character cue in `ChatViewController` after entering chat.
- Reuse the selected character’s avatar, label, or role description in chat if possible.
- Ensure the first chat state clearly reflects the selected guide before the user reads a long response.
- Keep the handoff between selection and chat visually coherent.
- Avoid adding extra modal friction unless product explicitly wants a preview step.

## Product

- Define the exact intent labels or role labels for each live character.
- Decide how much weight the `Recommended` badge should carry relative to the rest of the roster.
- Confirm whether the current one-tap commit is still the intended V1 behavior.
- Define what “more personalized first chat state” should mean in the product experience.
- Confirm whether a handoff cue should be a subtitle, an opening card, or another lightweight pattern.
- Keep the flow optimized for both speed and first-message confidence, not just speed.

## Analytics

- Measure whether the `Recommended` badge increases first-message conversion.
- Measure whether the badge suppresses exploration of other characters too much.
- Track whether the stronger first-chat personalization improves first message send rate.
- Compare first-time conversion before and after the chat handoff improvements.
- Keep event semantics aligned with the existing `character_selection_viewed`, `character_selected`, and `first_chat_started` model.

## Delivery Priority

- P1: Strengthen character-card intent signaling.
- P1: Make the first chat state feel clearly tied to the selected guide.
- P2: Improve continuity between selection and chat.
- P2: Review recommendation impact on roster exploration.
