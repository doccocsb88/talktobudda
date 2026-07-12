//
//  PaywallV2ViewController.swift
//  TalkToBudda
//
//  Created by Codex on 11/7/26.
//

import UIKit
import SnapKit
import StoreKit
import SVProgressHUD

final class PaywallV2ViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let backgroundImageView = UIImageView(image: UIImage(named: "paywall-v2-forest-bg"))
    private let overlayView = UIView()
    private let closeButton = UIButton(type: .system)
    private let brandStackView = UIStackView()
    private let brandIconView = UIImageView(image: Asset.Assets.icLotus.image.withRenderingMode(.alwaysTemplate))
    private let brandLabel = UILabel()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let planCardView = UIView()
    private let itemStackView = UIStackView()
    private let bonusView = PaywallV2BonusView()
    private let continueButton = UIButton(type: .system)
    private let policyActionView = StoreOnePolicyActionView(style: .forest)
    private let noteCardView = UIView()
    private let termPrivacyLabelView = UILabel()

    private let viewModel = PurchaseViewModel()
    private var loadingTimer: Timer?
    private var isLoadingProducts = false

    private let storeType: StoreType
    private let benefitsView = PaywallV2BenefitsView(items: [
        ("paywall-v2-benefit-sparkles", "Unlimited\nAI guidance"),
        ("paywall-v2-benefit-lotus", "All meditations\nand practices"),
        ("paywall-v2-benefit-clock", "Saved personal\npath history")
    ])

    init(storeType: StoreType = .direct) {
        self.storeType = storeType
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        loadingTimer?.invalidate()
        SVProgressHUD.dismiss()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        setupScrollView()
        setupUI()
        bindActions()
        bindViewModel()
        loadProducts()
    }

    private func setupAppearance() {
        view.backgroundColor = UIColor(hexString: "#F6F3EA")
    }

    private func setupScrollView() {
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = true

        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        [backgroundImageView, overlayView, contentView].forEach(scrollView.addSubview)

        backgroundImageView.contentMode = .scaleToFill
        backgroundImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(780)
            make.width.equalTo(scrollView.snp.width)
        }

        overlayView.isHidden = true
        overlayView.backgroundColor = UIColor(hexString: "#F6F3EA").withAlphaComponent(0.16)
        overlayView.snp.makeConstraints { make in
            make.edges.equalTo(backgroundImageView)
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView.snp.width)
            make.height.greaterThanOrEqualTo(view.snp.height).priority(250)
        }
    }

    private func setupUI() {
        [closeButton, brandStackView, titleLabel, subtitleLabel, benefitsView, planCardView, bonusView, continueButton, policyActionView, noteCardView].forEach(contentView.addSubview)
        [brandIconView, brandLabel].forEach(brandStackView.addArrangedSubview)
        noteCardView.addSubview(termPrivacyLabelView)

        closeButton.setImage(Asset.Assets.icClose.image.withRenderingMode(.alwaysTemplate), for: .normal)
        closeButton.tintColor = UIColor(hexString: "#EEF3E7")
        closeButton.backgroundColor = UIColor(hexString: "#1F3B2D").withAlphaComponent(0.74)
        closeButton.layer.cornerRadius = 27
        closeButton.contentEdgeInsets = UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)

        brandStackView.axis = .horizontal
        brandStackView.alignment = .center
        brandStackView.spacing = 10

        brandIconView.tintColor = UIColor(hexString: "#1F5038")
        brandIconView.contentMode = .scaleAspectFit
        brandIconView.snp.makeConstraints { make in
            make.width.height.equalTo(28)
        }

        brandLabel.text = "FOREST CANOPY"
        brandLabel.font = FontFamily.PlayfairDisplay.regular.font(size: 17)
        brandLabel.textColor = UIColor(hexString: "#234B36")

        titleLabel.text = "A quieter path,\nfully open."
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        titleLabel.font = FontFamily.PlayfairDisplay.bold.font(size: 35)
        titleLabel.textColor = UIColor(hexString: "#234B36")

        subtitleLabel.text = "Unlock guided meditations, keep your history, and stay close to your daily practice."
        subtitleLabel.numberOfLines = 3
        subtitleLabel.textAlignment = .center
        subtitleLabel.font = FontFamily.Inter28pt.regular.font(size: 14)
        subtitleLabel.textColor = UIColor(hexString: "#425047")

        planCardView.backgroundColor = UIColor.white.withAlphaComponent(0.82)
        planCardView.layer.cornerRadius = 30
        planCardView.layer.borderWidth = 1
        planCardView.layer.borderColor = UIColor(hexString: "#E0DDD1").cgColor
        planCardView.layer.shadowColor = UIColor(hexString: "#D7D0C1").cgColor
        planCardView.layer.shadowOpacity = 0.25
        planCardView.layer.shadowOffset = CGSize(width: 0, height: 8)
        planCardView.layer.shadowRadius = 16

        itemStackView.axis = .horizontal
        itemStackView.distribution = .fillEqually
        itemStackView.spacing = 8
        planCardView.addSubview(itemStackView)

        bonusView.onPriceTapped = { [weak self] in
            self?.bonusChatsTapped()
        }

        continueButton.backgroundColor = UIColor(hexString: "#1F5038")
        continueButton.setTitle("Continue", for: .normal)
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.titleLabel?.font = FontFamily.PlayfairDisplay.bold.font(size: 19)
        continueButton.layer.cornerRadius = 26

        policyActionView.backgroundColor = .clear
        policyActionView.onPrivacyTapped = { [weak self] in
            guard let self, let url = Bundle.main.url(forResource: "privacy-policy.html", withExtension: nil) else { return }
            self.openWeb(url: url, title: "Privacy Policy")
        }
        policyActionView.onTermsTapped = { [weak self] in
            guard let self, let url = Bundle.main.url(forResource: "terms-of-use.html", withExtension: nil) else { return }
            self.openWeb(url: url, title: "Term of Use")
        }
        policyActionView.onRestoreTapped = { [weak self] in
            self?.restorePurchase()
        }

        noteCardView.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        noteCardView.layer.cornerRadius = 22
        noteCardView.layer.borderWidth = 1
        noteCardView.layer.borderColor = UIColor(hexString: "#E6E1D5").cgColor

        termPrivacyLabelView.numberOfLines = 0
        termPrivacyLabelView.textAlignment = .left
        termPrivacyLabelView.font = FontFamily.PlayfairDisplay.regular.font(size: 12)
        termPrivacyLabelView.textColor = UIColor(hexString: "#485147")
        termPrivacyLabelView.text = Texts.storePolicy1.rawValue + "\n" + Texts.storePolicy2.rawValue

        closeButton.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(-4)
            make.left.equalToSuperview().inset(16)
            make.width.height.equalTo(54)
        }

        brandStackView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(-4)
            make.centerX.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(brandStackView.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(48)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(14)
            make.left.right.equalToSuperview().inset(44)
        }

        benefitsView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(28)
            make.height.equalTo(92)
        }

        planCardView.snp.makeConstraints { make in
            make.top.equalTo(benefitsView.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(22)
            make.height.equalTo(180)
        }

        itemStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 14, left: 12, bottom: 12, right: 12))
        }

        bonusView.snp.makeConstraints { make in
            make.top.equalTo(planCardView.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(62)
        }

        continueButton.snp.makeConstraints { make in
            make.top.equalTo(bonusView.snp.bottom).offset(18)
            make.left.right.equalToSuperview().inset(36)
            make.height.equalTo(52)
        }

        policyActionView.snp.makeConstraints { make in
            make.top.equalTo(continueButton.snp.bottom).offset(22)
            make.left.right.equalToSuperview().inset(36)
            make.height.equalTo(42)
        }

        noteCardView.snp.makeConstraints { make in
            make.top.equalTo(policyActionView.snp.bottom).offset(18)
            make.left.right.equalToSuperview().inset(28)
            make.bottom.equalToSuperview().inset(30)
        }

        termPrivacyLabelView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 18, left: 18, bottom: 18, right: 18))
        }
    }

    private func bindActions() {
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        continueButton.addTarget(self, action: #selector(purchaseTapped), for: .touchUpInside)
    }

    private func bindViewModel() {
        viewModel.onItemPurchased = { [weak self] _ in
            guard let self else { return }
            if self.storeType == .direct {
                self.dismiss(animated: true)
            }
        }

        viewModel.onRestoreStarted = { [weak self] in
            self?.showRestoreLoading()
        }

        viewModel.onRestoreSuccess = { [weak self] in
            self?.hideRestoreLoading()
            self?.showRestoreSuccessAlert()
        }

        viewModel.onRestoreNoPurchases = { [weak self] in
            self?.hideRestoreLoading()
            self?.showRestoreNoPurchasesAlert()
        }

        viewModel.onRestoreError = { [weak self] error in
            self?.hideRestoreLoading()
            self?.showRestoreErrorAlert(error)
        }
    }

    private func loadProducts() {
        isLoadingProducts = true
        SVProgressHUD.show(withStatus: "Loading products...")

        loadingTimer = Timer.scheduledTimer(withTimeInterval: 15.0, repeats: false) { [weak self] _ in
            self?.handleLoadingTimeout()
        }

        Task {
            do {
                try await viewModel.load()
                await MainActor.run {
                    self.handleProductsLoaded()
                }
            } catch {
                await MainActor.run {
                    self.handleLoadingError(error)
                }
            }
        }
    }

    private func handleLoadingError(_ error: Error) {
        isLoadingProducts = false
        loadingTimer?.invalidate()
        loadingTimer = nil
        SVProgressHUD.dismiss()

        let alert = UIAlertController(
            title: "Loading Error",
            message: "Unable to load products. Please check your internet connection and try again.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Retry", style: .default) { [weak self] _ in
            self?.loadProducts()
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { [weak self] _ in
            self?.dismiss(animated: true)
        })
        present(alert, animated: true)
    }

    private func handleProductsLoaded() {
        isLoadingProducts = false
        loadingTimer?.invalidate()
        loadingTimer = nil
        SVProgressHUD.dismiss()
        updateProductViews()
    }

    private func handleLoadingTimeout() {
        guard isLoadingProducts else { return }

        isLoadingProducts = false
        loadingTimer?.invalidate()
        loadingTimer = nil
        SVProgressHUD.dismiss()

        let alert = UIAlertController(title: "Loading Timeout", message: "Unable to load products. Please try again later.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.dismiss(animated: true)
        })
        present(alert, animated: true)
    }

    private func updateProductViews() {
        itemStackView.arrangedSubviews.forEach {
            itemStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }

        for (index, product) in viewModel.products.enumerated() {
            let planView = createProductView(for: product, selected: index == viewModel.selectedIndex)
            planView.tag = index
            let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            planView.addGestureRecognizer(tap)
            itemStackView.addArrangedSubview(planView)
        }

        updateBonusChatsButton()
    }

    private func updateBonusChatsButton() {
        if let karmaProduct = StoreKitManager.shared.hasItem(item: .karma) {
            bonusView.setPriceTitle("Just \(karmaProduct.displayPrice)")
            bonusView.isHidden = false
        } else {
            bonusView.isHidden = true
        }
    }

    private func createProductView(for product: Product, selected: Bool) -> UIView {
        let item = viewModel.getStoreItem(for: product.id)
        let isTrial = item?.itemType == .trial
        let isPromoted = isTrial

        let titleText: String
        let priceText: String
        var captionText: String

        if isTrial {
            titleText = "3 Days Free"
            priceText = "then\n\(product.displayPrice)/week"
            captionText = "Billed weekly"
        } else {
            titleText = item?.title ?? product.displayName
            priceText = product.displayPrice
            captionText = billingCaption(for: item)
        }

        if viewModel.isItemPurchased(item) {
            captionText = "Purchased"
        }

        return PaywallV2PlanItemView(
            title: titleText,
            priceText: priceText,
            captionText: captionText,
            isSelected: selected,
            isPromoted: isPromoted,
            isTrial: isTrial
        )
    }

    private func billingCaption(for item: StoreItem?) -> String {
        switch item {
        case .monthly2:
            return "Billed monthly"
        case .weekly1, .weeklytrial1:
            return "Billed weekly"
        default:
            return ""
        }
    }

    private func restorePurchase() {
        viewModel.restore()
    }

    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        guard let selectedView = gesture.view else { return }
        viewModel.select(index: selectedView.tag)
        updateProductViews()
    }

    @objc private func purchaseTapped() {
        Task {
            await viewModel.purchaseSelectedItem()
        }
    }

    @objc private func bonusChatsTapped() {
        Task {
            await StoreKitManager.shared.purchase(item: .karma)
        }
    }

    @objc private func closeTapped() {
        if isLoadingProducts {
            loadingTimer?.invalidate()
            loadingTimer = nil
            isLoadingProducts = false
            SVProgressHUD.dismiss()
        }
        dismiss(animated: true)
    }

    private func showRestoreLoading() {
        SVProgressHUD.show(withStatus: "Restoring purchases...")
    }

    private func hideRestoreLoading() {
        SVProgressHUD.dismiss()
    }

    private func showRestoreSuccessAlert() {
        let alert = UIAlertController(
            title: "Restore Successful",
            message: "Your purchases have been successfully restored.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    private func showRestoreNoPurchasesAlert() {
        let alert = UIAlertController(
            title: "No Purchases Found",
            message: "No previous purchases were found to restore.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    private func showRestoreErrorAlert(_ error: Error) {
        let alert = UIAlertController(
            title: "Restore Failed",
            message: "Unable to restore purchases. Please try again later.\n\nError: \(error.localizedDescription)",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Retry", style: .default) { [weak self] _ in
            self?.restorePurchase()
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
}
