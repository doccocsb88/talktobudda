//
//  PurchaseViewController.swift
//  TalkToBudda
//
//  Created by mac on 14/5/25.
//

import UIKit
import SnapKit
import StoreKit
import SVProgressHUD

class PurchaseViewController: UIViewController {
    let scrollView = UIScrollView()

    private lazy var contentStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()

    private let backgroundImageView = UIImageView(image: UIImage(named: "ds1-background"))
    private let buddhaImageView = UIImageView(image: UIImage(named: "ds1-banner"))
    private let titleLabel = UILabel()
    private let itemStackView = UIStackView()
    private let benifitStackView = UIStackView()
    private let headerView = UIView()
    
    private let bonusChatsButton = UIButton()
    private let bonusChatsView = UIView()
    
    private let continueButton = UIButton()
    private let continueView = UIView()

    private lazy var policyActionView: StoreOnePolicyActionView = {
        let view = StoreOnePolicyActionView()
        view.onPrivacyTapped = { [weak self] in
            guard let url = Bundle.main.url(forResource: "privacy-policy.html", withExtension: nil) else { return }
            self?.openWeb(url: url, title: "Privacy Policy")
        }

        view.onTermsTapped = { [weak self] in
            guard let url = Bundle.main.url(forResource: "terms-of-use.html", withExtension: nil) else { return }
            self?.openWeb(url: url, title: "Term of Use")
        }

        view.onRestoreTapped = { [weak self] in
            self?.restorePurchase()
        }
        return view
    }()

    
    private lazy var termPrivacyLabelView: UILabel = {
        let footerLabel = UILabel()
        footerLabel.numberOfLines = 0
        footerLabel.textAlignment = .justified
        footerLabel.font = FontFamily.PlayfairDisplay.regular.font(size: view.hasTopNorth ? 12 : 10)
        footerLabel.textColor = .neutral100

        let policy = Texts.storePolicy1.rawValue + "\n" + Texts.storePolicy2.rawValue
        footerLabel.text = policy

        return footerLabel
    }()
        
    private lazy var closeButton: UIButton = UIButton()
    
    private let viewModel = PurchaseViewModel()
    private var loadingTimer: Timer?
    private var isLoadingProducts = false
    
    let benifits: [(UIImage, String)] = [
        (Asset.Assets.tabbar1.image, "Unlimited chats with AI Budda"),
        (Asset.Assets.tabbar2.image, "Access all guided meditations & practices"),
        (Asset.Assets.tabbar3.image, "Save your personal path history"),
    ]
    
