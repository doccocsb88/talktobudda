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
    let id: String?
    let object: String?
    let created: Int?
    let model: String?
    let choices: [OpenAIChoice]
    let usage: OpenAIUsage?
}

struct OpenAIChoice: Decodable {
    let index: Int?
    let message: OpenAIMessageContent
    let finishReason: String?
    
    enum CodingKeys: String, CodingKey {
        case index
        case message
        case finishReason = "finish_reason"
    }
}

struct OpenAIMessageContent: Decodable {
    let role: String?
    let content: String?
}

struct OpenAIUsage: Decodable {
    let promptTokens: Int?
    let completionTokens: Int?
    let totalTokens: Int?
    
    enum CodingKeys: String, CodingKey {
        case promptTokens = "prompt_tokens"
        case completionTokens = "completion_tokens"
        case totalTokens = "total_tokens"
    }
}

// MARK: - Mapped Response
struct BuddhistResponse: Codable {
    let question: String
    let answer: String
}
