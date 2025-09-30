//
//  ChatMessageObject.swift
//  TalkToBudda
//
//  Created by mac on 10/5/25.
//

import Foundation
import RealmSwift

//enum MessageSender: String, PersistableEnum {
//    case user
//    case bot
//}

class ChatMessageObject: Object {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var text: String
    @Persisted var sender: MessageSender
    @Persisted var createdAt: Date = Date()
}

extension ChatMessageObject {
    convenience init(from chatMessage: ChatMessage) {
        self.init()
        self.text = chatMessage.text
        self.sender = chatMessage.sender
    }
}

extension ChatMessage {
    init(from object: ChatMessageObject) {
        self.id = object.id
        self.text = object.text
        self.sender = object.sender
        self.createdAt = object.createdAt
    }
}
