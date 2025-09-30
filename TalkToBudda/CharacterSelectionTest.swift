//
//  CharacterSelectionTest.swift
//  TalkToBudda
//
//  Created by mac on 6/5/25.
//

import Foundation

// Simple test to verify character selection functionality
class CharacterSelectionTest {
    
    static func testCharacterCreation() {
        print("Testing Character Creation...")
        
        for characterType in CharacterType.allCases {
            let character = Character(type: characterType)
            print("Character: \(character.name)")
            print("Description: \(character.description)")
            print("Avatar: \(character.avatarImageName)")
            print("Greeting: \(character.greetingMessage)")
            print("---")
        }
    }
    
    static func testConversationWithCharacter() {
        print("Testing Conversation with Character...")
        
        let dataManager = ChatDataManager.shared
        
        // Create conversation with Buddha character
        let conversation = dataManager.createConversation(title: "Test Conversation", character: .buddha)
        print("Created conversation with ID: \(conversation.id)")
        print("Selected character: \(conversation.selectedCharacter?.displayName ?? "None")")
        
        // Update character
        dataManager.updateConversationCharacter(conversationId: conversation.id, character: .zenMaster)
        print("Updated character to: Zen Master")
        
        // Fetch updated conversation
        let conversations = dataManager.fetchAllConversations()
        if let updatedConversation = conversations.first(where: { $0.id == conversation.id }) {
            print("Updated conversation character: \(updatedConversation.selectedCharacter?.displayName ?? "None")")
        }
    }
    
    static func runAllTests() {
        print("=== Character Selection Tests ===")
        testCharacterCreation()
        testConversationWithCharacter()
        print("=== Tests Completed ===")
    }
}
