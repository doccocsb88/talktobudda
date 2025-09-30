//
//  Product+Exts.swift
//  TalkToBudda
//
//  Created by mac on 15/5/25.
//

import StoreKit

extension Product {
    var isEligableForPurchase: Bool {
        get async {
            guard type == .autoRenewable, subscription?.introductoryOffer?.type == .introductory else { return true }
            switch await latestTransaction {
            case .verified: return false
            default: return true
            }
        }
    }
}

