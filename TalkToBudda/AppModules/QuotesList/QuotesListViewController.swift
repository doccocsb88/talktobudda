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
        label.text = "Buddha Quotes"
        label.font = FontFamily.PlayfairDisplay.bold.font(size: 24)
        label.textAlignment = .center
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
        view.addSubview(tableView)
        view.addSubview(startChatButton)
        
        navView.addSubview(settingsButton)
        navView.addSubview(titleLabel)
        navView.addSubview(premiumButton)
        
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
            make.center.equalToSuperview()
        }
        
        premiumButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.width.equalTo(80)
            make.height.equalTo(32)
            make.centerY.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(navView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(startChatButton.snp.top).offset(-16)
        }
        
        startChatButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
        
        // Setup table view
        tableView.register(QuoteTableViewCell.self, forCellReuseIdentifier: "QuoteCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
    }
    
    private func loadQuotes() {
        guard let url = Bundle.main.url(forResource: "buddha_quotes_100", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let quotes = try? JSONDecoder().decode([BuddhaQuote].self, from: data) else {
            print("Failed to load quotes")
            return
        }
        
        self.quotes = quotes
        tableView.reloadData()
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
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        return view
    }()
    
    private let quoteLabel: UILabel = {
        let label = UILabel()
        label.font = FontFamily.PlayfairDisplay.regular.font(size: 16)
        label.textColor = .color4B3621
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let sourceLabel: UILabel = {
        let label = UILabel()
        label.font = FontFamily.PlayfairDisplay.italic.font(size: 14)
        label.textColor = .systemGray
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
