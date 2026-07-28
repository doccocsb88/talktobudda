//
//  ChatMessageCell.swift
//  TalkToBudda
//
//  Created by mac on 6/5/25.
//

import UIKit
import SnapKit

class ChatMessageCell: UITableViewCell {

    let bubbleView = UIView()
    let messageLabel = UILabel()
    let timeLabel = UILabel()
    private var leadingConstraint: Constraint?
    private var trailingConstraint: Constraint?

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
        bubbleView.layer.cornerRadius = 22
        bubbleView.clipsToBounds = true
        bubbleView.backgroundColor = UIColor(hexString: "#F8EEE1")

        messageLabel.numberOfLines = 0
        messageLabel.font = FontFamily.Inter28pt.regular.font(size: 18)
        messageLabel.textColor = .color4B3621
        bubbleView.addSubview(messageLabel)

        timeLabel.font = FontFamily.Inter28pt.regular.font(size: 13)
        timeLabel.textColor = UIColor(hexString: "#B9A28A")
        bubbleView.addSubview(timeLabel)

        bubbleView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.width.lessThanOrEqualTo(UIScreen.main.bounds.width * 0.72)
            leadingConstraint = make.leading.equalToSuperview().offset(88).constraint
            trailingConstraint = make.trailing.equalToSuperview().offset(-20).constraint
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

    func configure(message: ChatMessage, isFromUser: Bool) {
        messageLabel.text = message.text
        timeLabel.text = Self.timeFormatter.string(from: message.createdAt)
        messageLabel.textAlignment = .left
        bubbleView.backgroundColor = isFromUser ? UIColor(hexString: "#F2E4CE") : UIColor(hexString: "#FAEFD8")
        leadingConstraint?.update(offset: isFromUser ? 88 : 20)
        trailingConstraint?.update(offset: isFromUser ? -20 : -88)
        timeLabel.textAlignment = isFromUser ? .right : .left
    }

    private static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
}
