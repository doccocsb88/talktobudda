//
//  ThemeComponents.swift
//  TalkToBudda
//
//  Created by Codex on 28/7/26.
//

import UIKit

final class PrimaryThemeButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }

    convenience init(title: String) {
        self.init(frame: .zero)
        setTitle(title, for: .normal)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sharedInit()
    }

    private func sharedInit() {
        applyPrimaryThemeButtonStyle()
    }
}

final class ThemePillButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sharedInit()
    }

    private func sharedInit() {
        setTitleColor(ThemeColor.textPrimary, for: .normal)
        titleLabel?.font = ThemeFont.label()
        backgroundColor = ThemeColor.surfaceBadge
        layer.cornerRadius = 8
        layer.borderWidth = ThemeBorder.soft
        layer.borderColor = ThemeColor.borderSoft.cgColor
        clipsToBounds = true
    }
}

final class ThemeBackButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sharedInit()
    }

    private func sharedInit() {
        setImage(Asset.Assets.icBack.image.withRenderingMode(.alwaysTemplate), for: .normal)
        imageView?.contentMode = .scaleAspectFit
        tintColor = ThemeColor.textPrimary
        backgroundColor = .clear
        contentHorizontalAlignment = .center
        contentVerticalAlignment = .center
    }
}

final class WarmCardView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyThemeSurface(.warmCard)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyThemeSurface(.warmCard)
    }
}

final class MutedThemeCardView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyThemeSurface(.mutedCard)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyThemeSurface(.mutedCard)
    }
}

final class ThemeChipLabel: UILabel {
    enum Style {
        case warm
        case recommended
    }

    init(style: Style = .warm) {
        super.init(frame: .zero)
        applyStyle(style)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyStyle(.warm)
    }

    func applyStyle(_ style: Style) {
        textAlignment = .center
        clipsToBounds = true
        layer.cornerRadius = ThemeRadius.badge
        font = ThemeFont.label(11)

        switch style {
        case .warm:
            textColor = UIColor(hexString: "#8D6A46")
            backgroundColor = ThemeColor.surfaceBadge
            layer.borderWidth = 0
            layer.borderColor = UIColor.clear.cgColor
        case .recommended:
            textColor = UIColor(hexString: "#8F6A41")
            backgroundColor = UIColor(hexString: "#FAEFD9")
            layer.borderWidth = ThemeBorder.soft
            layer.borderColor = UIColor(hexString: "#EAD6AF").cgColor
        }
    }
}
