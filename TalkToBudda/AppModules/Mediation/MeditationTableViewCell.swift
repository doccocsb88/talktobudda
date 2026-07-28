//
//  MeditationTableViewCell.swift
//  TalkToBudda
//
//  Created by mac on 11/5/25.
//

import UIKit
import SnapKit

class MeditationTableViewCell: UITableViewCell {
    
    // MARK: - UI Elements
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.68)
        view.layer.cornerRadius = 22
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.withAlphaComponent(0.55).cgColor
        view.layer.shadowColor = UIColor(hexString: "#C9AF90").cgColor
        view.layer.shadowOpacity = 0.14
        view.layer.shadowOffset = CGSize(width: 0, height: 12)
        view.layer.shadowRadius = 18
        return view
    }()

    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 34
        imageView.backgroundColor = UIColor(hexString: "#F7EEDF")
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = FontFamily.PlayfairDisplay.bold.font(size: 16)
        label.textColor = UIColor(hexString: "#4B3621")
        label.numberOfLines = 2
        return label
    }()
    
    private let purposeLabel: UILabel = {
        let label = UILabel()
        label.font = FontFamily.Inter28pt.regular.font(size: 14)
        label.textColor = UIColor(hexString: "#6F6A63")
        label.numberOfLines = 2
        return label
    }()
    
//    private let methodLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 12)
//        label.textColor = .darkGray
//        label.numberOfLines = 2
//        return label
//    }()
//    
//    private let benefitsLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 12)
//        label.textColor = .darkGray
//        label.numberOfLines = 2
//        return label
//    }()
//    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(cardView)
        [thumbnailImageView, nameLabel, purposeLabel].forEach(cardView.addSubview)
        thumbnailImageView.contentMode = .scaleAspectFit
        thumbnailImageView.rounded(radius: 34)

        cardView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0))
        }
        
        thumbnailImageView.snp.makeConstraints { make in
            make.width.height.equalTo(68)
            make.leading.equalToSuperview().offset(16)
            make.top.greaterThanOrEqualToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.leading.equalTo(thumbnailImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        purposeLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalTo(nameLabel)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-18)
        }
        
//        methodLabel.snp.makeConstraints { make in
//            make.top.equalTo(purposeLabel.snp.bottom).offset(4)
//            make.leading.equalTo(nameLabel)
//            make.trailing.equalToSuperview().offset(-10)
//        }
//        
//        benefitsLabel.snp.makeConstraints { make in
//            make.top.equalTo(methodLabel.snp.bottom).offset(4)
//            make.leading.equalTo(nameLabel)
//            make.trailing.equalToSuperview().offset(-10)
//            make.bottom.equalToSuperview().offset(-10)
//        }
    }
    
    // MARK: - Configuration
    func configure(with meditation: MeditationCodable) {
        thumbnailImageView.image = Asset.Assets.icMeditation.image
        nameLabel.text = meditation.name
        purposeLabel.text = condensedPurpose(from: meditation.purpose)
//        methodLabel.text = "Method: \(meditation.method)"
//        benefitsLabel.text = "Benefits: \(meditation.benefits)"
    }

    private func condensedPurpose(from purpose: String) -> String {
        let compact = purpose.replacingOccurrences(of: "\n", with: " ").trimmingCharacters(in: .whitespacesAndNewlines)
        if compact.count <= 100 {
            return compact
        }

        let index = compact.index(compact.startIndex, offsetBy: 97)
        return String(compact[..<index]).trimmingCharacters(in: .whitespacesAndNewlines) + "..."
    }
}
