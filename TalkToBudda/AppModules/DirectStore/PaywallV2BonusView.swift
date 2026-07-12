//
//  PaywallV2BonusView.swift
//  TalkToBudda
//
//  Created by Codex on 12/7/26.
//

import UIKit
import SnapKit

final class PaywallV2BonusView: UIView {
    private let iconWrapView = UIView()
    private let iconView = UIImageView(image: UIImage(named: "paywall-v2-bonus-gift"))
    private let textStackView = UIStackView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let priceButton = UIButton(type: .system)

    var onPriceTapped: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    func setPriceTitle(_ title: String) {
        priceButton.setTitle(title, for: .normal)
    }

    private func setupUI() {
        backgroundColor = UIColor.white.withAlphaComponent(0.88)
        layer.cornerRadius = 14
        layer.borderWidth = 1
        layer.borderColor = UIColor(hexString: "#E5E0D4").cgColor

        [iconWrapView, textStackView, priceButton].forEach(addSubview)
        iconWrapView.addSubview(iconView)
        [titleLabel, subtitleLabel].forEach(textStackView.addArrangedSubview)

        iconWrapView.backgroundColor = .clear
        iconWrapView.layer.cornerRadius = 16

        iconView.contentMode = .scaleAspectFit
        iconView.clipsToBounds = true
        iconView.layer.cornerRadius = 20

        textStackView.axis = .vertical
        textStackView.alignment = .leading
        textStackView.spacing = 2

        titleLabel.text = "Get 10 bonus chats"
        titleLabel.numberOfLines = 1
        titleLabel.font = FontFamily.PlayfairDisplay.bold.font(size: 15)
        titleLabel.textColor = UIColor(hexString: "#274934")

        subtitleLabel.text = "for deeper daily practice."
        subtitleLabel.numberOfLines = 1
        subtitleLabel.font = FontFamily.PlayfairDisplay.regular.font(size: 12)
        subtitleLabel.textColor = UIColor(hexString: "#274934")

        priceButton.backgroundColor = UIColor(hexString: "#1F5038")
        priceButton.setTitleColor(.white, for: .normal)
        priceButton.titleLabel?.font = FontFamily.PlayfairDisplay.bold.font(size: 13)
        priceButton.layer.cornerRadius = 10
        priceButton.addTarget(self, action: #selector(handlePriceTapped), for: .touchUpInside)

        iconWrapView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(14)
            make.width.height.equalTo(40)
        }

        iconView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(40)
        }

        textStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(iconWrapView.snp.right).offset(14)
        }

        priceButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(14)
            make.width.equalTo(90)
            make.height.equalTo(40)
            make.left.greaterThanOrEqualTo(textStackView.snp.right).offset(12)
        }
    }

    @objc private func handlePriceTapped() {
        onPriceTapped?()
    }
}
