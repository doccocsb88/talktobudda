//
//  ScriptureCell.swift
//  TalkToBudda
//
//  Created by mac on 7/5/25.
//

import UIKit
import SnapKit

final class ScriptureCell: UITableViewCell {
    private lazy var holderView = UIView()
    
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let arrowIcon = UIImageView(image: UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysTemplate))

    private lazy var thumbImageView: UIImageView = {
        let imageView = UIImageView(image: Asset.Assets.icScriptureLotus.image)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        selectionStyle = .none
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        holderView.backgroundColor = UIColor(hexString: "FEEABE")
        holderView.rounded(radius: 18)
        holderView.layer.borderWidth = 1
        holderView.layer.borderColor = UIColor(hexString: "EBCF8E").cgColor
        
        titleLabel.font = FontFamily.FiraMono.bold.font(size: 15)
        titleLabel.textColor = UIColor(hexString: "6D4321")
        titleLabel.numberOfLines = 2

        descriptionLabel.font = FontFamily.FiraMono.regular.font(size: 12)
        descriptionLabel.textColor = UIColor(hexString: "7A5A38")
        descriptionLabel.numberOfLines = 2
        
        arrowIcon.contentMode = .scaleAspectFit
        arrowIcon.tintColor = UIColor(hexString: "6D4321")
        
        contentView.addSubview(holderView)
        holderView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12))
        }
        
        [thumbImageView, titleLabel, descriptionLabel, arrowIcon].forEach({holderView.addSubview($0)})

        thumbImageView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(16)
            make.width.height.equalTo(64)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalTo(thumbImageView.snp.trailing).offset(16)
            $0.trailing.equalTo(arrowIcon.snp.leading).offset(-12)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalTo(titleLabel)
            $0.right.equalTo(arrowIcon.snp.left).offset(-12)
            $0.bottom.lessThanOrEqualToSuperview().inset(16)
        }

        arrowIcon.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
            $0.width.height.equalTo(18)
        }
    }

    func configure(with entity: ScriptureEntity) {
        titleLabel.text = entity.title
        descriptionLabel.text = condensedDescription(from: entity.description)
    }

    private func condensedDescription(from description: String) -> String {
        let compact = description.replacingOccurrences(of: "\n", with: " ").trimmingCharacters(in: .whitespacesAndNewlines)
        if compact.count <= 120 {
            return compact
        }

        let index = compact.index(compact.startIndex, offsetBy: 117)
        return String(compact[..<index]).trimmingCharacters(in: .whitespacesAndNewlines) + "..."
    }
}

// MARK: - Module Assembler
final class ScriptureModuleBuilder {
    static func build() -> UIViewController {
        let view = ScriptureViewController()
        let presenter = ScripturePresenter()
        let interactor = ScriptureInteractor()
        let router = ScriptureRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter

        return view
    }
}
