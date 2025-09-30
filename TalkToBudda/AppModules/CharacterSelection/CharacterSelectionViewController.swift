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
    private var selectedCharacter: CharacterType?
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let characterStackView = UIStackView()
    private let continueButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCharacters()
    }
    
    private func setupUI() {
        view.backgroundColor = .colorFDF6ED
        
        // Setup scroll view
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        // Setup content
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(characterStackView)
        contentView.addSubview(continueButton)
        
        // Configure title
        titleLabel.text = "Choose Your Guide"
        titleLabel.font = FontFamily.PlayfairDisplay.bold.font(size: 28)
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor(hexString: "#4B3621")
        
        // Configure subtitle
        subtitleLabel.text = "Select a spiritual guide to accompany you on your journey"
        subtitleLabel.font = FontFamily.FiraMono.regular.font(size: 16)
        subtitleLabel.textAlignment = .center
        subtitleLabel.textColor = UIColor(hexString: "#6B5B4F")
        subtitleLabel.numberOfLines = 0
        
        // Configure stack view
        characterStackView.axis = .vertical
        characterStackView.spacing = 16
        characterStackView.distribution = .fillEqually
        
        // Configure continue button
        continueButton.setTitle("Continue", for: .normal)
        continueButton.backgroundColor = UIColor(hexString: "#8B4513")
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.titleLabel?.font = FontFamily.FiraMono.bold.font(size: 18)
        continueButton.layer.cornerRadius = 25
        continueButton.isEnabled = false
        continueButton.alpha = 0.5
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        characterStackView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        continueButton.snp.makeConstraints { make in
            make.top.equalTo(characterStackView.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-20)
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
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 12
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor(hexString: "#E0D5C7").cgColor
        
        let character = Character(type: characterType)
        
        let avatarImageView = UIImageView()
        avatarImageView.image = UIImage(named: character.avatarImageName) ?? Asset.Assets.buddaConversation.image
        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.layer.cornerRadius = 30
        avatarImageView.clipsToBounds = true
        
        let nameLabel = UILabel()
        nameLabel.text = character.name
        nameLabel.font = FontFamily.PlayfairDisplay.bold.font(size: 18)
        nameLabel.textColor = UIColor(hexString: "#4B3621")
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = character.description
        descriptionLabel.font = FontFamily.FiraMono.regular.font(size: 14)
        descriptionLabel.textColor = UIColor(hexString: "#6B5B4F")
        descriptionLabel.numberOfLines = 0
        
        containerView.addSubview(avatarImageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(descriptionLabel)
        
        avatarImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(60)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(16)
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        // Add tap gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(characterTapped(_:)))
        containerView.addGestureRecognizer(tapGesture)
        containerView.tag = characterType.hashValue
        
        return containerView
    }
    
    @objc private func characterTapped(_ gesture: UITapGestureRecognizer) {
        guard let view = gesture.view else { return }
        
        // Reset all selections
        for subview in characterStackView.arrangedSubviews {
            subview.layer.borderColor = UIColor(hexString: "#E0D5C7").cgColor
            subview.backgroundColor = .white
        }
        
        // Select current character
        view.layer.borderColor = UIColor(hexString: "#8B4513").cgColor
        view.backgroundColor = UIColor(hexString: "#F5F0E8")
        
        // Find character type
        let characterType = CharacterType.allCases.first { $0.hashValue == view.tag }
        selectedCharacter = characterType
        
        // Enable continue button
        continueButton.isEnabled = true
        continueButton.alpha = 1.0
    }
    
    @objc private func continueButtonTapped() {
        guard let character = selectedCharacter else { return }
        delegate?.didSelectCharacter(character)
        dismiss(animated: true)
    }
}
