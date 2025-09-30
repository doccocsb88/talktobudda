//
//  ChatLoadingTVC.swift
//  TalkToBudda
//
//  Created by mac on 11/5/25.
//

import UIKit
import SnapKit

class ChatLoadingTVC: BuddaChatMessageCell {
    override func setupUI() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        buddaImageView.backgroundColor = UIColor(hexString: "E5D2AF")
        buddaImageView.rounded(radius: 25)
        buddaImageView.contentMode = .scaleAspectFit
        selectionStyle = .none
        contentView.addSubview(buddaImageView)
        contentView.addSubview(bubbleView)
        
        buddaImageView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(12)
            make.width.height.equalTo(50)
        }
        bubbleView.layer.cornerRadius = 12
        bubbleView.clipsToBounds = true
        bubbleView.backgroundColor = UIColor(hexString: "EDD5AB")
        
        messageLabel.numberOfLines = 0
        messageLabel.font = FontFamily.PlayfairDisplay.regular.font(size: 14)
        messageLabel.textColor = .color4B3621
        bubbleView.addSubview(messageLabel)
        
        bubbleView.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview().inset(12)
            make.left.equalTo(buddaImageView.snp.right).offset(12)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(12)
        }
    }
    
    override func configure(message: String, isFromUser: Bool) {
        messageLabel.text = message
        messageLabel.textAlignment = .left
        
        let font = FontFamily.PlayfairDisplay.regular.font(size: 14)
        let width = message.size(usingFont: font).width
        let maxWidth = UIScreen.main.bounds.width - 24 * 2 - 50
        var padding: CGFloat = 12
        if width < maxWidth {
            padding =  maxWidth - width
        }
        
        bubbleView.snp.updateConstraints { make in
            make.right.equalToSuperview().inset(isFromUser ? 12 : padding)
        }
    }
}
