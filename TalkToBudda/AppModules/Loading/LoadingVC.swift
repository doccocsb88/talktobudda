//
//  LoadingVC.swift
//  TalkToBudda
//
//  Created by mac on 11/5/25.
//

import UIKit
import SnapKit
import AppTrackingTransparency
import AdSupport

class LoadingVC: UIViewController {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: Asset.Assets.icSplash.image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Focus the mind"
        label.font = FontFamily.FiraMono.medium.font(size: 14)
        label.textColor = .color4B3621
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .colorFDF6ED
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(view.hasTopNorth ? 200 : 100)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(30)
            make.height.equalTo(imageView.snp.width).multipliedBy(1.5)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
        
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) {[weak self] _ in
            self?.requestIDFAAndNavigate()
        }
    }
    
    // MARK: - IDFA Request
    private func requestIDFAAndNavigate() {
        // Check if iOS 14+ and ATT is available
        if #available(iOS 14, *) {
            switch ATTrackingManager.trackingAuthorizationStatus {
            case .notDetermined:
                // Request permission
                ATTrackingManager.requestTrackingAuthorization { [weak self] status in
                    DispatchQueue.main.async {
                        self?.handleIDFAResponse(status: status)
                    }
                }
            case .authorized, .denied, .restricted:
                // Permission already determined, proceed with navigation
                handleIDFAResponse(status: ATTrackingManager.trackingAuthorizationStatus)
            @unknown default:
                // Handle unknown cases
                goToNextScreen()
            }
        } else {
            // iOS 13 and below - IDFA is available by default
            goToNextScreen()
        }
    }
    
    private func handleIDFAResponse(status: ATTrackingManager.AuthorizationStatus) {
        switch status {
        case .authorized:
            // IDFA is available
            let idfa = ASIdentifierManager.shared().advertisingIdentifier
            print("IDFA authorized: \(idfa)")
            // You can store this IDFA or send it to your analytics service here
            
        case .denied, .restricted:
            // IDFA is not available
            print("IDFA denied or restricted")
            
        case .notDetermined:
            // This shouldn't happen after request, but handle it
            print("IDFA status not determined")
            
        @unknown default:
            print("Unknown IDFA status")
        }
        
        // Navigate to next screen regardless of IDFA status
        goToNextScreen()
    }
    
    func goToNextScreen() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }

        guard
            let navigationController = appDelegate.window?.rootViewController as? UINavigationController,
            !navigationController.viewControllers.isEmpty
        else {
            return
        }

        if PreferenceService.shared.isShowedOnboarding {
            navigationController.setViewControllers([CustomTabBarController()], animated: true)
            DSRouter.showDS(from: self)
        } else {
            navigationController.setViewControllers([OnboardingViewController()], animated: true)
        }
    }

    
}
