# TalkToBudda `AppIcon.appiconset` Export Spec

## Scope

This spec prepares the chosen `Speech Path + Halo` candidate for export into:

- [TalkToBudda/Resources/Assets/Assets.xcassets/AppIcon/AppIcon.appiconset/Contents.json](/Users/mac/Documents/hai/TalkToBudda/TalkToBudda/Resources/Assets/Assets.xcassets/AppIcon/AppIcon.appiconset/Contents.json)
- active Xcode app icon set name: `AppIcon` in [TalkToBudda.xcodeproj/project.pbxproj](/Users/mac/Documents/hai/TalkToBudda/TalkToBudda.xcodeproj/project.pbxproj:343)

Current visual source candidate:
- `/Users/mac/.codex/generated_images/019fa98e-cc03-7d31-9876-c96ac9b3039b/call_d8J6un6HesKkZzvulA3ZwQln.png`

## Visual Master

Use one square master artboard:
- size: `1024 x 1024`
- color space: `sRGB`
- background: solid `#1D3102`
- symbol: solid `#FDF6ED`
- no text
- no texture
- no glow required for shipping asset
- no transparency at the canvas edge

## Final Icon Geometry

Intent:
- open halo enclosing a guided inner speech-path
- calm, centered, premium, iconic

Manual cleanup before raster export:
1. Thicken the lowest segment of the inner path slightly.
2. Normalize stroke endings so the symbol feels vector-clean.
3. Check optical centering inside the rounded-square iOS crop.
4. Keep the halo gap balanced left/right.
5. Keep the inner path clearly separated from the halo at small size.

## Optical Safe Area

Do not push the symbol to the outer edge.

Recommended working bounds inside the `1024 x 1024` artboard:
- keep all ivory symbol pixels inside an approximate `820 x 820` live area
- target outer halo diameter around `700` to `760` px
- leave generous corner breathing room because iOS applies rounded-corner masking

Small-size rule:
- if the 29 px preview starts losing the lower tail, enlarge or thicken the inner path before export

## Export Mapping

Export exact filenames already referenced by `Contents.json`:

| Filename | Pixel Size | Usage |
|---|---:|---|
| `29.png` | `29 x 29` | iPhone settings / spotlight legacy |
| `40.png` | `40 x 40` | `20pt @2x` |
| `57.png` | `57 x 57` | legacy iPhone |
| `58.png` | `58 x 58` | `29pt @2x` |
| `60.png` | `60 x 60` | `20pt @3x` |
| `80.png` | `80 x 80` | `40pt @2x` |
| `87.png` | `87 x 87` | `29pt @3x` |
| `114.png` | `114 x 114` | `57pt @2x` legacy |
| `120.png` | `120 x 120` | shared for `40pt @3x` and `60pt @2x` |
| `180.png` | `180 x 180` | `60pt @3x` |
| `1024.png` | `1024 x 1024` | App Store marketing |

## Raster Export Rules

- Export from the cleaned vector master, not by upscaling the board image.
- Use exact square outputs with no padding added after export.
- Keep edges crisp; avoid JPEG.
- Output format: `PNG`
- Background must be baked in; do not export transparent icons.
- Do not create separate dark/light variants for this set.

## QA Checklist Before Replacing Assets

Check each exported file:
- dimensions exactly match filename target
- no alpha fringe on the outer edge
- no off-center symbol drift
- halo ends remain visible after downscaling
- inner path tail is still readable at `29 x 29`
- forest green remains consistent across all sizes

Spot-check previews:
- `29.png`
- `40.png`
- `60.png`
- `1024.png`

If one of these fails visually, go back to the vector master rather than editing individual PNG files independently.

## Replacement Plan

When ready to swap assets:
1. Keep `Contents.json` unchanged.
2. Replace only these PNG files inside [AppIcon.appiconset](/Users/mac/Documents/hai/TalkToBudda/TalkToBudda/Resources/Assets/Assets.xcassets/AppIcon/AppIcon.appiconset).
3. Verify filenames remain exactly:
   - `29.png`
   - `40.png`
   - `57.png`
   - `58.png`
   - `60.png`
   - `80.png`
   - `87.png`
   - `114.png`
   - `120.png`
   - `180.png`
   - `1024.png`
4. Open the asset catalog in Xcode and confirm the `AppIcon` set resolves without warnings.
5. Run one device or simulator visual check on the installed app icon.

## Non-Goals

This spec does not yet:
- generate the final vector master
- export the production PNGs
- replace any shipping app icon files
