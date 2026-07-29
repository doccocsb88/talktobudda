# Code Theme Audit

## Scope

This pass audits theme consistency directly from source code using:
- `codex-ui-theme-loop/code-theme-audit-checklist.md`
- shared color/font helpers
- AppModules styling declarations

This is a code-audit-only report. It focuses on source-level drift and backlog shaping, not runtime screenshot judgment.

## Summary

The app already has a partial warm-theme system, but it is implemented mostly as repeated local values instead of semantic theme primitives. The biggest engineering problem is not bad taste. It is that the styling contract does not yet exist in code, so consistency depends on manual repetition.

## Findings

### P1
- `Scope`: token
- `Code smell`: Common UI roles are still hardcoded with `UIColor(hexString:)` across many screens instead of being expressed as semantic colors.
- `Impact`: Theme consistency is fragile. New screens can easily drift even when they intend to match the current look.
- `Fix direction`: Introduce semantic colors first for screen background, primary text, secondary text, primary surface, muted surface, soft border, warm accent, muted accent, and premium accent. Migrate repeated warm browns and creams before touching specialty screens.
- `Evidence`: [ChatViewController.swift](/Users/mac/Documents/hai/TalkToBudda/TalkToBudda/AppModules/Chat/ChatViewController.swift:36), [CharacterSelectionViewController.swift](/Users/mac/Documents/hai/TalkToBudda/TalkToBudda/AppModules/CharacterSelection/CharacterSelectionViewController.swift:149), [QuotesListViewController.swift](/Users/mac/Documents/hai/TalkToBudda/TalkToBudda/AppModules/QuotesList/QuotesListViewController.swift:359), [MeditationViewController.swift](/Users/mac/Documents/hai/TalkToBudda/TalkToBudda/AppModules/Mediation/MeditationViewController.swift:36), [HistoryViewController.swift](/Users/mac/Documents/hai/TalkToBudda/TalkToBudda/AppModules/History/HistoryViewController.swift:54), [ScripturesViewController.swift](/Users/mac/Documents/hai/TalkToBudda/TalkToBudda/AppModules/Scriptures/ScripturesViewController.swift:71).

### P1
- `Scope`: helper
- `Code smell`: `UIColor+Exts.swift` is a large bucket of raw palette constants, but it is not acting as a semantic theme layer.
- `Impact`: The project has many reusable color definitions available, yet screens still bypass them and hardcode new values. This invites duplication and makes intent unreadable.
- `Fix direction`: Keep low-level palette constants if needed, but add semantic aliases or a `ThemeColor` layer above them. New screen code should consume semantic roles, not raw palette inventory.
- `Evidence`: [UIColor+Exts.swift](/Users/mac/Documents/hai/TalkToBudda/TalkToBudda/Common/UIColor+Exts.swift:14), [Accessor.assets.swift](/Users/mac/Documents/hai/TalkToBudda/TalkToBudda/Swiftgen/Accessor.assets.swift:83).

### P1
- `Scope`: typography
- `Code smell`: `FontFamily` usage is partially coherent, but there is no codified mapping from hierarchy role to font role.
- `Impact`: `PlayfairDisplay`, `Inter28pt`, `FiraMono`, and occasional `UIFont` can all be used ad hoc, so hierarchy can drift screen by screen.
- `Fix direction`: Create semantic typography entry points such as `ThemeFont.display`, `sectionTitle`, `body`, `supporting`, `label`, and `eyebrowMono`. Ban direct `UIFont` in themed modules unless explicitly justified.
- `Evidence`: `FontFamily` is spread across modules, while legacy system font leakage still exists in [PurchaseViewController.swift](/Users/mac/Documents/hai/TalkToBudda/TalkToBudda/AppModules/DirectStore/PurchaseViewController.swift:190).

### P1
- `Scope`: component
- `Code smell`: Primary CTA styling is duplicated locally with different fills, radii, and font roles.
- `Impact`: Core actions do not read as one family in code, so any future tweak requires touching multiple screens and may fork the style further.
- `Fix direction`: Add one shared primary button style helper for the warm theme and one premium CTA variant if necessary. Migrate onboarding, meditation, quotes, chat upsell, and empty-state buttons first.
- `Evidence`: [OnboardingViewController.swift](/Users/mac/Documents/hai/TalkToBudda/TalkToBudda/AppModules/Onboarding/OnboardingViewController.swift:18), [MeditationViewController.swift](/Users/mac/Documents/hai/TalkToBudda/TalkToBudda/AppModules/Mediation/MeditationViewController.swift:29), [QuotesListViewController.swift](/Users/mac/Documents/hai/TalkToBudda/TalkToBudda/AppModules/QuotesList/QuotesListViewController.swift:174), [ChatViewController.swift](/Users/mac/Documents/hai/TalkToBudda/TalkToBudda/AppModules/Chat/ChatViewController.swift:161), [ConversationEmptyTVC.swift](/Users/mac/Documents/hai/TalkToBudda/TalkToBudda/AppModules/History/ConversationEmptyTVC.swift:38).

