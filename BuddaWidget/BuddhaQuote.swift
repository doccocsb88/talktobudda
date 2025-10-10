//
//  BuddhaQuote.swift
//  BuddaWidget
//
//  Created by mac on 10/10/25.
//

import Foundation

struct BuddhaQuote: Codable {
    let quote: String
    let source: String
}

class QuoteService {
    static let shared = QuoteService()
    
    private var quotes: [BuddhaQuote] = []
    
    private init() {
        loadQuotes()
    }
    
    private func loadQuotes() {
        guard let url = Bundle.main.url(forResource: "buddha_quotes_100", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let quotes = try? JSONDecoder().decode([BuddhaQuote].self, from: data) else {
            // Fallback quotes if file loading fails
            quotes = [
                BuddhaQuote(quote: "Mind precedes all things; mind is their chief.", source: "Dhammapada 1"),
                BuddhaQuote(quote: "If one speaks or acts with a pure mind, happiness follows like a shadow.", source: "Dhammapada 2"),
                BuddhaQuote(quote: "Hatred is never appeased by hatred; by non‑hatred alone is hatred appeased.", source: "Dhammapada 5")
            ]
            return
        }
        self.quotes = quotes
    }
    
    func getRandomQuote() -> BuddhaQuote {
        guard !quotes.isEmpty else {
            return BuddhaQuote(quote: "Mind precedes all things; mind is their chief.", source: "Dhammapada 1")
        }
        return quotes.randomElement() ?? quotes[0]
    }
    
    func getQuoteForDate(_ date: Date) -> BuddhaQuote {
        guard !quotes.isEmpty else {
            return BuddhaQuote(quote: "Mind precedes all things; mind is their chief.", source: "Dhammapada 1")
        }
        
        // Use date to determine which quote to show (for consistency)
        let calendar = Calendar.current
        let dayOfYear = calendar.ordinality(of: .day, in: .year, for: date) ?? 1
        let index = (dayOfYear - 1) % quotes.count
        return quotes[index]
    }
}
