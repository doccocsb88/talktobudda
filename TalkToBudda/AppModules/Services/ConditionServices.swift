//
//  ConditionServices.swift
//  TalkToBudda
//
//  Created by mac on 16/5/25.
//

import Foundation

class ConditionServices: NSObject {
    enum Keys {
        static let chatCountKey = "chat_count_key"
        static let totalchatFreeKey = "remaining_chat_key"
        static let giveUserFreeChatKey = "give_user_free_chat_key"


    }
    static let shared = ConditionServices()
    private(set) var totalChatFree: Int {
        get {
            return userDefault.integer(forKey: Keys.totalchatFreeKey)
        }
        
        set {
            userDefault.set(newValue, forKey: Keys.totalchatFreeKey)
            userDefault.synchronize()
        }
    }
    
    var chatCount: Int {
        return userDefault.integer(forKey: Keys.chatCountKey)
    }
    
    override init() {
        super.init()
        let isFirstTime = userDefault.bool(forKey: Keys.giveUserFreeChatKey)
        if !isFirstTime {
            totalChatFree = 5
            userDefault.set(true, forKey: Keys.giveUserFreeChatKey)
            userDefault.synchronize()
        }
    }
    
    private let userDefault = UserDefaults()
    
    func increasetChat() {
        let current = userDefault.integer(forKey: Keys.chatCountKey)
        userDefault.set(current + 1, forKey: Keys.chatCountKey)
        userDefault.synchronize()
    }
    
    func canChat() -> Bool {
        guard !StoreKitManager.shared.isPremium else { return true}
        let current = userDefault.integer(forKey: Keys.chatCountKey)
        return current <= totalChatFree
    }
    
    func addChatCount(count: Int = 10) {
        totalChatFree += count
        userDefault.synchronize()
    }
}
