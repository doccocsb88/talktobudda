//
//  ScriptureCollectionDetailViewController.swift
//  TalkToBudda
//
//  Created by Codex on 29/7/26.
//

import UIKit
import SnapKit

final class ScriptureCollectionDetailViewController: UIViewController {
    private let collection: ScriptureCollectionEntity
    private let scriptures: [ScriptureEntity]
    private let onSelectScripture: (ScriptureEntity) -> Void

    private let backButton = ThemeBackButton()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let tableView = UITableView(frame: .zero, style: .plain)

    init(collection: ScriptureCollectionEntity, scriptures: [ScriptureEntity], onSelectScripture: @escaping (ScriptureEntity) -> Void) {
        self.collection = collection
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
    }

    private func setupUI() {
        view.backgroundColor = ThemeColor.screenBackground

        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)

        titleLabel.text = collection.title
        titleLabel.applyThemeTextStyle(font: ThemeFont.display(30), color: ThemeColor.textPrimary, alignment: .center, numberOfLines: 0)

        subtitleLabel.text = collection.subtitle
        subtitleLabel.applyThemeTextStyle(font: ThemeFont.body(15), color: ThemeColor.textSecondary, alignment: .center, numberOfLines: 0)

        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ScriptureCell.self, forCellReuseIdentifier: "ScriptureCell")

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

    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension ScriptureCollectionDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        scriptures.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ScriptureCell", for: indexPath) as? ScriptureCell else {
            return UITableViewCell()
        }

        cell.configure(with: scriptures[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        onSelectScripture(scriptures[indexPath.row])
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        132
    }
}
