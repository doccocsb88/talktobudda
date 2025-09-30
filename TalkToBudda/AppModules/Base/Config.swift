//
//  Config.swift
//  TalkToBudda
//
//  Created by mac on 30/4/25.
//

import Foundation
import UIKit

typealias SelectionHandler = () -> Void

struct Common {
    enum Screen {
        static let height = UIScreen.main.bounds.height
        static let width = UIScreen.main.bounds.width
    }

    enum Position: String {
        case top
        case bottom
    }

    static let userDefault = UserDefaults.standard
}

enum Configs {
    enum App {
        static var appId: String {
            return "1268937966"
        }

        static let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? "Talk to Budda"
    }

    enum URL {
        static let reviewAppURL = "itms-apps://itunes.apple.com/US/app/id\(App.appId)?action=write-review"
        static let emailSupport = "mrhaihcmus@gmail.com"

//        static let policy: String = "http://vulcanlabs.co/index.php/privacy-policy/"
//        static let term: String = "http://vulcanlabs.co/index.php/terms-of-use/"
        static let share: String = "https://itunes.apple.com/app/apple-store/id%@?pt=\(App.appId)&ct=ShareButton&mt=8"
//        static let others: String = "itms-apps://itunes.apple.com/us/developer/smart-widget-labs-company-limited/id1561934122"
        static let manageSubsciptions: String = "itms-apps://apps.apple.com/account/subscriptions"
    }
}
