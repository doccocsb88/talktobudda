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
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 1
        return label
    }()
    
    private let purposeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
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
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(purposeLabel)
        thumbnailImageView.contentMode = .scaleAspectFit
        thumbnailImageView.rounded(radius: 30)
        
        thumbnailImageView.snp.makeConstraints { make in
            make.width.height.equalTo(60)
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalTo(thumbnailImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        purposeLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.leading.equalTo(nameLabel)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
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
        purposeLabel.text = meditation.purpose
//        methodLabel.text = "Method: \(meditation.method)"
//        benefitsLabel.text = "Benefits: \(meditation.benefits)"
    }
}
