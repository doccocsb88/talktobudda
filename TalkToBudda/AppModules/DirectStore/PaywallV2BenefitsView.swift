//
//  PaywallV2BenefitsView.swift
//  TalkToBudda
//
//  Created by Codex on 12/7/26.
//

import UIKit
import SnapKit

final class PaywallV2BenefitsView: UIView {
    private let stackView = UIStackView()
    private let items: [(String, String)]

    init(items: [(String, String)]) {
        self.items = items
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        self.items = []
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        backgroundColor = UIColor(hexString: "#244A35").withAlphaComponent(0.96)
        layer.cornerRadius = 14
        layer.borderWidth = 1
        layer.borderColor = UIColor(hexString: "#45644B").cgColor

        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill

        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        items.enumerated().forEach { index, item in
            stackView.addArrangedSubview(
                makeBenefitItem(
                    imageName: item.0,
                    title: item.1,
                    showsDivider: index < items.count - 1
                )
            )
        }
    }

    private func makeBenefitItem(imageName: String, title: String, showsDivider: Bool) -> UIView {
        let container = UIView()

        let iconWrapView = UIView()
        iconWrapView.backgroundColor = .clear
        iconWrapView.layer.cornerRadius = 20

        let iconView = UIImageView(image: UIImage(named: imageName))
        iconView.contentMode = .scaleAspectFit
        iconView.clipsToBounds = true
        iconView.layer.cornerRadius = 20

        let textLabel = UILabel()
        textLabel.text = title
        textLabel.numberOfLines = 2
        textLabel.textAlignment = .center
        textLabel.font = FontFamily.Inter28pt.medium.font(size: 11)
        textLabel.textColor = UIColor.white.withAlphaComponent(0.94)

        [iconWrapView, textLabel].forEach(container.addSubview)
        iconWrapView.addSubview(iconView)

        iconWrapView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(40)
        }

        iconView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(40)
        }

        textLabel.snp.makeConstraints { make in
            make.top.equalTo(iconWrapView.snp.bottom).offset(6)
            make.left.right.equalToSuperview().inset(6)
        }

        if showsDivider {
            let dividerView = UIView()
            dividerView.backgroundColor = UIColor.white.withAlphaComponent(0.28)
            container.addSubview(dividerView)
            dividerView.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview().inset(22)
                make.right.equalToSuperview()
                make.width.equalTo(1)
            }
        }

        return container
    }
}
