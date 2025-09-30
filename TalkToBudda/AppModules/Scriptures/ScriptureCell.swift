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
        holderView.rounded(radius: 12)
        
        titleLabel.font = FontFamily.FiraMono.bold.font(size: 16)
        titleLabel.textColor = UIColor(hexString: "6D4321")
        descriptionLabel.font = FontFamily.FiraMono.regular.font(size: 14)
        descriptionLabel.textColor = UIColor(hexString: "6D4321")
        descriptionLabel.numberOfLines = 3
        
        arrowIcon.contentMode = .scaleAspectFit
        arrowIcon.tintColor = .neutral950
        
        contentView.addSubview(holderView)
        holderView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(4)
            make.center.equalToSuperview()
        }
        
        [thumbImageView, titleLabel, descriptionLabel, arrowIcon].forEach({holderView.addSubview($0)})

        thumbImageView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(16)
            make.width.height.equalTo(60)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalTo(thumbImageView.snp.trailing).offset(16)
            $0.trailing.lessThanOrEqualTo(arrowIcon.snp.leading).offset(-8)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(titleLabel)
            $0.right.equalTo(arrowIcon.snp.left).offset(-8)
        }

        arrowIcon.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
            $0.width.height.equalTo(20)
        }
    }

    func configure(with entity: ScriptureEntity) {
        titleLabel.text = entity.title
        descriptionLabel.text = entity.description
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
