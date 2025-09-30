//
//  StoreOnePolicyActionView.swift
//  TalkToBudda
//
//  Created by mac on 15/5/25.
//

import SnapKit
import UIKit

class StoreOnePolicyActionView: UIView {
    // Callback closures
    var onPrivacyTapped: (() -> Void)?
    var onRestoreTapped: (() -> Void)?
    var onTermsTapped: (() -> Void)?

    private let stackView = UIStackView()
    private let topPadding: CGFloat
    init(topPadding: CGFloat = 0) {
        self.topPadding = topPadding
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        self.topPadding = 0
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 16

        let privacyButton = makeButton(title: "Privacy Policy", font: FontFamily.SFPro.regular.font(size: 12), textColor: .neutral950)
        privacyButton.addTarget(self, action: #selector(handlePrivacy), for: .touchUpInside)

        let restoreButton = makeButton(title: "Restore", font: FontFamily.SFPro.bold.font(size: 12), textColor: .black)
        restoreButton.addTarget(self, action: #selector(handleRestore), for: .touchUpInside)

        let termsButton = makeButton(title: "Term Of Use", font: FontFamily.SFPro.regular.font(size: 12), textColor: .neutral950)
        termsButton.addTarget(self, action: #selector(handleTerms), for: .touchUpInside)

        [privacyButton, restoreButton, termsButton].forEach { stackView.addArrangedSubview($0) }

        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(topPadding)
            make.left.bottom.right.equalToSuperview()
        }
    }

    private func makeButton(title: String, font: UIFont = .systemFont(ofSize: 14), textColor: UIColor = .white) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(textColor, for: .normal)
        button.titleLabel?.font = font
        return button
    }

    // MARK: - Button Actions

    @objc private func handlePrivacy() {
        onPrivacyTapped?()
    }

    @objc private func handleRestore() {
        onRestoreTapped?()
    }

    @objc private func handleTerms() {
        onTermsTapped?()
    }
}
