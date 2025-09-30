//
//  CustomTabBarController.swift
//  TalkToBudda
//
//  Created by mac on 5/5/25.
//

import UIKit
import SnapKit

final class CustomTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        setupTabBarAppearance()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func setupViewControllers() {
        let tabs: [(UIViewController, String, String)] = [
            (ChatRouter.createModule(), "Home", "tabbar1"),
            (MeditationMoodRouter.createModule(), "Meditation","tabbar2"),
            (HistoryWireframe().viewController, "History","tabbar3"),
            (ScriptureRouter.createModule(), "Scriptures", "tabbar4")
        ]
        
        let iconSize = CGSize(width: 34, height: 34)
        
        let controllers = tabs.map { vc, title, icon in
            let nav = UINavigationController(rootViewController: vc)
            nav.setNavigationBarHidden(true, animated: false)
            let originalImage = UIImage(named: icon)?.withRenderingMode(.alwaysOriginal)
            let resizedImage = originalImage?.resized(to: iconSize)?.withRenderingMode(.alwaysOriginal)
            
            let tabBarItem = UITabBarItem(title: title, image: resizedImage, selectedImage: resizedImage)
//            tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor(hexString: "4B3621")], for: .normal)
//            tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor(hexString: "4B3621")], for: .selected)

            // Căn chỉnh icon cho phù hợp (tùy chỉnh nếu icon nhỏ/quá lớn)
//            tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
            
            nav.tabBarItem = tabBarItem
            
            return nav
        }
        
        viewControllers = controllers
    }
    
    private func setupTabBarAppearance() {
        tabBar.layer.cornerRadius = 20
        tabBar.layer.masksToBounds = true
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        tabBar.backgroundColor = .white
        tabBar.tintColor = .systemBlue
        tabBar.unselectedItemTintColor = .lightGray
        
        // Shadow
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.1
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -3)
        tabBar.layer.shadowRadius = 10
        
        // Padding tab bar (iOS 15+ safe inset)
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            tabBar.scrollEdgeAppearance = appearance
            tabBar.standardAppearance = appearance
        }
    }
}
