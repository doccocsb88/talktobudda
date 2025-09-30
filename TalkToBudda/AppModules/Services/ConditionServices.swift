//
//  ConditionServices.swift
//  TalkToBudda
//
//  Created by mac on 16/5/25.
//

import Foundation

class ConditionServices {
    enum Keys {
        static let chatCountKey = "chat_count_key"
    }
    static let shared = ConditionServices()
    
    private let userDefault = UserDefaults()
    
    func increasetChat() {
        let current = userDefault.integer(forKey: Keys.chatCountKey)
        userDefault.set(current + 1, forKey: Keys.chatCountKey)
        userDefault.synchronize()
    }
    
    func canChat() -> Bool {
        guard !StoreKitManager.shared.isPremium else { return true}
        let current = userDefault.integer(forKey: Keys.chatCountKey)
        return current <= 5
    }
}
