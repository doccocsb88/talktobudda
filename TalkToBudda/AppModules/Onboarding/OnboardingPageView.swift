//
//  OnboardingPageView.swift
//  ResumeBuilder
//
//  Created by mac on 22/4/25.
//

import SnapKit
import UIKit

class OnboardingPageView: UIView {
    private let textureView = UIView()
    private let imageView = UIImageView()
    private let gradientView = UIView()
    private let copyContainerView = UIView()
    private let eyebrowLabel = UILabel()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()

    private let imageRatio: CGFloat
    init(image: UIImage?, title: String, subtitle: String) {
        let size = image?.size ?? CGSize(width: 100, height: 100)
        imageRatio = size.height / size.width
        super.init(frame: .zero)
        setupUI()
        imageView.image = image
        titleLabel.text = title
        subtitleLabel.text = subtitle

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        clipsToBounds = true
        backgroundColor = .colorFDF6ED
        addSubview(textureView)
        addSubview(imageView)
        addSubview(gradientView)
        addSubview(copyContainerView)
        [eyebrowLabel, titleLabel, subtitleLabel].forEach(copyContainerView.addSubview)

        textureView.backgroundColor = UIColor.white.withAlphaComponent(0.12)
        gradientView.isUserInteractionEnabled = false
        copyContainerView.backgroundColor = UIColor.white.withAlphaComponent(0.32)
        copyContainerView.layer.cornerRadius = 28
        copyContainerView.layer.borderWidth = 1
        copyContainerView.layer.borderColor = UIColor.white.withAlphaComponent(0.45).cgColor

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        eyebrowLabel.text = "daily guidance"
        eyebrowLabel.font = FontFamily.FiraMono.medium.font(size: 12)
        eyebrowLabel.textAlignment = .center
        eyebrowLabel.textColor = .color7D5A4F
        eyebrowLabel.alpha = 0.82
        
        titleLabel.font = FontFamily.PlayfairDisplay.bold.font(size: 32.scaleHeight(max: 32, min: 26))
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .color4B3621

        subtitleLabel.font = FontFamily.Inter28pt.medium.font(size: 16.scaleHeight(max: 16, min: 14))
        subtitleLabel.textAlignment = .center
        subtitleLabel.textColor = .color7D5A4F
        subtitleLabel.numberOfLines = 0

        textureView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        imageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(hasTopNorth ? 0 : -10)
            make.centerX.equalToSuperview()
        }

        gradientView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.48)
        }

        copyContainerView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(hasTopNorth ? 112 : 88)
        }

        eyebrowLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(22)
            make.left.right.equalToSuperview().inset(20)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(eyebrowLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(20)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(22)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if gradientView.layer.sublayers?.isEmpty != false {
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [
                UIColor.clear.cgColor,
                UIColor(hexString: "#FDF6ED").withAlphaComponent(0.18).cgColor,
                UIColor(hexString: "#FDF6ED").withAlphaComponent(0.94).cgColor
            ]
            gradientLayer.locations = [0, 0.45, 1]
            gradientLayer.frame = gradientView.bounds
            gradientView.layer.insertSublayer(gradientLayer, at: 0)
        } else {
            gradientView.layer.sublayers?.first?.frame = gradientView.bounds
        }
    }
}
