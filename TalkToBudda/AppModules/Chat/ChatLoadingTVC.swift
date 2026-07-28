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
        
        buddaImageView.backgroundColor = UIColor(hexString: "#F5E7D1")
        buddaImageView.rounded(radius: 28)
        buddaImageView.contentMode = .scaleAspectFit
        selectionStyle = .none
        contentView.addSubview(buddaImageView)
        contentView.addSubview(bubbleView)
        
        buddaImageView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(8)
            make.width.height.equalTo(56)
        }
        bubbleView.layer.cornerRadius = 22
        bubbleView.clipsToBounds = true
        bubbleView.backgroundColor = UIColor(hexString: "#FAEFD8")
        
        messageLabel.numberOfLines = 0
        messageLabel.font = FontFamily.Inter28pt.regular.font(size: 18)
        messageLabel.textColor = .color4B3621
        bubbleView.addSubview(messageLabel)
        timeLabel.isHidden = true
        
        bubbleView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.left.equalTo(buddaImageView.snp.right).offset(14)
            make.right.lessThanOrEqualToSuperview().offset(-20)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(18)
        }
    }
    
    func configure(message: String, isFromUser: Bool) {
        messageLabel.text = message
        messageLabel.textAlignment = .left
    }
}
