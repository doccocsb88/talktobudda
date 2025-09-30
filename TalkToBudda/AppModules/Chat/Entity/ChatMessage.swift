//
//  ChatMessage.swift
//  TalkToBudda
//
//  Created by mac on 6/5/25.
//

import RxSwift
import RealmSwift
import Foundation

enum MessageSender: String, Codable, PersistableEnum {
    case user, bot
}

struct ChatMessage: Codable {
    let id: String
    let text: String
    let sender: MessageSender
    let createdAt: Date
    
    init(id: String = UUID().uuidString, text: String, sender: MessageSender, createdAt: Date = Date()) {
        self.id = id
        self.text = text
        self.sender = sender
        self.createdAt = createdAt
    }
}
