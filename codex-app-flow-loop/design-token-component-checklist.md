# TalkToBudda Design Token And Component Checklist

Goal:
- Give the iOS team one shared checklist for visual-system cleanup
- Prevent screen-by-screen fixes from drifting into one-off styles
- Align tokens, components, and state behavior before deeper UI polish

When to use:
- Before implementing `P1` UI fixes
- When adding a new root screen or feature module
- When refactoring shared SwiftUI/UIKit styling helpers

## 1. Token Foundations

### Color Tokens

- Define one primary background token for calm neutral screens.
- Define one secondary surface token for cards and grouped modules.
- Define one primary text token for headlines and key labels.
- Define one secondary text token for supporting copy and metadata.
- Define one accent token for the app’s warm spiritual highlight color.
- Define one subdued accent token for chips, light fills, and selected backgrounds.
- Define one border token for card outlines and input outlines.
- Define one disabled text token and one disabled control token.
- Remove one-off colors from feature screens, especially the cyan tab state in `Scriptures`.

Checklist:
- No screen uses ad hoc hex values for active state.
- Accent usage is consistent across tab bar, CTA, chips, and selection states.
- Decorative colors never reduce text readability.

### Typography Tokens

- Define one display style for major page titles.
- Define one section-title style for large in-content headers.
- Define one body style for primary readable paragraphs.
- Define one supporting-copy style for subtitles, helper text, and metadata.
- Define one label style for chips, badges, and compact controls.
- Define one quote or accent style for short spiritual/callout copy only.
- Limit decorative italics to short emphasis content, not dense reading blocks.

Checklist:
- Title hierarchy is consistent across `Quotes`, `Meditation`, `History`, `Scriptures`, `Chat`, and session screens.
- Metadata never competes with the main preview content.
- Long list cards do not mix too many font personalities in one block.

### Spacing Tokens

- Define outer page margin values for root screens.
- Define section spacing values between major vertical blocks.
- Define card internal padding tokens.
- Define compact spacing for badges, chips, and metadata rows.
- Define bottom-safe spacing for composer, CTA, and tab bar adjacency.

Checklist:
- Root screens share the same horizontal rhythm unless there is a specific reason not to.
- Repeated card stacks feel aligned across modules.
- Bottom controls do not feel cramped against the safe area.

### Radius, Stroke, And Shadow Tokens

- Define one large card radius.
- Define one pill radius for tab states, chips, and rounded controls.
- Define one border width for standard outlined surfaces.
- Define one light shadow token for elevated cards.
- Define one stronger shadow token only if truly necessary.

Checklist:
- Cards do not vary slightly in radius from screen to screen.
- Outlined modules feel like one family.
- Shadow style is consistent and subtle.

## 2. Component Checklist

### Bottom Tab Bar

- Build one shared tab item active state.
- Standardize active pill shape, active fill, icon tint, and label tint.
- Standardize inactive icon and label treatment.
- Keep all four root tabs inside the same layout system.

Checklist:
- `Quotes`, `Meditation`, `History`, and `Scriptures` all behave identically.
- No tab introduces a unique active color or spacing rule.

### Primary Button

- Define one primary CTA style for actions like `Start Chat`.
- Standardize height, radius, fill color, text style, and pressed state.
- Define disabled and loading states explicitly.

Checklist:
- Primary buttons always read as the strongest actionable element on screen.
- Disabled state does not look like an enabled low-contrast mistake.

### Secondary Button

- Define one secondary outlined or low-emphasis button style for actions like `Pause` and `Finish` when they are not primary.
- Keep text and icon alignment consistent.

Checklist:
- Secondary actions never compete visually with the main CTA unless intended.
- Dual-button layouts feel balanced.

### Card Components

- Define a shared base card for list items.
- Define variants only when structure truly differs: content card, quote card, history card, guide card, scripture card, meditation card.
- Keep title area, supporting copy, accessory icon, and metadata relationships predictable.

Checklist:
- Repeated list rows feel related even across different features.
- Card density is tuned by content rules, not random per-screen spacing changes.

### Badge And Chip

- Define one badge style for `Recommended`.
- Define one chip style for labels like `Best for calm reflection`.
- Standardize horizontal padding, radius, fill, border, and font size.

Checklist:
- Badges never overpower the title they annotate.
- Chips read as supportive labels, not mini-buttons unless they are interactive.

### Input And Composer

- Define one input shell style for search, chat composer, and similar entry surfaces.
- Distinguish clearly between search input, selected-value control, and message composer.
- Standardize placeholder color, border, radius, and icon placement.

Checklist:
- Search bars do not visually resemble playback selectors.
- Composer controls remain obvious and comfortable near the bottom edge.

### Top Navigation Actions

- Define one style for top-left back affordance.
- Define one style for top-right text actions like `Save`.
- Explicitly define enabled vs disabled appearance.

Checklist:
- `Save` is never mistaken for disabled when active.
- Navigation actions remain visible over decorative backgrounds.

## 3. State Rules

### Selected

- Selected mood
- Selected guide
- Selected tab
- Selected sound

Checklist:
- Every selected state has one unmistakable visual signal.
- Selection styling is consistent across chips, rows, tabs, and cards.

### Active / In Progress

- Active meditation session
- Playing sound preview
- Open chat context

Checklist:
- In-progress states are visually stronger than passive supporting surfaces.
- Playback or session states are discoverable without relying on tiny icons alone.

### Disabled

- Disabled actions must use a dedicated disabled token.
- Avoid using “just lighter text” unless it is part of the shared disabled system.

Checklist:
- Disabled never looks like weak emphasis for enabled actions.

### Monetization / Quota

- Define one style family for quota cards and upsell cards.
- Keep premium surfaces consistent with the app tone.
- Ensure monetization modules are visually secondary during core tasks.

Checklist:
- Quota or upsell modules do not overpower primary workflows.
- Premium elements still feel integrated with the brand.

## 4. Screen-Specific Cleanup Prompts

Use these prompts before approving any screen:

- Is this screen using shared tokens or introducing a local workaround?
- Could this card be composed from an existing base card variant?
- Is this selected state reusing the shared selected pattern?
- Is this CTA using the shared primary or secondary button style?
- Is decorative background art stronger than content?
- Is any one-off font, color, or radius sneaking in because it “looked right” locally?

## 5. iOS Implementation Notes

- Prefer centralizing tokens in a shared theme/styling layer rather than embedding values inside each screen.
- Audit whether current tab bar, card, chip, and button styles are duplicated across modules.
- Normalize root-screen components first before tuning specialty screens.
- When fixing one feature screen, update the shared component if the issue is systemic.
- Re-capture side-by-side screenshots after token refactors to catch accidental drift.

## 6. Release Gate

Before merging a visual-system cleanup:

- Root tab bar uses one shared active-state implementation
- Primary and secondary buttons are tokenized
- Card radius, stroke, and shadow are consistent
- Badge and chip styles are standardized
- Enabled and disabled top actions are clearly differentiated
- Search, composer, and selector inputs are visually distinct by purpose
- Selected states are obvious across tabs, moods, and sound rows
- Monetization surfaces remain secondary during core actions
