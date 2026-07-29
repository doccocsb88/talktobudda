//
//  CustomTabBarController.swift
//  TalkToBudda
//
//  Created by mac on 5/5/25.
//

import UIKit
import SnapKit

final class CustomTabBarController: UITabBarController {
    private enum TabBarStyle {
        static let iconSize = CGSize(width: 28, height: 28)
        static let activeTextColor = UIColor(hexString: "#4B3621")
        static let inactiveTextColor = UIColor(hexString: "#8E7C69")
        static let selectedPillColor = UIColor(hexString: "#F1F0EC")
        static let barBackgroundColor = UIColor.white
        static let shadowColor = UIColor(hexString: "#D7C3A7")
        static let titleFont = UIFont.systemFont(ofSize: 12, weight: .medium)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        setupTabBarAppearance()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateSelectedTabIndicator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func setupViewControllers() {
        let tabs: [(UIViewController, String, String)] = [
            (GuidanceViewController(), "Guidance", "tabbar1"),
            (MeditationMoodRouter.createModule(), "Meditation","tabbar2"),
            (HistoryWireframe().viewController, "History","tabbar3"),
            (ScriptureRouter.createModule(), "Scriptures", "tabbar4")
        ]

        let controllers = tabs.map { vc, title, icon in
            let nav = UINavigationController(rootViewController: vc)
            nav.setNavigationBarHidden(true, animated: false)
            let originalImage = UIImage(named: icon)?.withRenderingMode(.alwaysTemplate)
            let resizedImage = originalImage?.resized(to: TabBarStyle.iconSize)?.withRenderingMode(.alwaysTemplate)
            
            let tabBarItem = UITabBarItem(title: title, image: resizedImage, selectedImage: resizedImage)
            nav.tabBarItem = tabBarItem
            
            return nav
        }
        
        viewControllers = controllers
    }
    
    private func setupTabBarAppearance() {
        tabBar.layer.cornerRadius = 20
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        tabBar.backgroundColor = TabBarStyle.barBackgroundColor
        tabBar.tintColor = TabBarStyle.activeTextColor
        tabBar.unselectedItemTintColor = TabBarStyle.inactiveTextColor
        tabBar.itemPositioning = .centered
        tabBar.itemWidth = 84
        tabBar.itemSpacing = 8
        
        tabBar.layer.shadowColor = TabBarStyle.shadowColor.cgColor
        tabBar.layer.shadowOpacity = 0.24
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -6)
        tabBar.layer.shadowRadius = 10
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = TabBarStyle.barBackgroundColor
        appearance.shadowColor = .clear
        
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: TabBarStyle.inactiveTextColor,
            .font: TabBarStyle.titleFont
        ]
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: TabBarStyle.activeTextColor,
            .font: TabBarStyle.titleFont
        ]
        
        [appearance.stackedLayoutAppearance,
         appearance.inlineLayoutAppearance,
         appearance.compactInlineLayoutAppearance].forEach { layoutAppearance in
            layoutAppearance.normal.iconColor = TabBarStyle.inactiveTextColor
            layoutAppearance.normal.titleTextAttributes = normalAttributes
            layoutAppearance.selected.iconColor = TabBarStyle.activeTextColor
            layoutAppearance.selected.titleTextAttributes = selectedAttributes
        }
        
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
        
        updateSelectedTabIndicator()
    }
    
    private func updateSelectedTabIndicator() {
        let width = tabBar.itemWidth > 0 ? tabBar.itemWidth : 84
        let indicatorSize = CGSize(width: width, height: 56)
        let indicatorImage = UIImage.roundedRect(
            color: TabBarStyle.selectedPillColor,
            size: indicatorSize,
            cornerRadius: indicatorSize.height / 2
        )
        
        let appearance = tabBar.standardAppearance.copy()
        appearance.selectionIndicatorImage = indicatorImage
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
    }
}

private extension UIImage {
    static func roundedRect(color: UIColor, size: CGSize, cornerRadius: CGFloat) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            let rect = CGRect(origin: .zero, size: size)
            let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
            color.setFill()
            path.fill()
        }.withRenderingMode(.alwaysOriginal)
    }
}
