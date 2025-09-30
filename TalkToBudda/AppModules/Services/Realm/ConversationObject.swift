//
//  ConversationObject.swift
//  TalkToBudda
//
//  Created by mac on 10/5/25.
//

import RealmSwift
import Foundation

struct ConversationCodable: Codable {
    let id: String
    let title: String
    let createdAt: Date
    var messages: [ChatMessage]
    var selectedCharacter: CharacterType?
    
    mutating func generate() {
        messages.removeAll()
        let chatMessage1 = ChatMessage(text: "Venerable World-Honored One, my daily work is filled with stress and conflicts with others. How can I find peace in such a challenging environment?", sender: .user)
        let chatMessage2 = ChatMessage(text: "My child, to find peace in your work, practice Right Effort and Right Mindfulness from the Noble Eightfold Path. See conflicts as opportunities to cultivate patience and compassion, understanding that others’ actions stem from their own suffering. Stay mindful, let go of anger, and you will create harmony within yourself and with those around you.", sender: .bot)
        
        let chatMessage3 = ChatMessage(text: "But at home, I struggle to balance my responsibilities while keeping loving relationships with my family. How can I nurture harmony there as well?", sender: .user)
        let chatMessage4 = ChatMessage(text: "My child, extend the same mindfulness to your family life through Right Speech and Right Action. Speak words that are kind, truthful, and unifying, and act with generosity and understanding toward your loved ones. A daily meditation practice will calm your mind, allowing your home to reflect the peace you carry within.", sender: .bot)
        
        let chatMessage5 = ChatMessage(text: "Your guidance brings clarity, Venerable One. Yet, in my personal spiritual practice, I find myself distracted by worldly desires. How can I stay focused on the path to liberation while living in this world?", sender: .user)
        let chatMessage6 = ChatMessage(text: "My child, distractions arise from clinging to the impermanent. Deepen your Right Concentration through meditation, contemplating the Three Marks of Existence—impermanence, suffering, and non-self. By anchoring your heart in the Four Noble Truths, you will walk steadily toward Nirvana, undeterred by fleeting desires.", sender: .bot)
        
        messages = [chatMessage1, chatMessage2, chatMessage3, chatMessage4, chatMessage5, chatMessage6]
    }
    
    mutating func generate2() {
        messages.removeAll()
        let chatMessage1 = ChatMessage(text: "Venerable World-Honored One, my daily work is filled with stress and conflicts with others. How can I find peace in such a challenging environment?", sender: .user)
        let chatMessage2 = ChatMessage(text: "My child, to find peace in your work, practice Right Effort and Right Mindfulness from the Noble Eightfold Path. See conflicts as opportunities to cultivate patience and compassion, understanding that others’ actions stem from their own suffering. Stay mindful, let go of anger, and you will create harmony within yourself and with those around you.", sender: .bot)
        messages = [chatMessage1, chatMessage2]
    }
    
    mutating func generate1() {
        messages.removeAll()
        let chatMessage3 = ChatMessage(text: "But at home, I struggle to balance my responsibilities while keeping loving relationships with my family. How can I nurture harmony there as well?", sender: .user)
        let chatMessage4 = ChatMessage(text: "My child, extend the same mindfulness to your family life through Right Speech and Right Action. Speak words that are kind, truthful, and unifying, and act with generosity and understanding toward your loved ones. A daily meditation practice will calm your mind, allowing your home to reflect the peace you carry within.", sender: .bot)
        messages = [chatMessage3, chatMessage4]
    }
    
}

extension ConversationCodable {
    init(from object: ConversationObject) {
        self.id = object.id
        self.title = object.title
        self.createdAt = object.createdAt
        self.messages = object.messages.map {
            ChatMessage(id: $0.id, text: $0.text, sender: $0.sender, createdAt: $0.createdAt)
        }
        self.selectedCharacter = object.selectedCharacter
    }
}


class ConversationObject: Object {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var title: String = "" // Ví dụ: "Cuộc hội thoại với ChatBot"
    @Persisted var createdAt: Date = Date()
    @Persisted var selectedCharacter: CharacterType?

    // Danh sách các tin nhắn thuộc đoạn hội thoại
    @Persisted var messages: List<ChatMessageObject>
}
