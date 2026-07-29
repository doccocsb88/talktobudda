# TalkToBudda Code Theme Audit Checklist

Use this checklist when auditing UI consistency directly from source code.

Goal:
- Map visual inconsistency to concrete code smells
- Catch style drift before it ships
- Push fixes toward shared tokens, shared helpers, and shared components

Use this before:
- A UI polish pass
- A theme refactor
- Reviewing a new screen implementation
- Converting `P1` visual findings into engineering tasks

## 1. Audit Strategy

Run the audit in this order:
1. Shared tokens and helpers
2. Root screens
3. Repeated cells, cards, and controls
4. Premium and legacy flows
5. Empty, loading, selected, and disabled states

Prefer proving drift from code in this order:
- shared helper mismatch
- repeated local hardcode
- one-off screen exception

## 2. Color Audit

### What To Flag

- `UIColor(hexString:)` used directly inside screens for common roles
- similar warm browns and creams repeated with slightly different values
- active, selected, and premium colors defined locally per module
- borders and shadows using near-duplicate colors without semantic tokens
- disabled or muted states implemented with arbitrary alpha

### Search Patterns

```sh
grep -R -n "UIColor(hexString:" TalkToBudda/AppModules
grep -R -n "backgroundColor[[:space:]]*=" TalkToBudda/AppModules
grep -R -n "textColor[[:space:]]*=" TalkToBudda/AppModules
grep -R -n "tintColor[[:space:]]*=" TalkToBudda/AppModules
```

### Review Questions

- Is this color serving a semantic role that should come from a shared token?
- Is the same role already implemented with a different hex elsewhere?
- Is this screen introducing a second accent family?
- Is the premium palette intentionally distinct, or just drifting?

### Fix Direction

- Promote repeated roles into semantic tokens such as:
  - `screenBackground`
  - `surfacePrimary`
  - `surfaceSecondary`
  - `textPrimary`
  - `textSecondary`
  - `accentWarm`
  - `accentWarmMuted`
  - `borderSoft`
  - `premiumAccent`

## 3. Typography Audit

### What To Flag

- `UIFont.` system fonts mixed into otherwise custom-themed screens
- `FontFamily` used inconsistently for the same hierarchy role
- `FiraMono` used outside its approved role
- oversized or undersized title scales across root screens
- italic serif used for body or dense content instead of short accent copy

### Search Patterns

```sh
grep -R -n "UIFont\\." TalkToBudda/AppModules
grep -R -n "FontFamily\\." TalkToBudda/AppModules
grep -R -n "titleLabel\\.font\\|subtitleLabel\\.font\\|textLabel\\.font" TalkToBudda/AppModules
```

### Review Questions

- Do root titles all map to one display style?
- Do support labels map to one body or metadata style?
- Is `FiraMono` being used as an accent, or replacing core product typography?
- Is the paywall intentionally using a different hierarchy, or just diverging?

### Fix Direction

- Define typography roles in code, for example:
  - `ThemeFont.display`
  - `ThemeFont.sectionTitle`
  - `ThemeFont.body`
  - `ThemeFont.supporting`
  - `ThemeFont.label`
  - `ThemeFont.eyebrowMono`

## 4. Radius, Border, And Shadow Audit

### What To Flag

- repeated but inconsistent `cornerRadius` values for similar components
- border widths manually set per screen
- cards with slightly different shadow opacity, blur, or offset
- pills, chips, and icon containers not sharing one radius family

### Search Patterns

```sh
grep -R -n "cornerRadius[[:space:]]*=" TalkToBudda/AppModules
grep -R -n "borderWidth[[:space:]]*=" TalkToBudda/AppModules
grep -R -n "shadowColor\\|shadowOpacity\\|shadowOffset\\|shadowRadius" TalkToBudda/AppModules
grep -R -n "\\.rounded(radius:" TalkToBudda/AppModules
```

### Review Questions

- Are these surfaces serving the same role but using `20`, `22`, `24`, or `28` interchangeably?
- Are shadows semantic, or just copied and tweaked locally?
- Does a repeated control have a dedicated styling helper already?

### Fix Direction

- Create shared surface helpers or tokens, for example:
  - `ThemeRadius.card`
  - `ThemeRadius.pill`
  - `ThemeRadius.iconWrap`
  - `ThemeShadow.card`
  - `ThemeBorder.soft`

## 5. Spacing Audit

### What To Flag

- root screens using different horizontal insets without a clear reason
- similar sections using different vertical gap patterns
- repeated card internals using different padding values
- bottom controls sitting at inconsistent distance from safe area

### Search Patterns

```sh
grep -R -n "inset(16)\\|inset(18)\\|inset(20)\\|inset(24)\\|inset(28)\\|inset(30)" TalkToBudda/AppModules
grep -R -n "offset(8)\\|offset(10)\\|offset(12)\\|offset(14)\\|offset(16)\\|offset(18)" TalkToBudda/AppModules
```

