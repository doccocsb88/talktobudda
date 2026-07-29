//
//  GuidanceViewController.swift
//  TalkToBudda
//
//  Created by mac on 5/5/25.
//

import UIKit
import SnapKit

final class GuidanceViewController: UIViewController {

    private var quotes: [QuoteCodable] = []
    private let recommendedCharacter: CharacterType = .buddha
    private let featuredCharacters: [CharacterType] = [.buddha, .monk, .zenMaster]

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let stackView = UIStackView()

    private lazy var navView: UIView = {
        let view = UIView()
        view.backgroundColor = .colorFDF6ED
        return view
    }()

    private lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.Assets.icHomeSetting.image.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .color4B3621
        button.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Guidance"
        label.font = FontFamily.PlayfairDisplay.bold.font(size: 30)
        label.textAlignment = .left
        label.textColor = .color4B3621
        return label
    }()

    private lazy var premiumButton: ThemePillButton = {
        let button = ThemePillButton()
        button.setTitle("Premium", for: .normal)
        button.addTarget(self, action: #selector(premiumButtonTapped), for: .touchUpInside)
        return button
    }()

    private let heroCardView = MutedThemeCardView()
    private let heroEyebrowLabel = UILabel()
    private let heroTitleLabel = UILabel()
    private let heroBodyLabel = UILabel()
    private let heroAvatarView = UIImageView()
    private let heroCTAButton = PrimaryThemeButton(title: "Talk with Buddha")

    private let guideSectionView = MutedThemeCardView()
    private let guideSectionTitleLabel = UILabel()
    private let guideSectionBodyLabel = UILabel()
    private let guideCardsStackView = UIStackView()
    private let seeAllGuidesButton = UIButton(type: .system)

    private let quoteSectionView = MutedThemeCardView()
    private let quoteSectionEyebrowLabel = UILabel()
    private let quoteSectionTitleLabel = UILabel()
    private let quoteSectionBodyLabel = UILabel()
    private let quoteSectionSourceLabel = UILabel()
    private let quoteSectionButton = UIButton(type: .system)

    private let meditationSectionView = MutedThemeCardView()
    private let meditationTitleLabel = UILabel()
    private let meditationBodyLabel = UILabel()
    private let meditationButton = PrimaryThemeButton(title: "Open meditation")

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadQuotes()
        updatePremiumButtonVisibility()
        updateHero()
        buildGuideCards()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updatePremiumButtonVisibility()
    }

    private func setupUI() {
        view.backgroundColor = .colorFDF6ED

        [navView, scrollView].forEach(view.addSubview)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        navView.addSubview(settingsButton)
        navView.addSubview(titleLabel)
        navView.addSubview(premiumButton)

        navView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }

        settingsButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(8)
            make.width.height.equalTo(44)
            make.centerY.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(settingsButton.snp.right).offset(6)
            make.centerY.equalToSuperview()
        }

        premiumButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.width.equalTo(80)
            make.height.equalTo(32)
            make.centerY.equalToSuperview()
        }

        scrollView.snp.makeConstraints { make in
            make.top.equalTo(navView.snp.bottom).offset(8)
            make.left.right.bottom.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }

        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 6, left: 16, bottom: 24, right: 16))
        }

        configureHeroSection()
        configureGuideSection()
        configureQuoteSection()
        configureMeditationSection()
    }

    private func configureHeroSection() {
        styleSurface(heroCardView, cornerRadius: ThemeRadius.cardLarge)
        heroEyebrowLabel.text = "recommended starting guide"
        heroEyebrowLabel.applyThemeTextStyle(
            font: ThemeFont.eyebrowMono(),
            color: ThemeColor.textTertiary
        )

        heroTitleLabel.applyThemeTextStyle(
            font: ThemeFont.display(26),
            color: ThemeColor.textPrimary,
            numberOfLines: 0
        )

        heroBodyLabel.applyThemeTextStyle(
            font: ThemeFont.bodyMedium(),
            color: ThemeColor.textSecondary,
            numberOfLines: 0
        )

        heroAvatarView.image = Character(type: recommendedCharacter).avatarImage
        heroAvatarView.contentMode = .scaleAspectFill
        heroAvatarView.backgroundColor = ThemeColor.surfaceMuted
        heroAvatarView.layer.cornerRadius = 32
        heroAvatarView.clipsToBounds = true

        heroCTAButton.addTarget(self, action: #selector(startRecommendedChatTapped), for: .touchUpInside)

        [heroEyebrowLabel, heroTitleLabel, heroBodyLabel, heroAvatarView, heroCTAButton].forEach(heroCardView.addSubview)
        stackView.addArrangedSubview(heroCardView)

        heroCardView.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(252)
        }

        heroAvatarView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(18)
            make.right.equalToSuperview().inset(18)
            make.width.height.equalTo(64)
        }

        heroEyebrowLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(18)
            make.right.lessThanOrEqualTo(heroAvatarView.snp.left).offset(-12)
        }

        heroTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(heroEyebrowLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().inset(18)
            make.right.lessThanOrEqualTo(heroAvatarView.snp.left).offset(-12)
        }

        heroBodyLabel.snp.makeConstraints { make in
            make.top.equalTo(heroTitleLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().inset(18)
            make.right.equalToSuperview().inset(18)
        }

        heroCTAButton.snp.makeConstraints { make in
            make.top.equalTo(heroBodyLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(18)
            make.bottom.equalToSuperview().inset(18)
            make.height.equalTo(54)
        }
    }

    private func configureGuideSection() {
        styleSurface(guideSectionView, cornerRadius: 24)
        guideSectionTitleLabel.text = "Choose another voice"
        guideSectionTitleLabel.applyThemeTextStyle(font: ThemeFont.sectionTitle(), color: ThemeColor.textPrimary)

        guideSectionBodyLabel.text = "Move between guides when you need more discipline, deeper presence, or a different way to reflect."
        guideSectionBodyLabel.applyThemeTextStyle(
            font: ThemeFont.bodyMedium(14),
            color: ThemeColor.textSecondary,
            numberOfLines: 0
        )

        guideCardsStackView.axis = .vertical
        guideCardsStackView.spacing = 12

        seeAllGuidesButton.setTitle("See all guides", for: .normal)
        seeAllGuidesButton.setTitleColor(UIColor(hexString: "#8F6A41"), for: .normal)
        seeAllGuidesButton.titleLabel?.font = FontFamily.FiraMono.medium.font(size: 13)
        seeAllGuidesButton.contentHorizontalAlignment = .left
        seeAllGuidesButton.addTarget(self, action: #selector(showAllGuidesTapped), for: .touchUpInside)

        [guideSectionTitleLabel, guideSectionBodyLabel, guideCardsStackView, seeAllGuidesButton].forEach(guideSectionView.addSubview)
        stackView.addArrangedSubview(guideSectionView)

        guideSectionTitleLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(18)
        }

        guideSectionBodyLabel.snp.makeConstraints { make in
            make.top.equalTo(guideSectionTitleLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(18)
        }

        guideCardsStackView.snp.makeConstraints { make in
            make.top.equalTo(guideSectionBodyLabel.snp.bottom).offset(14)
            make.left.right.equalToSuperview().inset(18)
        }

        seeAllGuidesButton.snp.makeConstraints { make in
            make.top.equalTo(guideCardsStackView.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(18)
            make.bottom.equalToSuperview().inset(18)
        }
    }

    private func configureQuoteSection() {
        styleSurface(quoteSectionView, cornerRadius: 24)
        quoteSectionEyebrowLabel.text = "daily reflection"
        quoteSectionEyebrowLabel.applyThemeTextStyle(font: ThemeFont.eyebrowMono(), color: ThemeColor.textTertiary)

        quoteSectionTitleLabel.applyThemeTextStyle(
            font: ThemeFont.sectionTitle(21),
            color: ThemeColor.textPrimary,
            numberOfLines: 0
        )

        quoteSectionBodyLabel.text = "A line to sit with before you begin a conversation."
        quoteSectionBodyLabel.applyThemeTextStyle(
            font: ThemeFont.bodyMedium(14),
            color: ThemeColor.textSecondary,
            numberOfLines: 0
        )

        quoteSectionSourceLabel.applyThemeTextStyle(
            font: ThemeFont.eyebrowMono(12),
            color: ThemeColor.textTertiary,
            alignment: .right
        )

        quoteSectionButton.setTitle("See all quotes", for: .normal)
        quoteSectionButton.setTitleColor(UIColor(hexString: "#8F6A41"), for: .normal)
        quoteSectionButton.titleLabel?.font = FontFamily.FiraMono.medium.font(size: 13)
        quoteSectionButton.contentHorizontalAlignment = .left
        quoteSectionButton.addTarget(self, action: #selector(showQuotesListTapped), for: .touchUpInside)

        [quoteSectionEyebrowLabel, quoteSectionTitleLabel, quoteSectionBodyLabel, quoteSectionSourceLabel, quoteSectionButton].forEach(quoteSectionView.addSubview)
        stackView.addArrangedSubview(quoteSectionView)

        quoteSectionEyebrowLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(18)
        }

        quoteSectionTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(quoteSectionEyebrowLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(18)
        }

        quoteSectionBodyLabel.snp.makeConstraints { make in
            make.top.equalTo(quoteSectionTitleLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(18)
        }

        quoteSectionSourceLabel.snp.makeConstraints { make in
            make.top.equalTo(quoteSectionBodyLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(18)
        }

        quoteSectionButton.snp.makeConstraints { make in
            make.top.equalTo(quoteSectionSourceLabel.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(18)
            make.bottom.equalToSuperview().inset(18)
        }
    }

    private func configureMeditationSection() {
        styleSurface(meditationSectionView, cornerRadius: 24)
        meditationTitleLabel.text = "Need a quieter practice?"
        meditationTitleLabel.applyThemeTextStyle(font: ThemeFont.sectionTitle(), color: ThemeColor.textPrimary)

        meditationBodyLabel.text = "Open a guided meditation when words feel too busy and you want to return to breath and stillness."
        meditationBodyLabel.applyThemeTextStyle(
            font: ThemeFont.bodyMedium(14),
            color: ThemeColor.textSecondary,
            numberOfLines: 0
        )
        meditationButton.addTarget(self, action: #selector(openMeditationTapped), for: .touchUpInside)

        [meditationTitleLabel, meditationBodyLabel, meditationButton].forEach(meditationSectionView.addSubview)
        stackView.addArrangedSubview(meditationSectionView)

        meditationTitleLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(18)
        }

        meditationBodyLabel.snp.makeConstraints { make in
            make.top.equalTo(meditationTitleLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(18)
        }

        meditationButton.snp.makeConstraints { make in
            make.top.equalTo(meditationBodyLabel.snp.bottom).offset(14)
            make.left.right.equalToSuperview().inset(18)
            make.bottom.equalToSuperview().inset(18)
            make.height.equalTo(52)
        }
    }

    private func buildGuideCards() {
        guideCardsStackView.arrangedSubviews.forEach {
            guideCardsStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }

        for characterType in featuredCharacters {
            if characterType == recommendedCharacter { continue }
            guideCardsStackView.addArrangedSubview(makeGuideCard(for: characterType))
        }
    }

    private func makeGuideCard(for characterType: CharacterType) -> UIView {
        let character = Character(type: characterType)
        let cardView = WarmCardView()
        cardView.layer.cornerRadius = 20

        let avatarView = UIImageView(image: character.avatarImage)
        avatarView.contentMode = .scaleAspectFill
        avatarView.backgroundColor = ThemeColor.surfaceBadge
        avatarView.layer.cornerRadius = 24
        avatarView.clipsToBounds = true

        let nameLabel = UILabel()
        nameLabel.text = character.name
        nameLabel.applyThemeTextStyle(font: ThemeFont.cta(), color: ThemeColor.textPrimary)

        let tagLabel = ThemeChipLabel()
        tagLabel.text = character.bestForLabel

        let descriptionLabel = UILabel()
        descriptionLabel.text = character.handoffSummary
        descriptionLabel.applyThemeTextStyle(
            font: ThemeFont.body(13),
            color: ThemeColor.textSecondary,
            numberOfLines: 2
        )

        let chevronView = UIImageView(image: UIImage(systemName: "chevron.right"))
        chevronView.tintColor = ThemeColor.textTertiary

        [avatarView, nameLabel, tagLabel, descriptionLabel, chevronView].forEach(cardView.addSubview)

        avatarView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(14)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(48)
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(14)
            make.left.equalTo(avatarView.snp.right).offset(12)
            make.right.lessThanOrEqualTo(chevronView.snp.left).offset(-10)
        }

        tagLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(6)
            make.left.equalTo(nameLabel)
            make.height.equalTo(18)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(tagLabel.snp.bottom).offset(6)
            make.left.equalTo(nameLabel)
            make.right.equalToSuperview().inset(42)
            make.bottom.equalToSuperview().inset(14)
        }

        chevronView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(14)
        }

        cardView.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(108)
        }

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(featuredGuideTapped(_:)))
        cardView.addGestureRecognizer(tapGesture)
        cardView.tag = characterType.hashValue
        return cardView
    }

    private func styleSurface(_ view: UIView, cornerRadius: CGFloat) {
        view.layer.cornerRadius = cornerRadius
    }

    private func loadQuotes() {
        quotes = QuoteLibrary.loadQuotes()
        updateDailyQuote()
    }

    private func updateHero() {
        let character = Character(type: recommendedCharacter)
        heroAvatarView.image = character.avatarImage
        heroTitleLabel.text = "Begin with \(character.name)"
        heroBodyLabel.text = "\(character.handoffSummary) Start here if you want the gentlest way into the app."
    }

    private func updateDailyQuote() {
        guard !quotes.isEmpty else { return }
        let dayOfYear = Calendar.current.ordinality(of: .day, in: .year, for: Date()) ?? 1
        let quote = quotes[(dayOfYear - 1) % quotes.count]
        quoteSectionTitleLabel.text = "\"\(quote.quote)\""
        quoteSectionSourceLabel.text = "- \(quote.source)"
    }

    private func updatePremiumButtonVisibility() {
        premiumButton.isHidden = true
    }

    private func startChat(with characterType: CharacterType) {
        let conversation = ChatDataManager.shared.createConversation(title: "", character: characterType)
        let vc = ChatRouter.createModule(conversation: conversation)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }

    @objc private func settingsButtonTapped() {
        let settingsVC = SettingsViewController()
        let navController = UINavigationController(rootViewController: settingsVC)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }

    @objc private func premiumButtonTapped() {
        DSRouter.showDS(from: self)
    }

    @objc private func startRecommendedChatTapped() {
        startChat(with: recommendedCharacter)
    }

    @objc private func showAllGuidesTapped() {
        let characterSelectionVC = CharacterSelectionViewController()
        characterSelectionVC.delegate = self
        characterSelectionVC.dismissesOnSelection = false
        characterSelectionVC.modalPresentationStyle = .fullScreen
        present(characterSelectionVC, animated: true)
    }

    @objc private func featuredGuideTapped(_ gesture: UITapGestureRecognizer) {
        guard let view = gesture.view else { return }
        guard let character = CharacterType.allCases.first(where: { $0.hashValue == view.tag }) else { return }
        startChat(with: character)
    }

    @objc private func openMeditationTapped() {
        tabBarController?.selectedIndex = 1
    }

    @objc private func showQuotesListTapped() {
        let vc = QuotesListViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension GuidanceViewController: CharacterSelectionDelegate {
    func didSelectCharacter(_ character: CharacterType) {
        presentedViewController?.dismiss(animated: false) { [weak self] in
            self?.startChat(with: character)
        }
    }
}
