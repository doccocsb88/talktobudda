//
//  QuotesListViewController.swift
//  TalkToBudda
//
//  Created by Codex on 29/7/26.
//

import UIKit
import SnapKit

final class QuotesListViewController: UIViewController {
    private var quotes: [QuoteCodable] = []

    private let tableView = UITableView(frame: .zero, style: .plain)

    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(Asset.Assets.icBack.image.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .color4B3621
        button.backgroundColor = UIColor(hexString: "#F7EFE5")
        button.layer.cornerRadius = 22
        button.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        return button
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Daily Reflections"
        label.font = FontFamily.PlayfairDisplay.bold.font(size: 30)
        label.textColor = .color4B3621
        label.textAlignment = .center
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "A quiet list of quotes to revisit whenever you need a steadier thought."
        label.font = FontFamily.Inter28pt.regular.font(size: 16)
        label.textColor = UIColor(hexString: "#8A7866")
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        quotes = QuoteLibrary.loadQuotes()
        tableView.reloadData()
    }

    private func setupUI() {
        view.backgroundColor = .colorFDF6ED

        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 24, right: 0)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(QuoteTableViewCell.self, forCellReuseIdentifier: QuoteTableViewCell.reuseIdentifier)

        [backButton, titleLabel, subtitleLabel, tableView].forEach(view.addSubview)

        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(6)
            make.left.equalToSuperview().inset(24)
            make.width.height.equalTo(44)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.centerX.equalToSuperview()
            make.left.greaterThanOrEqualTo(backButton.snp.right).offset(12)
            make.right.equalToSuperview().inset(24)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(14)
            make.left.right.equalToSuperview().inset(28)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(18)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension QuotesListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        quotes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: QuoteTableViewCell.reuseIdentifier, for: indexPath) as? QuoteTableViewCell else {
            return UITableViewCell()
        }

        cell.configure(with: quotes[indexPath.row], index: indexPath.row)
        return cell
    }
}

private final class QuoteTableViewCell: UITableViewCell {
    static let reuseIdentifier = "QuoteTableViewCell"

    private let cardView = WarmCardView()
    private let indexLabel = UILabel()
    private let quoteLabel = UILabel()
    private let sourceLabel = UILabel()

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
        contentView.backgroundColor = .clear

        cardView.layer.cornerRadius = 22
        contentView.addSubview(cardView)
        [indexLabel, quoteLabel, sourceLabel].forEach(cardView.addSubview)

        indexLabel.applyThemeTextStyle(font: ThemeFont.eyebrowMono(), color: ThemeColor.textTertiary)
        quoteLabel.applyThemeTextStyle(font: ThemeFont.sectionTitle(20), color: ThemeColor.textPrimary, numberOfLines: 0)
        sourceLabel.applyThemeTextStyle(font: ThemeFont.bodyMedium(14), color: ThemeColor.textSecondary, numberOfLines: 0)

        cardView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 16, bottom: 14, right: 16))
        }

        indexLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(18)
        }

        quoteLabel.snp.makeConstraints { make in
            make.top.equalTo(indexLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(18)
        }

        sourceLabel.snp.makeConstraints { make in
            make.top.equalTo(quoteLabel.snp.bottom).offset(12)
            make.left.right.bottom.equalToSuperview().inset(18)
        }
    }

    func configure(with quote: QuoteCodable, index: Int) {
        indexLabel.text = String(format: "reflection %02d", index + 1)
        quoteLabel.text = "\"\(quote.quote)\""
        sourceLabel.text = quote.source
    }
}
