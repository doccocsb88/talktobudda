//
//  ChatDataManager.swift
//  TalkToBudda
//
//  Created by mac on 10/5/25.
//

import RealmSwift
import Foundation

class ChatDataManager {
    static let shared = ChatDataManager()
//    private(set) var conversation: ConversationCodable?
    
    private let realm: Realm
    
    init() {
        realm = try! Realm()
    }
    
    // Wrapper cho write an toàn
    private func safeWrite(_ block: (Realm) -> Void) {
        let realm = try! Realm()
        if realm.isInWriteTransaction {
            block(realm)
        } else {
            try! realm.write {
                block(realm)
            }
        }
    }
    
//    func createConversation() {
//        conversation = createConversation(title: "")
//    }
    
    // Thêm 1 tin nhắn
    func addMessage(_ text: String, sender: MessageSender) {
        let message = ChatMessageObject()
        message.text = text
        message.sender = sender
        message.createdAt = Date()
        
        
        safeWrite { realm in
            realm.add(message)
        }
    }

    // Lấy tất cả tin nhắn
    func fetchMessages() -> [ChatMessage] {
        let results = realm.objects(ChatMessageObject.self).sorted(byKeyPath: "createdAt", ascending: true)
        return results.map {
            ChatMessage(id: $0.id, text: $0.text, sender: $0.sender, createdAt: $0.createdAt)
        }
    }
    
    // Xóa tất cả tin nhắn
    func deleteAllMessages() {
        safeWrite { realm in
            let messages = realm.objects(ChatMessageObject.self)
            realm.delete(messages)
        }
    }
    
    func fetchAllConversations() -> [ConversationCodable] {
        let realm = try! Realm()
        let results = realm.objects(ConversationObject.self).sorted(byKeyPath: "createdAt", ascending: true)
        return results.map { ConversationCodable(from: $0) }
    }
    
    func createConversation(title: String, character: CharacterType? = nil) -> ConversationCodable {
        let conversation = ConversationObject()
        conversation.title = title
        conversation.createdAt = Date()
        conversation.selectedCharacter = character

        safeWrite { realm in
            realm.add(conversation)
        }

        return ConversationCodable(from: conversation)
    }

    func addMessage(chat: ChatMessage, to conversation: ConversationCodable?) {

        guard let conversationId = conversation?.id else { return }
        let realm = try! Realm()

        guard let conversation = realm.object(ofType: ConversationObject.self, forPrimaryKey: conversationId) else {
            print("Conversation not found with id: \(conversationId)")
            return
        }

        let message = ChatMessageObject()
        message.text = chat.text
        message.sender = chat.sender
        message.createdAt = Date()
//        self.conversation?.messages.append(chat)
        
        safeWrite { realm in
            conversation.messages.append(message)
        }
    }
    
    func updateConversationCharacter(conversationId: String, character: CharacterType?) {
        let realm = try! Realm()
        guard let conversation = realm.object(ofType: ConversationObject.self, forPrimaryKey: conversationId) else { return }

        safeWrite { realm in
            conversation.selectedCharacter = character
        }
    }
    
    func deleteConversation(withId id: String) {
        let realm = try! Realm()
        guard let conversation = realm.object(ofType: ConversationObject.self, forPrimaryKey: id) else { return }

        safeWrite { realm in
            // Xóa toàn bộ tin nhắn trong hội thoại
            realm.delete(conversation.messages)
            // Xóa hội thoại
            realm.delete(conversation)
        }
    }

}
