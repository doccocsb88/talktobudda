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
        holderView.backgroundColor = UIColor(hexString: "FDE8A8")
        holderView.rounded(radius: 22)
        holderView.layer.borderWidth = 1
        holderView.layer.borderColor = UIColor(hexString: "EBCF8E").cgColor
        holderView.layer.shadowColor = UIColor(hexString: "#D7B671").cgColor
        holderView.layer.shadowOpacity = 0.08
        holderView.layer.shadowOffset = CGSize(width: 0, height: 8)
        holderView.layer.shadowRadius = 14
        
        titleLabel.font = FontFamily.PlayfairDisplay.bold.font(size: 17)
        titleLabel.textColor = UIColor(hexString: "6D4321")
        titleLabel.numberOfLines = 2

        descriptionLabel.font = FontFamily.Inter28pt.regular.font(size: 13)
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
            make.top.left.equalToSuperview().offset(14)
            make.width.height.equalTo(56)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(14)
            $0.leading.equalTo(thumbImageView.snp.trailing).offset(14)
            $0.trailing.equalTo(arrowIcon.snp.leading).offset(-10)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
            $0.leading.equalTo(titleLabel)
            $0.right.equalTo(arrowIcon.snp.left).offset(-10)
            $0.bottom.lessThanOrEqualToSuperview().inset(14)
        }

        arrowIcon.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(14)
            $0.width.height.equalTo(16)
        }
    }

    func configure(with entity: ScriptureEntity) {
        titleLabel.text = entity.title
        descriptionLabel.text = condensedDescription(from: entity.description)
        thumbImageView.image = image(for: entity.resourceTag)
    }

    private func image(for resourceTag: ResourceTag) -> UIImage {
        switch resourceTag {
        case .middleDiscourses, .longDiscourses:
            return Asset.Assets.icScriptureTree.image
        case .numberedDiscourses, .linkedDiscourses:
            return Asset.Assets.icScriptureLotus.image
        case .abhidhammaPitaka, .minorCollection:
            return Asset.Assets.icScriptureBudda.image
        case .vinayaPitaka:
            return Asset.Assets.icScriptureVinaya.image
        }
    }

    private func condensedDescription(from description: String) -> String {
        let compact = description.replacingOccurrences(of: "\n", with: " ").trimmingCharacters(in: .whitespacesAndNewlines)
        if compact.count <= 92 {
            return compact
        }

        let index = compact.index(compact.startIndex, offsetBy: 89)
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
