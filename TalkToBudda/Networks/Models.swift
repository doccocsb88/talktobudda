//
//  Models.swift
//  TalkToBudda
//
//  Created by mac on 7/5/25.
//

import Foundation

// MARK: - OpenAIModel
enum OpenAIModel: String, Encodable {
    case gpt3_5Turbo = "gpt-3.5-turbo"
    case gpt4 = "gpt-4"
    case gpt4Turbo = "gpt-4-turbo"
    case gpt4o = "gpt-4o" // nếu bạn dùng GPT-4o mới nhất
}

// MARK: - OpenAI Request
struct OpenAIRequest: Encodable {
    let model: OpenAIModel
    let messages: [OpenAIMessage]
}

enum OpenAIRole: String, Encodable {
    case system = "system"
    case assistant = "assistant"
    case user = "user"
}

struct OpenAIMessage: Encodable {
    let role: OpenAIRole
    let content: String
}

// MARK: - OpenAI Response
struct OpenAIResponse: Decodable {
    let choices: [OpenAIChoice]
}

struct OpenAIChoice: Decodable {
    let message: OpenAIMessageContent
}

struct OpenAIMessageContent: Decodable {
    let content: String
}

// MARK: - Mapped Response
struct BuddhistResponse: Codable {
    let question: String
    let answer: String
}
