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
    }
    
    func addShadow() {
        let cornerRadius: CGFloat = 14
        placeHolderView.layer.cornerRadius = cornerRadius
        placeHolderView.layer.maskedCorners = [
            .layerMinXMinYCorner, .layerMaxXMinYCorner,
            .layerMinXMaxYCorner, .layerMaxXMaxYCorner
        ] // tất cả góc
        placeHolderView.layer.masksToBounds = false

        placeHolderView.layer.shadowColor = UIColor.black.cgColor
        placeHolderView.layer.shadowOffset = CGSize(width: 4, height: 2) // X = 2, Y = 1
        placeHolderView.layer.shadowRadius = 3 // Blur = 6 → Radius = Blur / 2 = 3
        placeHolderView.layer.shadowOpacity = 0.1 // 6%

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
        
        [characterImageView, titleLabel, answerLabel, dateLabel].forEach({placeHolderView.addSubview($0)})
        
        titleLabel.font = FontFamily.FiraMono.bold.font(size: 16)
        titleLabel.textColor = UIColor(hexString: "#4B3B2A")

        answerLabel.font = FontFamily.FiraMono.regular.font(size: 16)
        answerLabel.textColor = UIColor(hexString: "#4B3B2A")
        answerLabel.numberOfLines = 2
                
        dateLabel.font = FontFamily.FiraMono.regular.font(size: 12)
        dateLabel.textColor = UIColor(hexString: "#2E2E2E")
        
        placeHolderView.backgroundColor = UIColor(hexString: "FDF8E3")
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
            make.top.equalTo(characterImageView.snp.top).offset(-8)
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
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
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
        characterImageView.image = UIImage(named: character.avatarImageName)
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        dateLabel.text = formatter.string(from: conversation.createdAt)
    }
}
