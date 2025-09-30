//
//  NetworkService.swift
//  TalkToBudda
//
//  Created by mac on 7/5/25.
//

import Foundation

final class NetworkService {
    
    private let apiKey: String
    private let baseURL = "https://api.openai.com/v1/chat/completions"
    
    init() {
        // Load API key from Info.plist
        guard let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
              let plist = NSDictionary(contentsOfFile: path),
              let apiKey = plist["OpenAI_API_Key"] as? String else {
            fatalError("OpenAI API Key not found in Info.plist")
        }
        self.apiKey = apiKey
    }
    
    func sendQuestion(_ question: String, conversation: ConversationCodable, characterType: CharacterType, completion: @escaping (Result<BuddhistResponse, Error>) -> Void) {
        // 1. Tạo system prompt và user message
        let systemPrompt = PromptBuilder.buildSystemPrompt(for: characterType)
        let userMessage = PromptBuilder.buildUserMessage(for: question, conversation: conversation)
        
        // 2. Tạo messages với proper roles
        var messages: [OpenAIMessage] = []
        
        // Thêm system message
        messages.append(OpenAIMessage(role: .system, content: systemPrompt))
        
        // Thêm conversation history với proper roles
        for message in conversation.messages {
            let role: OpenAIRole = message.sender == .user ? .user : .assistant
            messages.append(OpenAIMessage(role: role, content: message.text))
        }
        
        // Thêm current user message
        messages.append(OpenAIMessage(role: .user, content: userMessage))
        
        let requestBody = OpenAIRequest(model: .gpt4o, messages: messages)
        
        // 3. Tạo URLRequest
        guard let url = URL(string: baseURL) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        do {
            request.httpBody = try JSONEncoder().encode(requestBody)
        } catch {
            completion(.failure(NetworkError.encodingFailed))
            return
        }
        
        // 4. Thực hiện gọi API
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let openAIResponse = try JSONDecoder().decode(OpenAIResponse.self, from: data)
                if let answer = openAIResponse.choices.first?.message.content {
                    
                    var validatedAnswer = answer.replacingOccurrences(of: "```", with: "")
                    validatedAnswer = validatedAnswer.replacingOccurrences(of: "json", with: "")

                    // ✅ Mapping vào BuddhistResponse
                    
                    if let data = validatedAnswer.data(using: .utf8), let buddhistResponse = try? JSONDecoder().decode(BuddhistResponse.self, from: data) {
                        debugPrint("hai log answer:  \(buddhistResponse.answer)")
                        completion(.success(buddhistResponse))
                        
                    } else {
                        let buddhistResponse = BuddhistResponse(
                            question: question,
                            answer: answer.trimmingCharacters(in: .whitespacesAndNewlines)
                        )
                        completion(.success(buddhistResponse))
                        
                    }
                } else {
                    completion(.failure(NetworkError.noResponse))
                }
            } catch {
                completion(.failure(NetworkError.decodingFailed))
            }
        }
        
        task.resume()
    }
}

// MARK: - NetworkError
enum NetworkError: Error {
    case invalidURL
    case encodingFailed
    case noData
    case noResponse
    case decodingFailed
}
