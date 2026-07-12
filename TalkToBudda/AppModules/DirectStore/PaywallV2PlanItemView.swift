//
//  PaywallV2PlanItemView.swift
//  TalkToBudda
//
//  Created by Codex on 12/7/26.
//

import UIKit
import SnapKit

final class PaywallV2PlanItemView: UIView {
    private let badgeLabel = UILabel()
    private let iconView = UIImageView()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let captionLabel = UILabel()

    init(
        title: String,
        priceText: String,
        captionText: String,
        isSelected: Bool,
        isPromoted: Bool,
        isTrial: Bool
    ) {
        super.init(frame: .zero)
        setupUI(
            title: title,
            priceText: priceText,
            captionText: captionText,
            isSelected: isSelected,
            isPromoted: isPromoted,
            isTrial: isTrial
        )
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupUI(
        title: String,
        priceText: String,
        captionText: String,
        isSelected: Bool,
        isPromoted: Bool,
        isTrial: Bool
    ) {
        layer.cornerRadius = 26
        layer.borderWidth = isSelected ? 2 : 1
        layer.borderColor = (isSelected ? UIColor(hexString: "#8AA96D") : UIColor(hexString: "#E8E3D8")).withAlphaComponent(0.6).cgColor
        backgroundColor = isSelected ? UIColor(hexString: "#1F5038") : UIColor.white.withAlphaComponent(0.8)

        badgeLabel.text = "BEST VALUE"
        badgeLabel.textAlignment = .center
        badgeLabel.font = FontFamily.FiraMono.medium.font(size: 10)
        badgeLabel.textColor = .white
        badgeLabel.backgroundColor = UIColor(hexString: "#8AA96D")
        badgeLabel.layer.cornerRadius = 8
        badgeLabel.layer.masksToBounds = true
        badgeLabel.isHidden = !isPromoted

        let iconImage = isSelected
            ? Asset.Assets.icLotus.image.withRenderingMode(.alwaysTemplate)
            : UIImage(named: "paywall-v2-plan-leaf")
        iconView.image = iconImage
        iconView.tintColor = isSelected ? UIColor(hexString: "#93B67B") : nil
        iconView.contentMode = .scaleAspectFit

        titleLabel.text = title
        titleLabel.font = FontFamily.PlayfairDisplay.bold.font(size: isTrial ? 14 : 15)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        titleLabel.textColor = isSelected ? .white : UIColor(hexString: "#234B36")

        priceLabel.text = priceText
        priceLabel.font = FontFamily.PlayfairDisplay.bold.font(size: isSelected ? 16 : 17)
        priceLabel.textAlignment = .center
        priceLabel.numberOfLines = 0
        priceLabel.textColor = isSelected ? .white : UIColor(hexString: "#1D2920")

        captionLabel.text = captionText
        captionLabel.font = FontFamily.Inter28pt.regular.font(size: 11)
        captionLabel.textAlignment = .center
        captionLabel.numberOfLines = isTrial ? 2 : 1
        captionLabel.textColor = isSelected ? UIColor.white.withAlphaComponent(0.82) : UIColor(hexString: "#73766F")

        [badgeLabel, iconView, titleLabel, priceLabel, captionLabel].forEach(addSubview)

        badgeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-8)
            make.centerX.equalToSuperview()
            make.width.equalTo(96)
            make.height.equalTo(28)
        }

        iconView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(isPromoted ? 24 : 12)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(24)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconView.snp.bottom).offset(isTrial ? 6 : 8)
            make.left.right.equalToSuperview().inset(8)
        }

        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(isTrial ? 6 : 8)
            make.left.right.equalToSuperview().inset(6)
        }

        captionLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(6)
            make.left.right.equalToSuperview().inset(6)
            make.bottom.lessThanOrEqualToSuperview().inset(14)
        }
    }
}
