//
//  UiViewController+Exts.swift
//  TalkToBudda
//
//  Created by mac on 11/5/25.
//

import UIKit

extension UIViewController {
    static func topMostViewController() -> UIViewController? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }) else {
            return nil
        }
        var topController = keyWindow.rootViewController
        while let presentedViewController = topController?.presentedViewController {
            topController = presentedViewController
        }
        return topController
        //        let keyWindow = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
        //        return keyWindow?.rootViewController?.topMostViewController()
    }

    func topMostViewController() -> UIViewController? {
        if let navigationController = self as? UINavigationController {
            return navigationController.topViewController?.topMostViewController()
        } else if let tabBarController = self as? UITabBarController {
            if let selectedViewController = tabBarController.selectedViewController {
                return selectedViewController.topMostViewController()
            }
            return tabBarController.topMostViewController()
        } else if let presentedViewController = self.presentedViewController {
            return presentedViewController.topMostViewController()
        } else {
            return self
        }
    }
}

