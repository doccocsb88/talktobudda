//
//  ChatMessageCell.swift
//  TalkToBudda
//
//  Created by mac on 6/5/25.
//

import UIKit
import SnapKit

class ChatMessageCell: UITableViewCell {
    
    let messageLabel = UILabel()
    let bubbleView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        
        selectionStyle = .none
        contentView.addSubview(bubbleView)
        bubbleView.layer.cornerRadius = 12
        bubbleView.clipsToBounds = true
        bubbleView.backgroundColor = UIColor(hexString: "D7CBB7")
        
        messageLabel.numberOfLines = 0
        messageLabel.font = FontFamily.PlayfairDisplay.regular.font(size: 14)
        messageLabel.textColor = .color4B3621
        bubbleView.addSubview(messageLabel)
        
        bubbleView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview().inset(12)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(12)
        }
    }
    
    func configure(message: String, isFromUser: Bool) {
        messageLabel.text = message
        messageLabel.textAlignment = .left
        
        let font = FontFamily.PlayfairDisplay.regular.font(size: 14)
        let width = message.size(usingFont: font).width
        let maxWidth = UIScreen.main.bounds.width - 24 * 2
        var padding: CGFloat = 12
        if width < maxWidth {
            padding =  maxWidth - width
        }
        
        bubbleView.snp.updateConstraints { make in
            make.left.equalToSuperview().inset(padding)
            make.right.equalToSuperview().inset(12)
        }
    }
}
