//
//  AppDelegate.swift
//  TalkToBudda
//
//  Created by mac on 30/4/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        StoreKitManager.shared.startObservingTransactions()
        Task {
            do {
                try await StoreKitManager.shared.loadProducts()
                await StoreKitManager.shared.updateCurrentEntitlements()
            } catch {
                print("AppDelegate: Failed to load products: \(error)")
            }
        }
        setOnboardingAsRoot()
        return true
    }

    func setOnboardingAsRoot() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = LoadingVC()
        let nav = UINavigationController(rootViewController: vc)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
}

