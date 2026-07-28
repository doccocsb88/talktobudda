//
//  WisdomQuestionLauncherViewController.swift
//  TalkToBudda
//

import UIKit
import SnapKit

protocol WisdomQuestionLauncherDelegate: AnyObject {
    func wisdomQuestionLauncher(_ launcher: WisdomQuestionLauncherViewController, didCreate conversation: ConversationCodable)
}

final class WisdomQuestionLauncherViewController: UIViewController {
    weak var delegate: WisdomQuestionLauncherDelegate?

    private enum State {
        case situations
        case recommendations(WisdomSituation, [WisdomLensRecommendation])
    }

    private let matcher = WisdomLensMatcher()
    private var selectedSituation: WisdomSituation?
    private var selectedRecommendation: WisdomLensRecommendation?
    private var state: State = .situations

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let headerLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let stackView = UIStackView()
    private let primaryButton = UIButton(type: .system)
    private let manualButton = UIButton(type: .system)
    private let backButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        renderSituations()
    }

    private func setupUI() {
        view.backgroundColor = .colorFDF6ED

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [backButton, headerLabel, subtitleLabel, stackView, manualButton, primaryButton].forEach {
            contentView.addSubview($0)
        }

        backButton.setTitle("Close", for: .normal)
        backButton.setTitleColor(.color7D5A4F, for: .normal)
        backButton.titleLabel?.font = FontFamily.FiraMono.medium.font(size: 14)
        backButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)

        headerLabel.font = FontFamily.PlayfairDisplay.bold.font(size: 30)
        headerLabel.textColor = .color4B3621
        headerLabel.numberOfLines = 0
        headerLabel.textAlignment = .center

        subtitleLabel.font = FontFamily.FiraMono.regular.font(size: 15)
        subtitleLabel.textColor = .color7D5A4F
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textAlignment = .center

        stackView.axis = .vertical
        stackView.spacing = 12

        manualButton.setTitle("Choose guide manually", for: .normal)
        manualButton.setTitleColor(.color7D5A4F, for: .normal)
        manualButton.titleLabel?.font = FontFamily.FiraMono.medium.font(size: 14)
        manualButton.addTarget(self, action: #selector(manualGuideTapped), for: .touchUpInside)

        primaryButton.setTitleColor(.white, for: .normal)
        primaryButton.titleLabel?.font = FontFamily.FiraMono.bold.font(size: 17)
        primaryButton.backgroundColor = .color7D5A4F
        primaryButton.layer.cornerRadius = 12
        primaryButton.addTarget(self, action: #selector(primaryTapped), for: .touchUpInside)

        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }

        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(36)
        }

        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(24)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(28)
        }

        stackView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(28)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        manualButton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(18)
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
        }

        primaryButton.snp.makeConstraints { make in
            make.top.equalTo(manualButton.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(32)
            make.height.equalTo(52)
            make.bottom.equalToSuperview().offset(-28)
        }
    }

    private func renderSituations() {
        state = .situations
        selectedSituation = nil
        selectedRecommendation = nil
        headerLabel.text = "What kind of moment are you in?"
        subtitleLabel.text = "Choose one. We'll suggest a few wisdom lenses."
        backButton.setTitle("Close", for: .normal)
        primaryButton.setTitle("Show wisdom lenses", for: .normal)
        updatePrimaryButton(enabled: false)
        clearStack()

        WisdomSituation.predefined.forEach { situation in
            let card = WisdomSelectionCardView()
            card.configure(title: situation.title, subtitle: situation.subtitle, isSelected: false)
            card.onTap = { [weak self, weak card] in
                self?.selectedSituation = situation
                self?.stackView.arrangedSubviews.compactMap { $0 as? WisdomSelectionCardView }.forEach {
                    $0.setSelectedState(false)
                }
                card?.setSelectedState(true)
                self?.updatePrimaryButton(enabled: true)
            }
            stackView.addArrangedSubview(card)
        }
    }

    private func renderRecommendations(for situation: WisdomSituation) {
        let recommendations = matcher.recommendations(for: situation)
        state = .recommendations(situation, recommendations)
        selectedRecommendation = nil
        headerLabel.text = "Three ways to look at this"
        subtitleLabel.text = situation.title
        backButton.setTitle("Back", for: .normal)
        primaryButton.setTitle("Start reflection", for: .normal)
        updatePrimaryButton(enabled: false)
        clearStack()

        recommendations.forEach { recommendation in
            let character = Character(type: recommendation.character)
            let card = WisdomSelectionCardView()
            card.configure(
                title: character.name,
                subtitle: recommendation.reason,
                image: character.avatarImage,
                isSelected: false
            )
            card.onTap = { [weak self, weak card] in
                self?.selectedRecommendation = recommendation
                self?.stackView.arrangedSubviews.compactMap { $0 as? WisdomSelectionCardView }.forEach {
                    $0.setSelectedState(false)
                }
                card?.setSelectedState(true)
                self?.updatePrimaryButton(enabled: true)
            }
            stackView.addArrangedSubview(card)
        }
    }

    private func updatePrimaryButton(enabled: Bool) {
        primaryButton.isEnabled = enabled
        primaryButton.alpha = enabled ? 1 : 0.45
    }

    private func clearStack() {
        stackView.arrangedSubviews.forEach {
            stackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }

    private func createConversation(character: CharacterType, wisdomContext: WisdomContext?) {
        let title = wisdomContext?.situationTitle ?? ""
        let conversation = ChatDataManager.shared.createConversation(
            title: title,
            character: character,
            wisdomContext: wisdomContext
        )
        delegate?.wisdomQuestionLauncher(self, didCreate: conversation)
    }

    @objc private func primaryTapped() {
        switch state {
        case .situations:
            guard let selectedSituation else { return }
            renderRecommendations(for: selectedSituation)
        case .recommendations(let situation, _):
            guard let selectedRecommendation else { return }
            let context = WisdomContext(
                situationId: situation.id,
                situationTitle: situation.title,
                matchReason: selectedRecommendation.reason
            )
            createConversation(character: selectedRecommendation.character, wisdomContext: context)
        }
    }

    @objc private func manualGuideTapped() {
        let characterSelectionVC = CharacterSelectionViewController()
        characterSelectionVC.delegate = self
        characterSelectionVC.dismissesOnSelection = false
        characterSelectionVC.modalPresentationStyle = .fullScreen
        present(characterSelectionVC, animated: true)
    }

    @objc private func closeTapped() {
        switch state {
        case .situations:
            dismiss(animated: true)
        case .recommendations:
            renderSituations()
        }
    }
}

