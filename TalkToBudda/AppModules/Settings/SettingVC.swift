//
//  SettingVC.swift
//  TalkToBudda
//
//  Created by mac on 10/5/25.
//

// MVVM Implementation of Settings Screen using Swift, SnapKit, and StackView

import UIKit
import SnapKit
import SafariServices
import MessageUI
import WebKit

// MARK: - ViewModel
class SettingsViewModel {
    let settingsOptions: [[SettingsOption]] = [[
        SettingsOption(icon: Asset.Assets.icStStore.image, title: "Store"),
        SettingsOption(icon: Asset.Assets.icStSubscription.image, title: "Manage Subscription"),
        SettingsOption(icon: Asset.Assets.icStReview.image, title: "Review App"),
        SettingsOption(icon: Asset.Assets.icStEmail.image, title: "Contact us"),
        //         SettingsOption(icon: Asset.Assets.icStFaqs.image, title: "FAQs"),
        SettingsOption(icon: Asset.Assets.icStShare.image, title: "Share our app with friend"),
        //         SettingsOption(icon: Asset.Assets.icStOthers.image, title: "Our other apps"),
        SettingsOption(icon: Asset.Assets.icStPrivacy.image, title: "Privacy policy"),
    ]]
}

struct SettingsOption {
    let icon: UIImage
    let title: String
}

// MARK: - SettingsViewController
class SettingsViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    private let viewModel = SettingsViewModel()
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private lazy var navView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let backButton = UIButton()
        backButton.setImage(Asset.Assets.icBack.image.withRenderingMode(.alwaysTemplate), for: .normal)
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.tintColor = .color4B3621
        backButton.addTarget(self, action: #selector(tappedBackButton(_:)), for: .touchUpInside)
        return backButton
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Settings"
        titleLabel.font = FontFamily.PlayfairDisplay.bold.font(size: 24)
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor(hexString: "#4B3621")
        
        titleLabel.textAlignment = .center
        
        return titleLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
    }
    
    private func setupView() {
        title = "Settings"
        view.backgroundColor = .colorFDF6ED
        view.addSubview(navView)
        view.addSubview(tableView)
        navView.addSubview(backButton)
        navView.addSubview(titleLabel)
        navView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(navView.snp.bottom)
            make.left.bottom.right.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(8)
            make.width.height.equalTo(44)
            make.centerY.equalToSuperview()
        }
    }
    
    private func setupTableView() {
        tableView.register(SettingsCell.self, forCellReuseIdentifier: "SettingsCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
    }
    
    // MARK: - Navigation Handlers
    private func showPrivacyPolicy() {
        guard let url = Bundle.main.url(forResource: "Privacy Policy.html", withExtension: nil) else { return }
        openWeb(url: url, title: "Privacy Policy")
    }
    
    private func openEmailComposer() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([Configs.URL.emailSupport])
            mail.setSubject("Support Inquiry")
            present(mail, animated: true)
        } else {
            print("Mail services are not available")
        }
    }
    
    private func shareApp() {
        let text = "Check out this amazing app: TalkToBuddha!"
        let url = URL(string: Configs.URL.share)
        let activityVC = UIActivityViewController(activityItems: [text, url!], applicationActivities: nil)
        present(activityVC, animated: true)
    }
    
    // MARK: - MFMailComposeViewControllerDelegate
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    func presentStoreVC() {
        let dsVC = PurchaseViewController(storeType: .store)
        dsVC.modalPresentationStyle = .fullScreen
        present(dsVC, animated: true)
    }
    
    @objc func tappedBackButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.settingsOptions.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.settingsOptions[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! SettingsCell
        let option = viewModel.settingsOptions[indexPath.section][indexPath.row]
        cell.configure(with: option)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Handle cell selection
        
        let option = viewModel.settingsOptions[indexPath.section][indexPath.row]
        switch option.title {
        case "Store":
            presentStoreVC()
        case "Privacy policy":
            showPrivacyPolicy()
        case "Contact us":
            openEmailComposer()
        case "Share our app with friend":
            shareApp()
        case "Review App":
            guard let url = URL(string: Configs.URL.reviewAppURL) else { return }
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:])
            }
        case "Manage Subscription":
            guard let url = URL(string: Configs.URL.manageSubsciptions) else { return }
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:])
            }
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
}

extension UIViewController {
    
    func openWeb(url: URL, title: String?) {
        let nav = UINavigationController(rootViewController: SimpleWebView(url: url, title: title))
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
}
