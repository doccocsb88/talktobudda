//
//  SettingsCell.swift
//  TalkToBudda
//
//  Created by mac on 11/5/25.
//

import UIKit

// MARK: - Custom Cell
class SettingsCell: UITableViewCell {
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCell() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        let stackView = UIStackView(arrangedSubviews: [iconImageView, titleLabel])
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.alignment = .center
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(12)
        }

        iconImageView.snp.makeConstraints { make in
            make.size.equalTo(24)
        }
    }

    func configure(with option: SettingsOption) {
        iconImageView.image = option.icon.withRenderingMode(.alwaysTemplate)
        iconImageView.tintColor = .color4B3621
        titleLabel.text = option.title
        titleLabel.font = FontFamily.FiraMono.regular.font(size: 16)
        titleLabel.textColor = .darkGray
    }
}