    let storeType: StoreType
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
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor.color7D5A4F.cgColor,
            UIColor.colorFDF6ED.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)

        view.layer.insertSublayer(gradientLayer, at: 0)
        setupScrollView()
        setupUI()
        loadProducts()
        viewModel.onItemPurchased = {[weak self] item in
            if self?.storeType == .direct {
                self?.dismiss(animated: true)
            }
        }
        
        // Setup restore purchase callbacks
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

    private func setupScrollView() {
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.bounces = false
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        scrollView.addSubview(backgroundImageView)
        scrollView.addSubview(contentStack)

        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }

        contentStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(20)
            make.width.equalTo(scrollView.snp.width).offset(-40)
        }
        
        contentStack.addArrangedSubview(headerView)
        contentStack.addArrangedSubview(bonusChatsView)
        contentStack.addArrangedSubview(itemStackView)
        contentStack.addArrangedSubview(continueView)
        contentStack.addArrangedSubview(policyActionView)
        contentStack.addArrangedSubview(termPrivacyLabelView)
        
        headerView.addSubview(titleLabel)
        headerView.addSubview(buddhaImageView)
        headerView.addSubview(benifitStackView)
    }
    
    private func setupUI() {
        backgroundImageView.contentMode = .scaleAspectFill

        view.addSubview(closeButton)
        buddhaImageView.contentMode = .scaleAspectFit
        

        closeButton.setImage(Asset.Assets.icClose.image, for: .normal)
        closeButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            make.width.height.equalTo(35)
        }
        
        titleLabel.isHidden = true
        titleLabel.text = "Chọn gói hành trì\nphù hợp với bạn"
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = .black
        titleLabel.isHidden = true
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(50)
        }
        
        buddhaImageView.snp.makeConstraints {
            $0.height.width.equalTo(view.hasTopNorth ? 250 : 200)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.top)
        }
        
        benifitStackView.snp.makeConstraints { make in
            make.top.equalTo(buddhaImageView.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalTo(view.hasTopNorth ? 105 : 90)
        }

        headerView.snp.makeConstraints { make in
            make.bottom.equalTo(benifitStackView.snp.bottom).offset(view.hasTopNorth ? 30 : 8)
        }
        
        benifitStackView.axis = .vertical
        benifitStackView.alignment = .leading
        benifitStackView.spacing = 0
        benifitStackView.distribution = .fill
        for benifit in benifits {
            let itemView = createBefinitView(image: benifit.0, text: benifit.1)
            benifitStackView.addArrangedSubview(itemView)
        }

        itemStackView.axis = .horizontal
        itemStackView.distribution = .fillEqually
        itemStackView.spacing = 12

        itemStackView.snp.makeConstraints {
            $0.height.equalTo(120)
        }

        // Setup bonus chats button
        bonusChatsButton.setTitle("Get 10 bonus chats to deepen your practice. just price", for: .normal)
        bonusChatsButton.setTitleColor(.white, for: .normal)
        bonusChatsButton.backgroundColor = UIColor(hexString: "#8B4513")
        bonusChatsButton.titleLabel?.font = FontFamily.PlayfairDisplay.medium.font(size: 14)
        bonusChatsButton.titleLabel?.numberOfLines = 0
        bonusChatsButton.titleLabel?.textAlignment = .center
        bonusChatsButton.rounded(radius: 12)

        bonusChatsView.snp.makeConstraints { make in
            make.height.equalTo(view.hasTopNorth ? 60 : 50)
        }
        bonusChatsView.addSubview(bonusChatsButton)
        bonusChatsButton.snp.makeConstraints {
            $0.height.equalTo(view.hasTopNorth ? 50 : 40)
            $0.center.equalToSuperview()
            $0.left.right.equalToSuperview()
        }

        continueButton.setTitle("Subscribe Now", for: .normal)
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.backgroundColor = UIColor(hexString: "#e26613")
        continueButton.titleLabel?.font = FontFamily.PlayfairDisplay.medium.font(size: 16)
        continueButton.rounded(radius: 12)

        continueView.snp.makeConstraints { make in
            make.height.equalTo(view.hasTopNorth ? 100 : 50)
        }
        continueView.addSubview(continueButton)
        continueButton.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.center.equalToSuperview()
            $0.left.equalToSuperview()
        }

        policyActionView.snp.makeConstraints{$0.height.equalTo(35)}
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        continueButton.addTarget(self, action: #selector(purchaseTapped), for: .touchUpInside)
        bonusChatsButton.addTarget(self, action: #selector(bonusChatsTapped), for: .touchUpInside)
    }

    private func loadProducts() {
        // Show loading immediately
        isLoadingProducts = true
        SVProgressHUD.show(withStatus: "Loading products...")
        
        // Start 15-second timeout timer
        loadingTimer = Timer.scheduledTimer(withTimeInterval: 15.0, repeats: false) { [weak self] _ in
            self?.handleLoadingTimeout()
        }
        
        Task {
            do {
                try await viewModel.load()
                await MainActor.run {
                    handleProductsLoaded()
                }
            } catch {
                await MainActor.run {
                    handleLoadingError(error)
                }
            }
        }
    }
    
    private func handleLoadingError(_ error: Error) {
        isLoadingProducts = false
        loadingTimer?.invalidate()
        loadingTimer = nil
        SVProgressHUD.dismiss()
        
        // Show error alert
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
        
        // Show alert and dismiss view
        let alert = UIAlertController(title: "Loading Timeout", message: "Unable to load products. Please try again later.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.dismiss(animated: true)
        })
        present(alert, animated: true)
    }

    private func updateProductViews() {
        itemStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for (index, product) in viewModel.products.enumerated() {
            let view = createProductView(for: product, selected: index == viewModel.selectedIndex)
            view.tag = index
            Task {
                let isEligableForPurchase = await product.isEligableForPurchase
                
//                view.backgroundColor = isEligableForPurchase ? .red : .yellow
            }
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            view.addGestureRecognizer(tap)
            itemStackView.addArrangedSubview(view)
        }
        itemStackView.backgroundColor = UIColor(hexString: "#feb022")
        itemStackView.rounded(radius: 20)
        
        // Update bonus chats button with consumable price
        updateBonusChatsButton()
    }
    
    private func updateBonusChatsButton() {
        // Check if karma (consumable) product is available
        if let karmaProduct = StoreKitManager.shared.hasItem(item: .karma) {
            let price = karmaProduct.displayPrice
            bonusChatsButton.setTitle("Get 10 bonus chats to deepen your practice.\njust \(price)", for: .normal)
            bonusChatsButton.isHidden = false
        } else {
            bonusChatsButton.isHidden = true
        }
    }

    private func createProductView(for product: Product, selected: Bool) -> UIView {
        let container = UIView()
        container.layer.cornerRadius = 20
        container.backgroundColor = selected ? UIColor(hexString: "#63a8bf") : UIColor.clear

        let titleLabel = UILabel()
        let item = viewModel.getStoreItem(for: product.id)
        titleLabel.font = FontFamily.PlayfairDisplay.medium.font(size: 15)
        titleLabel.textColor = .color4B3621

        let priceLabel = UILabel()
        priceLabel.font = FontFamily.PlayfairDisplay.semiBold.font(size: 15)
        priceLabel.textColor = .color4B3621
        priceLabel.numberOfLines = 0
        priceLabel.textAlignment = .center
        
        if item?.itemType == .trial {
            titleLabel.text = "Free 3 days"
            priceLabel.text = "then\n\(product.displayPrice)/Week"
        } else {
            titleLabel.text = item?.title ?? product.displayName
            priceLabel.text = product.displayPrice
        }
        let isPurchased = viewModel.isItemPurchased(item)

        if isPurchased {
            priceLabel.text = "Purchased"
        }
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, priceLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 12
        container.addSubview(stack)
        
     
        stack.snp.makeConstraints {
            $0.center.equalToSuperview().inset(10)
            $0.width.equalToSuperview()
            $0.height.lessThanOrEqualToSuperview()
        }

        return container
    }
    
    func createBefinitView(image: UIImage, text: String) -> UIView{
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        let textLabel = UILabel()
        textLabel.text = text
        textLabel.font = FontFamily.Inter28pt.regular.font(size: view.hasTopNorth ? 14 : 12)
        textLabel.textColor = .black
        
        let stack = UIStackView(arrangedSubviews: [imageView, textLabel])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 5
        
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(view.hasTopNorth ? 35 : 30)
        }
        return stack
    }

    
    func restorePurchase() {
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
        // Purchase karma (consumable) product directly
        Task {
            await StoreKitManager.shared.purchase(item: .karma)
        }
    }
    
    @objc private func closeTapped() {
        // Clean up loading state if user manually closes
        if isLoadingProducts {
            loadingTimer?.invalidate()
            loadingTimer = nil
            isLoadingProducts = false
            SVProgressHUD.dismiss()
        }
        dismiss(animated: true)
    }
    
    // MARK: - Restore Purchase Methods
    
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
