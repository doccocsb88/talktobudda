//
//  ConversationCell.swift
//  TalkToBudda
//
//  Created by mac on 10/5/25.
//

import UIKit
import SnapKit

class ConversationCell: UITableViewCell {
    static let reuseId = "ConversationCell"
    private let placeHolderView = UIView()
    
    private let titleLabel = UILabel()
    private let answerLabel = UILabel()
    private let dateLabel = UILabel()
    private let characterImageView = UIImageView()
    private let badgeLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.125) {
            self.addShadow()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        addShadow()
    }
    
    func addShadow() {
        let cornerRadius: CGFloat = 14
        placeHolderView.layer.cornerRadius = cornerRadius
        placeHolderView.layer.maskedCorners = [
            .layerMinXMinYCorner, .layerMaxXMinYCorner,
            .layerMinXMaxYCorner, .layerMaxXMaxYCorner
        ] // tất cả góc
        placeHolderView.layer.masksToBounds = false

        placeHolderView.layer.shadowColor = UIColor(hexString: "#D9C8B1").cgColor
        placeHolderView.layer.shadowOffset = CGSize(width: 0, height: 8)
        placeHolderView.layer.shadowRadius = 12
        placeHolderView.layer.shadowOpacity = 0.14

        // Shadow path để khớp với bo góc
        let path = UIBezierPath(roundedRect: placeHolderView.bounds,
                                byRoundingCorners: .allCorners,
                                cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        placeHolderView.layer.shadowPath = path.cgPath
    }
    
    private func setupViews() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(placeHolderView)
        
        [characterImageView, titleLabel, answerLabel, dateLabel, badgeLabel].forEach({placeHolderView.addSubview($0)})
        
        titleLabel.font = FontFamily.PlayfairDisplay.bold.font(size: 18)
        titleLabel.textColor = UIColor(hexString: "#4B3B2A")
        titleLabel.numberOfLines = 2

        answerLabel.font = FontFamily.Inter28pt.regular.font(size: 15)
        answerLabel.textColor = UIColor(hexString: "#6E6256")
        answerLabel.numberOfLines = 2
                
        dateLabel.font = FontFamily.Inter28pt.regular.font(size: 12)
        dateLabel.textColor = UIColor(hexString: "#7E746A")

        badgeLabel.font = FontFamily.Inter28pt.medium.font(size: 10)
        badgeLabel.textColor = UIColor(hexString: "#8D6643")
        badgeLabel.backgroundColor = UIColor(hexString: "#F4E5CF")
        badgeLabel.layer.cornerRadius = 10
        badgeLabel.layer.masksToBounds = true
        badgeLabel.textAlignment = .center
        badgeLabel.text = "Recent"
        
        placeHolderView.backgroundColor = UIColor.white.withAlphaComponent(0.82)
        placeHolderView.rounded(radius: 16)
        
        characterImageView.backgroundColor = UIColor(hexString: "E3D0BF")
        characterImageView.rounded(radius: 14)

        placeHolderView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.left.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(0)
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        characterImageView.snp.makeConstraints { make in
            make.width.height.equalTo(28)
            make.top.equalToSuperview().inset(12)
            make.leading.equalToSuperview().inset(9)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(14)
            make.trailing.equalToSuperview().inset(12)
            make.left.equalTo(characterImageView.snp.right).offset(8)
        }

        answerLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.trailing.equalToSuperview().inset(16)
            make.leading.equalTo(titleLabel.snp.leading)
        }
 
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(answerLabel.snp.bottom).offset(12)
            make.leading.equalTo(titleLabel.snp.leading)
            make.bottom.equalToSuperview().inset(16)
        }

        badgeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(dateLabel)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(20)
            make.width.greaterThanOrEqualTo(52)
        }
    }

    func configure(with conversation: ConversationCodable, index: Int) {
        let fake = conversation
//        if index == 0 {
//            fake.generate1()
//        } else  if index == 1 {
//            fake.generate2()
//        } else {
//            fake.generate()
//        }
        
        if fake.messages.count > 1 {
            titleLabel.text = fake.messages[fake.messages.count - 2].text
            answerLabel.text = fake.messages[fake.messages.count - 1].text
        } else {
            titleLabel.text = fake.messages.last?.text
        }
        
        // Display character information
        let character = conversation.selectedCharacter ?? .buddha
        characterImageView.image = character.avatarImage
        badgeLabel.text = character.displayName.lowercased()
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        dateLabel.text = formatter.string(from: conversation.createdAt)
    }
}
