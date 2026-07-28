//
//  AppDelegate.swift
//  TalkToBudda
//
//  Created by mac on 30/4/25.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        configureRealm()
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

    private func configureRealm() {
        let config = Realm.Configuration(schemaVersion: 1) { _, oldSchemaVersion in
            if oldSchemaVersion < 1 {
                // New optional wisdom fields default to nil for existing conversations.
            }
        }
        Realm.Configuration.defaultConfiguration = config
    }

    func setOnboardingAsRoot() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = LoadingVC()
        let nav = UINavigationController(rootViewController: vc)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
}