### P1
- `Scope`: component
- `Code smell`: Card shells are reimplemented repeatedly with near-duplicate border, fill, radius, and shadow values.
- `Impact`: Related list cards and summary surfaces look coherent today, but the code structure guarantees drift because there is no shared card shell abstraction.
- `Fix direction`: Create reusable card builders or style helpers for at least:
  - elevated warm card
  - muted info card
  - list row card
  - premium plan card
- `Evidence`: [CharacterSelectionViewController.swift](/Users/mac/Documents/hai/TalkToBudda/TalkToBudda/AppModules/CharacterSelection/CharacterSelectionViewController.swift:149), [QuotesListViewController.swift](/Users/mac/Documents/hai/TalkToBudda/TalkToBudda/AppModules/QuotesList/QuotesListViewController.swift:359), [MeditationTableViewCell.swift](/Users/mac/Documents/hai/TalkToBudda/TalkToBudda/AppModules/Mediation/MeditationTableViewCell.swift:16), [HistoryViewController.swift](/Users/mac/Documents/hai/TalkToBudda/TalkToBudda/AppModules/History/HistoryViewController.swift:65), [PaywallV2ViewController.swift](/Users/mac/Documents/hai/TalkToBudda/TalkToBudda/AppModules/DirectStore/PaywallV2ViewController.swift:140).

### P1
- `Scope`: component
- `Code smell`: Badge, chip, and pill construction is duplicated with repeated radius `8-10`, local tints, and local font sizing.
- `Impact`: Recommended tags, best-for chips, selected pills, and premium badges are likely to continue diverging because they are all hand-built.
- `Fix direction`: Introduce a shared chip/badge component or helper with variants for neutral, selected, recommended, and premium.
- `Evidence`: [CharacterSelectionViewController.swift](/Users/mac/Documents/hai/TalkToBudda/TalkToBudda/AppModules/CharacterSelection/CharacterSelectionViewController.swift:172), [QuotesListViewController.swift](/Users/mac/Documents/hai/TalkToBudda/TalkToBudda/AppModules/QuotesList/QuotesListViewController.swift:377), [ConversationCell.swift](/Users/mac/Documents/hai/TalkToBudda/TalkToBudda/AppModules/History/ConversationCell.swift:78), [PaywallV2PlanItemView.swift](/Users/mac/Documents/hai/TalkToBudda/TalkToBudda/AppModules/DirectStore/PaywallV2PlanItemView.swift:56).

### P1
- `Scope`: state
- `Code smell`: Selected-state styling is implemented locally in multiple modules with unrelated colors and border logic.
- `Impact`: The product has no shared selected-state language. This weakens learnability and makes state styling harder to maintain.
- `Fix direction`: Define one selected-state contract for warm theme screens and a separate premium variant only if required. Apply it to mood selection, character selection, list sound selection, wisdom options, and plan selection.
- `Evidence`: [CharacterSelectionViewController.swift](/Users/mac/Documents/hai/TalkToBudda/TalkToBudda/AppModules/CharacterSelection/CharacterSelectionViewController.swift:286), [MoodView.swift](/Users/mac/Documents/hai/TalkToBudda/TalkToBudda/AppModules/Mediation/MoodView.swift:41), [ListSoundTVC.swift](/Users/mac/Documents/hai/TalkToBudda/TalkToBudda/AppModules/ListSound/ListSoundTVC.swift:115), [WisdomQuestionLauncherViewController.swift](/Users/mac/Documents/hai/TalkToBudda/TalkToBudda/AppModules/Wisdom/WisdomQuestionLauncherViewController.swift:277), [PaywallV2PlanItemView.swift](/Users/mac/Documents/hai/TalkToBudda/TalkToBudda/AppModules/DirectStore/PaywallV2PlanItemView.swift:49).

### P1
- `Scope`: premium
- `Code smell`: Premium styling is split between a new green premium system and an older unrelated orange/blue purchase system.
- `Impact`: The monetization layer currently contains at least two competing design systems. This increases maintenance cost and undermines premium brand consistency.
- `Fix direction`: Choose one of these paths explicitly:
  - retire the legacy purchase screen
  - keep it but re-theme it onto the new premium system
  - keep both but document them as separate product states
