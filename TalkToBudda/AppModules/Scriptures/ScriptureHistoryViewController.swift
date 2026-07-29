//
//  ScriptureHistoryViewController.swift
//  TalkToBudda
//
//  Created by Codex on 29/7/26.
//

import UIKit
import SnapKit

final class ScriptureHistoryViewController: UIViewController {
    private let scriptures: [ScriptureEntity]
    private let onSelectScripture: (ScriptureEntity) -> Void
    private var records: [ScriptureReadingProgress] = []

    private let backButton = ThemeBackButton()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let tableView = UITableView(frame: .zero, style: .plain)

    init(scriptures: [ScriptureEntity], onSelectScripture: @escaping (ScriptureEntity) -> Void) {
        self.scriptures = scriptures
        self.onSelectScripture = onSelectScripture
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadRecords()
    }

    private func setupUI() {
        view.backgroundColor = ThemeColor.screenBackground

        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)

        titleLabel.text = "Scriptures History"
        titleLabel.applyThemeTextStyle(font: ThemeFont.display(30), color: ThemeColor.textPrimary, alignment: .center)

        subtitleLabel.text = "Return to where you left off across your recent readings."
        subtitleLabel.applyThemeTextStyle(font: ThemeFont.body(15), color: ThemeColor.textSecondary, alignment: .center, numberOfLines: 0)

        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 24, right: 0)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ScriptureHistoryCell.self, forCellReuseIdentifier: ScriptureHistoryCell.reuseIdentifier)

        [backButton, titleLabel, subtitleLabel, tableView].forEach(view.addSubview)

        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(6)
            make.left.equalToSuperview().inset(20)
            make.width.height.equalTo(44)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            make.centerX.equalToSuperview()
            make.left.greaterThanOrEqualTo(backButton.snp.right).offset(12)
            make.right.equalToSuperview().inset(20)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(28)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(18)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func loadRecords() {
        records = ScriptureReadingProgressStore.shared.allRecords()
        tableView.reloadData()
    }

    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension ScriptureHistoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        records.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ScriptureHistoryCell.reuseIdentifier, for: indexPath) as? ScriptureHistoryCell else {
            return UITableViewCell()
        }

        cell.configure(with: records[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let record = records[indexPath.row]
        guard let scripture = scriptures.first(where: { $0.name == record.scriptureName }) else { return }
        onSelectScripture(scripture)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        144
    }
}
