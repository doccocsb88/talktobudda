//
//  OnboardingPageView.swift
//  ResumeBuilder
//
//  Created by mac on 22/4/25.
//

import SnapKit
import UIKit

class OnboardingPageView: UIView {
    private let imageView = UIImageView()
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
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        titleLabel.font = FontFamily.PlayfairDisplay.bold.font(size: 32.scaleHeight(max: 32, min: 26))
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .color7D5A4F

        subtitleLabel.font = FontFamily.PlayfairDisplay.medium.font(size: 16.scaleHeight(max: 16, min: 14))
        subtitleLabel.textAlignment = .center
        subtitleLabel.textColor = .color7D5A4F
        subtitleLabel.numberOfLines = 0

        imageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(hasTopNorth ? 0 : -10)
            make.centerX.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(subtitleLabel.snp_topMargin).offset(-10)
            make.left.right.equalToSuperview().inset(20)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(hasTopNorth ? 130 : 100)
            make.left.right.equalToSuperview().inset(20)
        }
    }
}
