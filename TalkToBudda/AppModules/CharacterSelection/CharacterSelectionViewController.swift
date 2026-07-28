//
//  CharacterSelectionViewController.swift
//  TalkToBudda
//
//  Created by mac on 6/5/25.
//

import UIKit
import SnapKit

protocol CharacterSelectionDelegate: AnyObject {
    func didSelectCharacter(_ character: CharacterType)
}

class CharacterSelectionViewController: UIViewController {

    weak var delegate: CharacterSelectionDelegate?
    var dismissesOnSelection = true
    private var selectedCharacter: CharacterType?
    private let shouldShowRecommendedStarter = !PreferenceService.shared.hasStartedFirstCharacterChat

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let backButton = UIButton(type: .system)
    private let titleLabel = UILabel()
    private let dividerRow = UIStackView()
    private let leftDivider = UIView()
    private let centerIconView = UIImageView()
    private let rightDivider = UIView()
    private let subtitleLabel = UILabel()
    private let characterStackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCharacters()
    }

    private func setupUI() {
        view.backgroundColor = .colorFDF6ED

        view.addSubview(backButton)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(titleLabel)
        contentView.addSubview(dividerRow)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(characterStackView)

        backButton.setImage(Asset.Assets.icBack.image.withRenderingMode(.alwaysTemplate), for: .normal)
        backButton.tintColor = .color4B3621
        backButton.backgroundColor = UIColor(hexString: "#F7EFE5")
        backButton.layer.cornerRadius = 22
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)

        titleLabel.text = "Choose Your Guide"
        titleLabel.font = FontFamily.PlayfairDisplay.bold.font(size: 30)
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor(hexString: "#4B3621")

        dividerRow.axis = .horizontal
        dividerRow.alignment = .center
        dividerRow.distribution = .fill
        dividerRow.spacing = 12
        [leftDivider, centerIconView, rightDivider].forEach { dividerRow.addArrangedSubview($0) }
        leftDivider.backgroundColor = UIColor(hexString: "#EAD7BC")
        rightDivider.backgroundColor = UIColor(hexString: "#EAD7BC")
        centerIconView.image = Asset.Assets.icLotus.image.withRenderingMode(.alwaysTemplate)
        centerIconView.tintColor = UIColor(hexString: "#D2A965")
        centerIconView.contentMode = .scaleAspectFit

        subtitleLabel.text = shouldShowRecommendedStarter
            ? "Choose a guide to begin. You can switch later, and Buddha is a gentle place to start."
            : "Choose the guide that best fits this moment. You can switch again later."
        subtitleLabel.font = FontFamily.Inter28pt.regular.font(size: 17)
        subtitleLabel.textAlignment = .center
        subtitleLabel.textColor = UIColor(hexString: "#8A7866")
        subtitleLabel.numberOfLines = 0

        characterStackView.axis = .vertical
        characterStackView.spacing = 18
        characterStackView.distribution = .fill

        setupConstraints()
    }

    private func setupConstraints() {
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(6)
            make.left.equalToSuperview().inset(24)
            make.width.height.equalTo(44)
        }

        scrollView.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(8)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(22)
            make.leading.trailing.equalToSuperview().inset(28)
        }

        dividerRow.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(18)
            make.centerX.equalToSuperview()
            make.width.equalTo(180)
        }

        leftDivider.snp.makeConstraints { make in
            make.height.equalTo(1)
        }

        rightDivider.snp.makeConstraints { make in
            make.height.equalTo(1)
        }

        centerIconView.snp.makeConstraints { make in
            make.width.height.equalTo(28)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(dividerRow.snp.bottom).offset(18)
            make.leading.trailing.equalToSuperview().inset(38)
        }

        characterStackView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(28)
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().offset(-44)
        }
    }

    private func setupCharacters() {
        for characterType in CharacterType.allCases {
            let characterView = createCharacterView(for: characterType)
            characterStackView.addArrangedSubview(characterView)
        }
    }

    private func createCharacterView(for characterType: CharacterType) -> UIView {
        let containerView = UIView()
        containerView.backgroundColor = UIColor(hexString: "#FCF9F5")
        containerView.layer.cornerRadius = 22
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor(hexString: "#E6D2BD").cgColor
        containerView.layer.shadowColor = UIColor(hexString: "#CFB28A").cgColor
        containerView.layer.shadowOpacity = 0.08
        containerView.layer.shadowRadius = 16
        containerView.layer.shadowOffset = CGSize(width: 0, height: 8)

        let character = Character(type: characterType)
        
        let avatarImageView = UIImageView()
        avatarImageView.image = character.avatarImage
        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.backgroundColor = UIColor(hexString: "#F6E7D1")
        avatarImageView.layer.cornerRadius = 30
        avatarImageView.clipsToBounds = true

        let nameLabel = UILabel()
        nameLabel.text = character.name
        nameLabel.font = FontFamily.PlayfairDisplay.bold.font(size: 22)
        nameLabel.textColor = UIColor(hexString: "#4B3621")

        let recommendedLabel = UILabel()
        recommendedLabel.text = "Recommended"
        recommendedLabel.font = FontFamily.Inter28pt.semiBold.font(size: 12)
        recommendedLabel.textColor = UIColor(hexString: "#8F6A41")
        recommendedLabel.backgroundColor = UIColor(hexString: "#F8E6C7")
        recommendedLabel.textAlignment = .center
        recommendedLabel.layer.cornerRadius = 10
        recommendedLabel.layer.borderWidth = 1
        recommendedLabel.layer.borderColor = UIColor(hexString: "#E4C48F").cgColor
        recommendedLabel.clipsToBounds = true
        recommendedLabel.isHidden = !(shouldShowRecommendedStarter && characterType == .buddha)

        let titleRow = UIStackView()
        titleRow.axis = .horizontal
        titleRow.alignment = .center
        titleRow.spacing = 8

        let descriptionLabel = UILabel()
        descriptionLabel.text = character.description
        descriptionLabel.font = FontFamily.Inter28pt.regular.font(size: 17)
        descriptionLabel.textColor = UIColor(hexString: "#6B5B4F")
        descriptionLabel.numberOfLines = 2

        let bestForLabel = UILabel()
        bestForLabel.text = character.bestForLabel
        bestForLabel.font = FontFamily.Inter28pt.medium.font(size: 12)
        bestForLabel.textColor = UIColor(hexString: "#8D6A46")
        bestForLabel.backgroundColor = UIColor(hexString: "#F6EEDF")
        bestForLabel.layer.cornerRadius = 9
        bestForLabel.clipsToBounds = true
        bestForLabel.textAlignment = .center

        let chevronContainer = UIView()
        chevronContainer.backgroundColor = UIColor(hexString: "#F8EEDB")
        chevronContainer.layer.cornerRadius = 20

        let chevronImageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        chevronImageView.tintColor = UIColor(hexString: "#8F6A41")
        chevronImageView.contentMode = .scaleAspectFit

        containerView.addSubview(avatarImageView)
        containerView.addSubview(titleRow)
        containerView.addSubview(bestForLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(chevronContainer)
        chevronContainer.addSubview(chevronImageView)
        titleRow.addArrangedSubview(nameLabel)
        titleRow.addArrangedSubview(recommendedLabel)

        avatarImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(60)
        }

        titleRow.snp.makeConstraints { make in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(16)
            make.top.equalToSuperview().offset(18)
            make.trailing.lessThanOrEqualTo(chevronContainer.snp.leading).offset(-12)
        }

        recommendedLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.greaterThanOrEqualTo(92)
        }

        bestForLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleRow)
            make.top.equalTo(titleRow.snp.bottom).offset(6)
            make.height.equalTo(18)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleRow)
            make.top.equalTo(bestForLabel.snp.bottom).offset(8)
            make.trailing.lessThanOrEqualTo(chevronContainer.snp.leading).offset(-12)
            make.bottom.equalToSuperview().offset(-18)
        }

        chevronContainer.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
            make.width.height.equalTo(40)
        }

        chevronImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(characterTapped(_:)))
        containerView.addGestureRecognizer(tapGesture)
        containerView.tag = characterType.hashValue
        containerView.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(124)
        }

        return containerView
    }

    @objc private func characterTapped(_ gesture: UITapGestureRecognizer) {
        guard let view = gesture.view else { return }

        // Reset all selections
        for subview in characterStackView.arrangedSubviews {
            subview.layer.borderColor = UIColor(hexString: "#E6D2BD").cgColor
            subview.backgroundColor = UIColor(hexString: "#FCF9F5")
        }

        // Select current character
        view.layer.borderColor = UIColor(hexString: "#D8B17A").cgColor
        view.backgroundColor = UIColor(hexString: "#FFF9F1")

        // Find character type
        let characterType = CharacterType.allCases.first { $0.hashValue == view.tag }
        selectedCharacter = characterType

        guard let character = selectedCharacter else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.12) {
            self.delegate?.didSelectCharacter(character)
            if self.dismissesOnSelection {
                self.dismiss(animated: true)
            }
        }
    }

    @objc private func backButtonTapped() {
        dismiss(animated: true)
    }
}
