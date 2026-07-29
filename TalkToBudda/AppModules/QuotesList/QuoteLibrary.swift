//
//  QuoteLibrary.swift
//  TalkToBudda
//
//  Created by Codex on 29/7/26.
//

import Foundation

enum QuoteLibrary {
    static func loadQuotes() -> [QuoteCodable] {
        guard let url = Bundle.main.url(forResource: "buddha_quotes_100", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let quotes = try? JSONDecoder().decode([QuoteCodable].self, from: data) else {
            print("Failed to load quotes")
            return []
        }

        return quotes
    }
}
