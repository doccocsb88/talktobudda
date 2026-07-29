//
//  Theme.swift
//  TalkToBudda
//
//  Created by Codex on 28/7/26.
//

import UIKit

enum ThemeColor {
    // Core warm theme
    static let screenBackground = Asset.Colors.colorFDF6ED.color
    static let screenBackgroundMuted = Asset.Colors.colorE9D8C0.color
    static let surfacePrimary = UIColor(hexString: "#FCF9F5")
    static let surfaceSecondary = UIColor.white.withAlphaComponent(0.58)
    static let surfaceMuted = UIColor(hexString: "#F7EFE5")
    static let surfaceBadge = UIColor(hexString: "#F6EEDF")

    static let textPrimary = Asset.Colors.color4B3621.color
    static let textSecondary = UIColor(hexString: "#6E6257")
    static let textTertiary = Asset.Colors.color7D5A4F.color
    static let textMuted = UIColor(hexString: "#B8A28C")

    static let borderSoft = UIColor(hexString: "#E6D2BD")
    static let borderMuted = UIColor(hexString: "#E9D8C5")

    static let accentWarm = UIColor(hexString: "#B77945")
    static let accentWarmStrong = UIColor(hexString: "#9E6A40")
    static let accentWarmMuted = UIColor(hexString: "#D8B17A")
    static let accentGold = UIColor(hexString: "#D2A965")

    // Premium variant
    static let premiumBackground = UIColor(hexString: "#F6F3EA")
    static let premiumSurface = UIColor.white.withAlphaComponent(0.82)
    static let premiumAccent = UIColor(hexString: "#1F5038")
    static let premiumAccentMuted = UIColor(hexString: "#8AA96D")
    static let premiumTextPrimary = UIColor(hexString: "#234B36")
    static let premiumTextSecondary = UIColor(hexString: "#425047")
}

enum ThemeFont {
    static func display(_ size: CGFloat = 28) -> UIFont {
        FontFamily.PlayfairDisplay.bold.font(size: size)
    }

    static func sectionTitle(_ size: CGFloat = 22) -> UIFont {
        FontFamily.PlayfairDisplay.bold.font(size: size)
    }

    static func body(_ size: CGFloat = 15) -> UIFont {
        FontFamily.Inter28pt.regular.font(size: size)
    }

    static func bodyMedium(_ size: CGFloat = 15) -> UIFont {
        FontFamily.Inter28pt.medium.font(size: size)
    }

    static func supporting(_ size: CGFloat = 14) -> UIFont {
        FontFamily.Inter28pt.regular.font(size: size)
    }

    static func label(_ size: CGFloat = 12) -> UIFont {
        FontFamily.Inter28pt.medium.font(size: size)
    }

    static func cta(_ size: CGFloat = 18) -> UIFont {
        FontFamily.PlayfairDisplay.bold.font(size: size)
    }

    static func eyebrowMono(_ size: CGFloat = 11) -> UIFont {
        FontFamily.FiraMono.medium.font(size: size)
    }

    static func accentSerif(_ size: CGFloat = 16) -> UIFont {
        FontFamily.PlayfairDisplay.italic.font(size: size)
    }
}

enum ThemeRadius {
    static let card: CGFloat = 22
    static let cardLarge: CGFloat = 28
    static let control: CGFloat = 18
    static let pill: CGFloat = 20
    static let badge: CGFloat = 9
    static let iconWrap: CGFloat = 22
}

enum ThemeBorder {
    static let soft: CGFloat = 1
    static let selected: CGFloat = 1.5
    static let emphasized: CGFloat = 2
}

enum ThemeSpacing {
    static let screenInset: CGFloat = 16
    static let screenInsetWide: CGFloat = 24
    static let cardInset: CGFloat = 18
    static let compact: CGFloat = 8
    static let contentGap: CGFloat = 12
    static let sectionGap: CGFloat = 16
    static let sectionGapLarge: CGFloat = 24
    static let bottomActionInset: CGFloat = 30
}

struct ThemeShadow {
    let color: UIColor
    let opacity: Float
    let offset: CGSize
    let radius: CGFloat

    static let card = ThemeShadow(
        color: UIColor(hexString: "#C9AF90"),
        opacity: 0.14,
        offset: CGSize(width: 0, height: 8),
        radius: 16
    )

    static let elevatedCTA = ThemeShadow(
        color: ThemeColor.accentWarmStrong,
        opacity: 0.22,
        offset: CGSize(width: 0, height: 12),
        radius: 18
    )

    static let premiumCard = ThemeShadow(
        color: UIColor(hexString: "#D7D0C1"),
        opacity: 0.25,
        offset: CGSize(width: 0, height: 8),
        radius: 16
    )
}

enum ThemeSurfaceStyle {
    case warmCard
    case mutedCard
    case premiumCard
}

extension UIView {
    func applyThemeSurface(_ style: ThemeSurfaceStyle) {
        switch style {
        case .warmCard:
            backgroundColor = ThemeColor.surfacePrimary
            layer.cornerRadius = ThemeRadius.card
            layer.borderWidth = ThemeBorder.soft
            layer.borderColor = ThemeColor.borderSoft.cgColor
            applyThemeShadow(.card)
        case .mutedCard:
            backgroundColor = ThemeColor.surfaceSecondary
            layer.cornerRadius = ThemeRadius.card
            layer.borderWidth = ThemeBorder.soft
            layer.borderColor = UIColor.white.withAlphaComponent(0.45).cgColor
            layer.shadowOpacity = 0
            layer.shadowRadius = 0
            layer.shadowOffset = .zero
            layer.shadowColor = UIColor.clear.cgColor
        case .premiumCard:
            backgroundColor = ThemeColor.premiumSurface
            layer.cornerRadius = ThemeRadius.cardLarge
            layer.borderWidth = ThemeBorder.soft
            layer.borderColor = UIColor(hexString: "#E0DDD1").cgColor
            applyThemeShadow(.premiumCard)
        }
    }

    func applyThemeShadow(_ shadow: ThemeShadow) {
        layer.shadowColor = shadow.color.cgColor
        layer.shadowOpacity = shadow.opacity
        layer.shadowOffset = shadow.offset
        layer.shadowRadius = shadow.radius
    }
}

extension UIButton {
    func applyPrimaryThemeButtonStyle() {
        setTitleColor(.white, for: .normal)
        titleLabel?.font = ThemeFont.cta()
        backgroundColor = ThemeColor.accentWarm
        layer.cornerRadius = ThemeRadius.control
        applyThemeShadow(.elevatedCTA)
    }

    func applyPremiumThemeButtonStyle() {
        setTitleColor(.white, for: .normal)
        titleLabel?.font = ThemeFont.cta()
        backgroundColor = ThemeColor.premiumAccent
        layer.cornerRadius = 26
        layer.shadowOpacity = 0
        layer.shadowRadius = 0
        layer.shadowOffset = .zero
        layer.shadowColor = UIColor.clear.cgColor
    }
}

extension UILabel {
    func applyThemeTextStyle(
        font: UIFont,
        color: UIColor,
        alignment: NSTextAlignment = .natural,
        numberOfLines: Int = 1
    ) {
        self.font = font
        self.textColor = color
        textAlignment = alignment
        self.numberOfLines = numberOfLines
    }
}