extension WisdomQuestionLauncherViewController: CharacterSelectionDelegate {
    func didSelectCharacter(_ character: CharacterType) {
        dismiss(animated: false) { [weak self] in
            self?.createConversation(character: character, wisdomContext: nil)
        }
    }
}

private final class WisdomSelectionCardView: UIControl {
    var onTap: (() -> Void)?

    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let checkLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(title: String, subtitle: String, image: UIImage? = nil, isSelected: Bool) {
        titleLabel.text = title
        subtitleLabel.text = subtitle

        if let image {
            iconImageView.image = image
            iconImageView.isHidden = false
        } else {
            iconImageView.isHidden = true
        }

        setSelectedState(isSelected)
    }

    func setSelectedState(_ selected: Bool) {
        layer.borderColor = selected ? UIColor.color7D5A4F.cgColor : UIColor(hexString: "#E0D5C7").cgColor
        backgroundColor = selected ? UIColor(hexString: "#F5F0E8") : .white
        checkLabel.isHidden = !selected
    }

    private func setupUI() {
        layer.cornerRadius = 16
        layer.borderWidth = 2
        backgroundColor = .white
        addTarget(self, action: #selector(tapped), for: .touchUpInside)

        iconImageView.contentMode = .scaleAspectFit
        iconImageView.clipsToBounds = true
        iconImageView.layer.cornerRadius = 24

        titleLabel.font = FontFamily.PlayfairDisplay.bold.font(size: 18)
        titleLabel.textColor = .color4B3621
        titleLabel.numberOfLines = 0

        subtitleLabel.font = FontFamily.FiraMono.regular.font(size: 13)
        subtitleLabel.textColor = .color7D5A4F
        subtitleLabel.numberOfLines = 0

        checkLabel.text = "Selected"
        checkLabel.font = FontFamily.FiraMono.bold.font(size: 11)
        checkLabel.textColor = .color7D5A4F
        checkLabel.textAlignment = .center

        [iconImageView, titleLabel, subtitleLabel, checkLabel].forEach { addSubview($0) }

        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(48)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.equalToSuperview().inset(18)
            make.trailing.equalTo(checkLabel.snp.leading).offset(-8)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.leading.equalTo(titleLabel)
            make.trailing.equalTo(checkLabel.snp.leading).offset(-8)
            make.bottom.equalToSuperview().inset(16)
        }

        checkLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(14)
            make.centerY.equalToSuperview()
            make.width.equalTo(58)
            make.height.equalTo(28)
        }

        snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(86)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let hasIcon = !iconImageView.isHidden
        let leadingInset = hasIcon ? 78 : 18
        titleLabel.snp.updateConstraints { make in
            make.leading.equalToSuperview().inset(leadingInset)
        }
    }

    @objc private func tapped() {
        onTap?()
    }
}
