//
//  LoadingVC.swift
//  TalkToBudda
//
//  Created by mac on 11/5/25.
//

import UIKit
import SnapKit

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
            self?.goToNextScreen()
        }
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
