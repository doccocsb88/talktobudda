//
//  ChatMessageCell.swift
//  TalkToBudda
//
//  Created by mac on 6/5/25.
//

import UIKit
import SnapKit

class BuddaChatMessageCell: ChatMessageCell {

    let buddaImageView = UIImageView(image: Asset.Assets.icBudda02.image)
    private var leadingConstraint: Constraint?
    private var widthConstraint: Constraint?

    override func setupUI() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear

        selectionStyle = .none
        buddaImageView.backgroundColor = UIColor(hexString: "#F5E7D1")
        buddaImageView.rounded(radius: 28)
        buddaImageView.contentMode = .scaleAspectFit
        buddaImageView.clipsToBounds = true
        contentView.addSubview(buddaImageView)
        contentView.addSubview(bubbleView)

        buddaImageView.snp.makeConstraints { make in
            leadingConstraint = make.leading.equalToSuperview().offset(20).constraint
            make.top.equalToSuperview().offset(8)
            widthConstraint = make.width.height.equalTo(56).constraint
        }
        bubbleView.layer.cornerRadius = 22
        bubbleView.clipsToBounds = true
        bubbleView.backgroundColor = UIColor(hexString: "#FAEFD8")

        messageLabel.numberOfLines = 0
        messageLabel.font = FontFamily.Inter28pt.regular.font(size: 18)
        messageLabel.textColor = .color4B3621
        bubbleView.addSubview(messageLabel)
        timeLabel.font = FontFamily.Inter28pt.regular.font(size: 13)
        timeLabel.textColor = UIColor(hexString: "#B9A28A")
        bubbleView.addSubview(timeLabel)

        bubbleView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.equalTo(buddaImageView.snp.trailing).offset(14)
            make.trailing.lessThanOrEqualToSuperview().offset(-20)
            make.width.lessThanOrEqualTo(UIScreen.main.bounds.width * 0.72)
        }

        messageLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(18)
        }

        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(14)
            make.leading.trailing.equalToSuperview().inset(18)
            make.bottom.equalToSuperview().offset(-14)
        }
    }

    override func configure(message: ChatMessage, isFromUser: Bool) {
        super.configure(message: message, isFromUser: isFromUser)
        messageLabel.textAlignment = .left
        timeLabel.textAlignment = .left
    }

    func configure(message: ChatMessage, character: CharacterType?) {
        configure(message: message, isFromUser: false)
        buddaImageView.image = (character ?? .buddha).avatarImage
    }
}