- `Evidence`: [PaywallV2ViewController.swift](/Users/mac/Documents/hai/TalkToBudda/TalkToBudda/AppModules/DirectStore/PaywallV2ViewController.swift:124), [PurchaseViewController.swift](/Users/mac/Documents/hai/TalkToBudda/TalkToBudda/AppModules/DirectStore/PurchaseViewController.swift:234), [PurchaseViewController.swift](/Users/mac/Documents/hai/TalkToBudda/TalkToBudda/AppModules/DirectStore/PurchaseViewController.swift:252), [PurchaseViewController.swift](/Users/mac/Documents/hai/TalkToBudda/TalkToBudda/AppModules/DirectStore/PurchaseViewController.swift:377).

### P2
- `Scope`: spacing
- `Code smell`: Layout rhythm is expressed mostly through repeated raw `inset` and `offset` values rather than shared spacing rules.
- `Impact`: Spacing can remain visually close for now, but it is difficult to keep root screens aligned over time.
- `Fix direction`: Introduce shared spacing constants for root horizontal inset, card internal inset, section gap, compact gap, and bottom action inset.
- `Evidence`: Root screens repeatedly use values like `16`, `18`, `24`, `28`, and `30` across `Quotes`, `Meditation`, `History`, `Scriptures`, and `Chat`, visible for example in [QuotesListViewController.swift](/Users/mac/Documents/hai/TalkToBudda/TalkToBudda/AppModules/QuotesList/QuotesListViewController.swift:145), [MeditationViewController.swift](/Users/mac/Documents/hai/TalkToBudda/TalkToBudda/AppModules/Mediation/MeditationViewController.swift:112), [ChatViewController.swift](/Users/mac/Documents/hai/TalkToBudda/TalkToBudda/AppModules/Chat/ChatViewController.swift:206).

### P2
- `Scope`: radius-shadow
- `Code smell`: Similar surfaces alternate between `18`, `20`, `22`, `24`, `26`, `28`, and `30` radii, with shadow values also varying by local taste.
- `Impact`: This is polish debt rather than a functional problem, but it blocks the product from feeling systematized.
- `Fix direction`: Freeze one radius scale and one shadow scale before further UI iteration. Normalize the most repeated surfaces first, not every view at once.
- `Evidence`: [ChatViewController.swift](/Users/mac/Documents/hai/TalkToBudda/TalkToBudda/AppModules/Chat/ChatViewController.swift:37), [QuotesListViewController.swift](/Users/mac/Documents/hai/TalkToBudda/TalkToBudda/AppModules/QuotesList/QuotesListViewController.swift:178), [PaywallV2ViewController.swift](/Users/mac/Documents/hai/TalkToBudda/TalkToBudda/AppModules/DirectStore/PaywallV2ViewController.swift:141), [MeditationTimerViewController.swift](/Users/mac/Documents/hai/TalkToBudda/TalkToBudda/AppModules/MeditationTimer/MeditationTimerViewController.swift:171).

### P2
- `Scope`: empty-state
- `Code smell`: Empty and loading states are not clearly governed by the same typography and component rules as primary product screens.
- `Impact`: These edge states can regress into placeholder-style UI even while primary screens improve.
- `Fix direction`: Audit empty/loading surfaces as first-class components after tokens and buttons are standardized.
- `Evidence`: [ConversationEmptyTVC.swift](/Users/mac/Documents/hai/TalkToBudda/TalkToBudda/AppModules/History/ConversationEmptyTVC.swift:21), [ChatLoadingTVC.swift](/Users/mac/Documents/hai/TalkToBudda/TalkToBudda/AppModules/Chat/ChatLoadingTVC.swift:16), [BuddaChatMessageCell.swift](/Users/mac/Documents/hai/TalkToBudda/TalkToBudda/AppModules/Chat/BuddaChatMessageCell.swift:22).

## Backlog Recommendation

### Batch 1: Theme Primitives
- Add semantic color aliases above raw palette values.
- Add semantic font roles above raw `FontFamily`.
- Add shared radius and shadow scales.
- Add shared spacing constants for root-screen layout.

### Batch 2: Shared Components
- Create shared primary CTA style.
- Create shared warm card shell.
- Create shared chip/badge style.
- Create shared selected-state styling rules.

### Batch 3: High-Leverage Migration
- Migrate `Onboarding`, `Quotes`, `Meditation`, `Chat`, and `History` onto shared theme primitives.
- Normalize `InputBarView`, `ConversationCell`, `MeditationTableViewCell`, and character cards.

### Batch 4: Premium And Legacy Cleanup
- Decide whether `PurchaseViewController` survives.
- If yes, re-theme it onto one premium language.
- If no, quarantine it as legacy debt and stop using it as reference UI.

## Final Score

`7.1 / 10`

The codebase already contains a real visual direction. The next win is to make that direction enforceable. Right now consistency is mostly handcrafted. The backlog above turns it into a system.
