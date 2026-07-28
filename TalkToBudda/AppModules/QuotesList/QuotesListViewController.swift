//
//  QuotesListViewController.swift
//  TalkToBudda
//
//  Created by mac on 5/5/25.
//

import UIKit
import SnapKit

struct BuddhaQuote: Codable {
    let quote: String
    let source: String
}

class QuotesListViewController: UIViewController {
    
    private var quotes: [BuddhaQuote] = []
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let heroCardView = UIView()
    private let heroEyebrowLabel = UILabel()
    private let heroTitleLabel = UILabel()
    private let heroBodyLabel = UILabel()
    private let heroSourceLabel = UILabel()
    
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
        label.text = "Daily wisdom"
        label.font = FontFamily.PlayfairDisplay.bold.font(size: 30)
        label.textAlignment = .left
        label.textColor = .color4B3621
        return label
    }()
    
    private lazy var premiumButton: UIButton = {
        let button = UIButton()
        button.setTitle("Premium", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .color4B3621
        button.layer.cornerRadius = 8
        button.titleLabel?.font = FontFamily.PlayfairDisplay.medium.font(size: 16)
        button.addTarget(self, action: #selector(premiumButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var startChatButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start Chat", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hexString: "#E4B169")
        button.layer.cornerRadius = 12
        button.layer.shadowColor = UIColor(hexString: "#D8B17A").cgColor
        button.layer.shadowOpacity = 0.24
        button.layer.shadowOffset = CGSize(width: 0, height: 10)
        button.layer.shadowRadius = 16
        button.titleLabel?.font = FontFamily.PlayfairDisplay.bold.font(size: 18)
        button.addTarget(self, action: #selector(startChatButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadQuotes()
        updatePremiumButtonVisibility()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updatePremiumButtonVisibility()
    }
    
    private func setupUI() {
        view.backgroundColor = .colorFDF6ED
        
        // Add subviews
        view.addSubview(navView)
        view.addSubview(heroCardView)
        view.addSubview(tableView)
        view.addSubview(startChatButton)
        
        navView.addSubview(settingsButton)
        navView.addSubview(titleLabel)
        navView.addSubview(premiumButton)
        [heroEyebrowLabel, heroTitleLabel, heroBodyLabel, heroSourceLabel].forEach(heroCardView.addSubview)

        heroCardView.backgroundColor = UIColor.white.withAlphaComponent(0.58)
        heroCardView.layer.cornerRadius = 24
        heroCardView.layer.borderWidth = 1
        heroCardView.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor

        heroEyebrowLabel.text = "quote of the day"
        heroEyebrowLabel.font = FontFamily.FiraMono.medium.font(size: 11)
        heroEyebrowLabel.textColor = UIColor(hexString: "#8F715C")

        heroTitleLabel.font = FontFamily.PlayfairDisplay.bold.font(size: 21)
        heroTitleLabel.textColor = .color4B3621
        heroTitleLabel.numberOfLines = 0

        heroBodyLabel.font = FontFamily.Inter28pt.medium.font(size: 14)
        heroBodyLabel.textColor = UIColor(hexString: "#6E6257")
        heroBodyLabel.numberOfLines = 0

        heroSourceLabel.font = FontFamily.FiraMono.medium.font(size: 12)
        heroSourceLabel.textColor = UIColor(hexString: "#90745F")
        heroSourceLabel.textAlignment = .right
        
        // Setup constraints
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
        
        heroCardView.snp.makeConstraints { make in
            make.top.equalTo(navView.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(16)
        }

        heroEyebrowLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(18)
        }

        heroTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(heroEyebrowLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(18)
        }

        heroBodyLabel.snp.makeConstraints { make in
            make.top.equalTo(heroTitleLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(18)
        }

        heroSourceLabel.snp.makeConstraints { make in
            make.top.equalTo(heroBodyLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(18)
            make.bottom.equalToSuperview().inset(18)
        }

        premiumButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.width.equalTo(80)
            make.height.equalTo(32)
            make.centerY.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(heroCardView.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(startChatButton.snp.top).offset(-12)
        }
        
        startChatButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(56)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
        }
        
        // Setup table view
        tableView.register(QuoteTableViewCell.self, forCellReuseIdentifier: "QuoteCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 4, left: 0, bottom: 12, right: 0)
        tableView.sectionHeaderHeight = .leastNormalMagnitude
        tableView.sectionFooterHeight = .leastNormalMagnitude
    }
    
    private func loadQuotes() {
        guard let url = Bundle.main.url(forResource: "buddha_quotes_100", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let quotes = try? JSONDecoder().decode([BuddhaQuote].self, from: data) else {
            print("Failed to load quotes")
            return
        }
        
        self.quotes = quotes
        updateHeroQuote()
        tableView.reloadData()
    }

    private func updateHeroQuote() {
        guard !quotes.isEmpty else { return }

        let dayOfYear = Calendar.current.ordinality(of: .day, in: .year, for: Date()) ?? 1
        let quote = quotes[(dayOfYear - 1) % quotes.count]

        heroTitleLabel.text = "\"\(quote.quote)\""
        heroBodyLabel.text = "A line to return to today before you open a conversation."
        heroSourceLabel.text = "- \(quote.source)"
    }
    
    private func updatePremiumButtonVisibility() {
//        let isPremium = StoreKitManager.shared.isPremium
        premiumButton.isHidden = true
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
    
    @objc private func startChatButtonTapped() {
        let conversation = ChatDataManager.shared.createConversation(title: "", character: .buddha)
        let vc = ChatRouter.createModule(conversation: conversation)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension QuotesListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteCell", for: indexPath) as! QuoteTableViewCell
        let quote = quotes[indexPath.row]
        cell.configure(with: quote)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

// MARK: - QuoteTableViewCell
class QuoteTableViewCell: UITableViewCell {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.92)
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(hexString: "#EEE1D0").cgColor
        view.layer.shadowColor = UIColor(hexString: "#DDC8A9").cgColor
        view.layer.shadowOpacity = 0.14
        view.layer.shadowOffset = CGSize(width: 0, height: 8)
        view.layer.shadowRadius = 14
        return view
    }()
    
    private let quoteLabel: UILabel = {
        let label = UILabel()
        label.font = FontFamily.PlayfairDisplay.regular.font(size: 17)
        label.textColor = .color4B3621
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let sourceLabel: UILabel = {
        let label = UILabel()
        label.font = FontFamily.FiraMono.medium.font(size: 12)
        label.textColor = UIColor(hexString: "#90745F")
        label.textAlignment = .right
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(containerView)
        containerView.addSubview(quoteLabel)
        containerView.addSubview(sourceLabel)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
        }
        
        quoteLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(16)
        }
        
        sourceLabel.snp.makeConstraints { make in
            make.top.equalTo(quoteLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
        }
    }
    
    func configure(with quote: BuddhaQuote) {
        quoteLabel.text = "\"\(quote.quote)\""
        sourceLabel.text = "- \(quote.source)"
    }
}
