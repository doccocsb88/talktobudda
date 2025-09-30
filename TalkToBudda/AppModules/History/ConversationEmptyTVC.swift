//
//  ConversationEmptyTVC.swift
//  TalkToBudda
//
//  Created by mac on 11/5/25.
//

import UIKit
import SnapKit

class ConversationEmptyTVC: UITableViewCell {
    private let lotusIcon: UIImageView = {
         let imageView = UIImageView()
        imageView.image = Asset.Assets.icLotus.image // Đặt tên file ảnh là "lotus_icon.png"
         imageView.contentMode = .scaleAspectFit
         return imageView
     }()
     
     private let titleLabel: UILabel = {
         let label = UILabel()
         label.text = "No Conversations Yet"
         label.font = FontFamily.FiraMono.medium.font(size: 18)
         label.textColor = .color4B3621
         label.textAlignment = .center
         return label
     }()
     
     private let subtitleLabel: UILabel = {
         let label = UILabel()
         label.text = "Start a conversation to see your journey here."
         label.font = FontFamily.FiraMono.regular.font(size: 14)
         label.textColor = .color7D5A4F
         label.numberOfLines = 0
         label.textAlignment = .center
         return label
     }()
     
     private let startButton: UIButton = {
         let button = UIButton(type: .system)
         button.setTitle("Begin Your Journey", for: .normal)
         button.setTitleColor(.colorFDF6ED, for: .normal)
         button.titleLabel?.font = FontFamily.FiraMono.medium.font(size: 18)
         button.backgroundColor = .color7D5A4F
         button.setTitleColor(.white, for: .normal)
         button.layer.cornerRadius = 8
         button.addTarget(self, action: #selector(beginJourneyTapped), for: .touchUpInside)
         return button
     }()
    
    var tappedStartHandler: (()->())?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        animateLotusGlow()
        animateFadeIn()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        contentView.addSubview(lotusIcon)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(startButton)
        
        lotusIcon.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-100)
            make.size.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(lotusIcon.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(32)
        }
        
        startButton.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.width.equalTo(240)
            make.height.equalTo(44)
        }
    }
    
    // MARK: - Animations
    
    // 🌼 Pulsing Glow Animation
    private func animateLotusGlow() {
        UIView.animate(withDuration: 1.5,
                       delay: 0,
                       options: [.repeat, .autoreverse, .allowUserInteraction],
                       animations: {
            self.lotusIcon.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }, completion: nil)
    }
    
    // 🌼 Fade-in Effect
    private func animateFadeIn() {
        lotusIcon.alpha = 0
        titleLabel.alpha = 0
        subtitleLabel.alpha = 0
        startButton.alpha = 0
        
        UIView.animate(withDuration: 1.0) {
            self.lotusIcon.alpha = 1
            self.titleLabel.alpha = 1
            self.subtitleLabel.alpha = 1
            self.startButton.alpha = 1
        }
    }
    
    // 🌼 Ripple Effect for Button
    @objc private func beginJourneyTapped() {
//        let rippleLayer = CALayer()
//        rippleLayer.frame = startButton.bounds
//        rippleLayer.backgroundColor = UIColor.white.cgColor
//        rippleLayer.cornerRadius = startButton.layer.cornerRadius
//        startButton.layer.insertSublayer(rippleLayer, at: 0)
//        
//        CATransaction.begin()
//        CATransaction.setCompletionBlock {
//            rippleLayer.removeFromSuperlayer()
//        }
//        
//        let animation = CABasicAnimation(keyPath: "opacity")
//        animation.fromValue = 0.3
//        animation.toValue = 0
//        animation.duration = 0.5
//        rippleLayer.add(animation, forKey: "rippleEffect")
//        
//        CATransaction.commit()
//        
//        print("Button Tapped - Begin Your Journey")
        tappedStartHandler?()
    }
}
