//
//  DSRouter.swift
//  TalkToBudda
//
//  Created by mac on 16/5/25.
//

import UIKit

enum StoreType: Codable {
    case direct, store
}
class DSRouter {
    
    @MainActor
    static func showDS(from vc: UIViewController, completion: (()->())? = nil) {
        let isPremium = StoreKitManager.shared.isPremium
        
        guard !isPremium else {
            completion?()
            return }
        
        let dsVC = PurchaseViewController()
        dsVC.modalPresentationStyle = .fullScreen
        vc.present(dsVC, animated: true, completion: completion)
    }
}