### Review Questions

- Is this spacing a reusable rhythm or a local adjustment?
- Are root-screen margins aligned across `Quotes`, `Meditation`, `History`, `Scriptures`, and `Chat`?
- Are chips, badges, and cards padded by one system or by feel?

### Fix Direction

- Introduce shared spacing constants or grouped layout helpers for:
  - root horizontal inset
  - section gap
  - card content inset
  - compact metadata gap
  - bottom safe action inset

## 6. Component Family Audit

### Primary Buttons

Flag:
- different fill colors for the same action role
- mixed font families on primary CTAs
- mixed radii and heights

Search:

```sh
grep -R -n "setTitle(.*for: \\.normal)" TalkToBudda/AppModules
grep -R -n "UIButton" TalkToBudda/AppModules
```

Questions:
- Is this a true primary CTA or just a local emphasized button?
- Can this screen reuse a shared primary button style?

### Chips, Badges, And Pills

Flag:
- repeated `Recommended`, `best for`, or selected pills built ad hoc
- inconsistent label font size and background tint

Search:

```sh
grep -R -n "Recommended\\|bestFor\\|badgeLabel\\|chip\\|pill" TalkToBudda/AppModules
```

Questions:
- Are these all the same component with cosmetic drift?
- Should this be one chip/badge builder?

### Cards And Cells

Flag:
- list rows that look related but are hand-built independently
- repeated avatar, title, metadata, chevron structures

Search:

```sh
grep -R -n "layer.cornerRadius\\|shadowOpacity\\|shadowRadius" TalkToBudda/AppModules/*Cell.swift TalkToBudda/AppModules
```

Questions:
- Could this screen reuse a shared card shell?
- Is the row structure already duplicated in another module?

## 7. State Audit

### Selected

Flag:
- selected states implemented with one-off fills or borders
- selected rows, tabs, plans, or moods using unrelated styles

Search:

```sh
grep -R -n "isSelected\\|selected" TalkToBudda/AppModules
```

Questions:
- Does selected state rely on one predictable pattern?
- Is selection visible without needing careful comparison?

### Disabled

Flag:
- disabled state implemented only by opacity
- disabled text using arbitrary greys

Search:

```sh
grep -R -n "isEnabled\\|alpha\\|disabled" TalkToBudda/AppModules
```

### Empty And Loading

Flag:
- empty states using a different font or tone from the rest of the app
- loading surfaces styled as throwaway placeholders

Search:

```sh
grep -R -n "Empty\\|Loading\\|emptyView\\|isLoading" TalkToBudda/AppModules
```

## 8. Legacy And Premium Audit

### What To Flag

- legacy flows still using system fonts or unrelated palettes
- premium flows introducing a second brand language without explicit design rules
- monetization components not sharing the same token family

### Search Patterns

```sh
grep -R -n "Paywall\\|Purchase\\|Premium\\|Store" TalkToBudda/AppModules/DirectStore
grep -R -n "UIFont\\.|UIColor(hexString:" TalkToBudda/AppModules/DirectStore
```

### Review Questions

- Is this active UI or legacy debt?
- If active, should it match core product or use a controlled premium variant?
- Are there two paywall systems drifting independently?

## 9. Shared Helper Audit

Review these files first before changing individual screens:
- `TalkToBudda/Common/UIColor+Exts.swift`
- `TalkToBudda/Swiftgen/Accessor.assets.swift`
- `TalkToBudda/Swiftgen/Accessor.fonts.swift`
- any shared `UIView` or button styling helpers

Questions:
- Are semantic theme helpers missing entirely?
- Are generated assets available but bypassed by local hex values?
- Is there already a styling helper that screens are ignoring?

## 10. Ticket Format

For each code-audit finding, write:

- `Severity`: `P0`, `P1`, or `P2`
- `Scope`: token, helper, component, screen, or legacy flow
- `Code smell`: the direct source-level issue
- `Impact`: how it causes visual drift
- `Fix direction`: shared token/helper/component first
- `Evidence`: file and line references

Example:

- `P1`
- `Scope`: component
- `Code smell`: Three primary CTAs define local fill colors and local corner radius values instead of using one shared style helper.
- `Impact`: Primary actions do not read as one family across onboarding, meditation, and quotes.
- `Fix direction`: Introduce a shared primary button style and migrate the repeated brown CTA surfaces first.
- `Evidence`: `OnboardingViewController.swift`, `MeditationViewController.swift`, `QuotesListViewController.swift`

## 11. Release Gate

Before closing a code theme audit, confirm:

- repeated common roles are not defined by raw hex in multiple screens
- system fonts are not leaking into custom-themed surfaces without a reason
- repeated CTA, chip, and card styles have an owner
- premium and legacy flows are explicitly classified as shared, premium-only, or legacy debt
- every `P1` finding can be turned into a shared-code task, not just a screen patch
