//
//  BuddaWidget.swift
//  BuddaWidget
//
//  Created by mac on 10/10/25.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> QuoteEntry {
        let quotes = [BuddhaQuote(quote: "Mind precedes all things; mind is their chief.", source: "Dhammapada 1")]
        return QuoteEntry(date: Date(), quotes: quotes, configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> QuoteEntry {
        let quotes = generateQuotesForContext(context)
        return QuoteEntry(date: Date(), quotes: quotes, configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<QuoteEntry> {
        var entries: [QuoteEntry] = []

        // Generate a timeline based on refresh frequency
        let currentDate = Date()
        let calendar = Calendar.current
        
        let hourInterval: Int
        switch configuration.refreshFrequency {
        case .every3Hours:
            hourInterval = 3
        case .every6Hours:
            hourInterval = 6
        case .every12Hours:
            hourInterval = 12
        case .daily:
            hourInterval = 24
        }
        
        for hourOffset in stride(from: 0, to: 24, by: hourInterval) {
            let entryDate = calendar.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let quotes = generateQuotesForContext(context)
            let entry = QuoteEntry(date: entryDate, quotes: quotes, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
    
    private func generateQuotesForContext(_ context: Context) -> [BuddhaQuote] {
        switch context.family {
        case .systemMedium:
            return [QuoteService.shared.getRandomQuote()]
        case .systemLarge:
            return [
                QuoteService.shared.getRandomQuote(),
                QuoteService.shared.getRandomQuote()
            ]
        default:
            return [QuoteService.shared.getRandomQuote()]
        }
    }
}

struct QuoteEntry: TimelineEntry {
    let date: Date
    let quotes: [BuddhaQuote]
    let configuration: ConfigurationAppIntent
}

struct BackgroundView: View {
    let style: BackgroundStyle
    let family: WidgetFamily
    
    var body: some View {
        switch style {
        case .gradient:
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.95, green: 0.92, blue: 0.85),
                    Color(red: 0.90, green: 0.87, blue: 0.80)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
        case .lotus:
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.98, green: 0.95, blue: 0.90),
                        Color(red: 0.92, green: 0.88, blue: 0.82)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                
                // Lotus pattern overlay
                VStack {
                    HStack {
                        Text("🪷")
                            .font(.system(size: family == .systemLarge ? 25 : 20))
                            .opacity(0.3)
                        Spacer()
                        Text("🪷")
                            .font(.system(size: family == .systemLarge ? 20 : 15))
                            .opacity(0.2)
                    }
                    Spacer()
                    HStack {
                        Text("🪷")
                            .font(.system(size: family == .systemLarge ? 18 : 12))
                            .opacity(0.25)
                        Spacer()
                        Text("🪷")
                            .font(.system(size: family == .systemLarge ? 22 : 18))
                            .opacity(0.3)
                    }
                }
                .padding()
            }
            
        case .zen:
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.96, green: 0.94, blue: 0.88),
                        Color(red: 0.88, green: 0.85, blue: 0.78)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                
                // Zen garden pattern
                VStack {
                    HStack {
                        Circle()
                            .fill(Color(red: 0.7, green: 0.7, blue: 0.7).opacity(0.3))
                            .frame(width: family == .systemLarge ? 8 : 6, height: family == .systemLarge ? 8 : 6)
                        Spacer()
                        Circle()
                            .fill(Color(red: 0.6, green: 0.6, blue: 0.6).opacity(0.2))
                            .frame(width: family == .systemLarge ? 6 : 4, height: family == .systemLarge ? 6 : 4)
                    }
                    Spacer()
                    HStack {
                        Circle()
                            .fill(Color(red: 0.8, green: 0.8, blue: 0.8).opacity(0.25))
                            .frame(width: family == .systemLarge ? 5 : 3, height: family == .systemLarge ? 5 : 3)
                        Spacer()
                        Circle()
                            .fill(Color(red: 0.7, green: 0.7, blue: 0.7).opacity(0.3))
                            .frame(width: family == .systemLarge ? 7 : 5, height: family == .systemLarge ? 7 : 5)
                    }
                }
                .padding()
            }
            
        case .temple:
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.93, green: 0.90, blue: 0.85),
                        Color(red: 0.85, green: 0.82, blue: 0.75)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                
                // Temple pattern
                VStack {
                    HStack {
                        Text("🏛️")
                            .font(.system(size: family == .systemLarge ? 30 : 25))
                            .opacity(0.4)
                        Spacer()
                    }
                    Spacer()
                    HStack {
                        Spacer()
                        Text("🏛️")
                            .font(.system(size: family == .systemLarge ? 25 : 20))
                            .opacity(0.3)
                    }
                }
                .padding()
            }
            
        case .nature:
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.92, green: 0.95, blue: 0.88),
                        Color(red: 0.85, green: 0.90, blue: 0.80)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                
                // Nature pattern
                VStack {
                    HStack {
                        Text("🌿")
                            .font(.system(size: family == .systemLarge ? 20 : 15))
                            .opacity(0.4)
                        Spacer()
                        Text("🌿")
                            .font(.system(size: family == .systemLarge ? 15 : 12))
                            .opacity(0.3)
                    }
                    Spacer()
                    HStack {
                        Text("🌿")
                            .font(.system(size: family == .systemLarge ? 18 : 14))
                            .opacity(0.35)
                        Spacer()
                        Text("🌿")
                            .font(.system(size: family == .systemLarge ? 16 : 13))
                            .opacity(0.3)
                    }
                }
                .padding()
            }
            
        case .background01, .background02, .background03, .background04, .background05:
            ZStack {
                Image(style.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipped()
                
                // Dark overlay for better text readability
                Color.black.opacity(0.3)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

            }
        }
    }
}

struct BuddaWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .center) {
                // Dynamic background based on configuration
                BackgroundView(style: entry.configuration.backgroundStyle, family: family)
                    .padding(.horizontal, 0)
                    .frame(width: geo.size.width, height: geo.size.height)
                
                VStack(spacing: family == .systemLarge ? 16 : 12) {
                    // Buddha symbol or lotus
                    Text("🪷")
                        .font(.system(size: family == .systemLarge ? 40 : 30))
                        .opacity(0.8)
                    
                    // Display quotes based on widget size
                    if family == .systemLarge && entry.quotes.count > 1 {
                        // Large widget: show 2 quotes
                        VStack(spacing: 32) {
                            ForEach(Array(entry.quotes.enumerated()), id: \.offset) { index, quote in
                                VStack(spacing: 12) {
                                    Text(quote.quote)
                                        .font(.system(size: 14, weight: .medium, design: .serif))
                                        .foregroundColor(textColorForBackground(entry.configuration.backgroundStyle))
                                        .multilineTextAlignment(.center)
                                        .lineLimit(3)
                                    
                                    Text(quote.source)
                                        .font(.system(size: 10, weight: .light))
                                        .foregroundColor(sourceTextColorForBackground(entry.configuration.backgroundStyle))
                                        .italic()
                                }
                                .padding(.horizontal, 16)
                            }
                        }
                    } else {
                        // Medium widget: show 1 quote
                        VStack(spacing: 12) {
                            Text(entry.quotes.first?.quote ?? "")
                                .font(.system(size: family == .systemLarge ? 16 : 14, weight: .medium, design: .serif))
                                .foregroundColor(textColorForBackground(entry.configuration.backgroundStyle))
                                .multilineTextAlignment(.center)
                                .lineLimit(family == .systemLarge ? 8 : 6)
                                .padding(.horizontal, family == .systemLarge ? 20 : 16)
                            
                            Text(entry.quotes.first?.source ?? "")
                                .font(.system(size: family == .systemLarge ? 12 : 10, weight: .light))
                                .foregroundColor(sourceTextColorForBackground(entry.configuration.backgroundStyle))
                                .italic()
                                .padding(.horizontal, family == .systemLarge ? 20 : 16)
                        }
                    }
                    
                    Spacer()
                }
                .padding(.vertical, family == .systemLarge ? 20 : 16)

            }
            .frame(width: geo.size.width, height: geo.size.height)

        }
    
        .padding(.horizontal, 0)
        .widgetBackground(Color.black)
    }
    
    private func textColorForBackground(_ style: BackgroundStyle) -> Color {
        switch style {
        case .gradient, .lotus, .zen, .temple, .nature:
            return Color(red: 0.2, green: 0.2, blue: 0.2)
        default:
            return .white
        }
    }
    
    private func sourceTextColorForBackground(_ style: BackgroundStyle) -> Color {
        switch style {
        case .gradient, .lotus, .zen, .temple, .nature:
            return Color(red: 0.4, green: 0.4, blue: 0.4)
        default:
            return .white
        }
    }
}

struct BuddaWidget: Widget {
    let kind: String = "BuddaWidget"

    var body: some WidgetConfiguration {
            AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
                BuddaWidgetEntryView(entry: entry)
            }
            .contentMarginsDisabled()
            .configurationDisplayName("Buddha Quotes")
            .description("Daily wisdom from Buddha's teachings")
            .supportedFamilies([.systemMedium, .systemLarge])
       
    }
}

#Preview(as: .systemMedium) {
    BuddaWidget()
} timeline: {
    QuoteEntry(date: .now, quotes: [BuddhaQuote(quote: "Mind precedes all things; mind is their chief.", source: "Dhammapada 1")], configuration: ConfigurationAppIntent())
    QuoteEntry(date: .now, quotes: [BuddhaQuote(quote: "If one speaks or acts with a pure mind, happiness follows like a shadow.", source: "Dhammapada 2")], configuration: ConfigurationAppIntent())
}

#Preview(as: .systemLarge) {
    BuddaWidget()
} timeline: {
    QuoteEntry(date: .now, quotes: [
        BuddhaQuote(quote: "Hatred is never appeased by hatred; by non‑hatred alone is hatred appeased.", source: "Dhammapada 5"),
        BuddhaQuote(quote: "Better than a thousand hollow words is a single word that brings peace.", source: "Dhammapada 100")
    ], configuration: ConfigurationAppIntent())
}


extension View {
    func widgetBackground(_ backgroundView: some View) -> some View {
        if #available(iOSApplicationExtension 17.0, *) {
            return containerBackground(for: .widget) {
                backgroundView
            }
        } else {
            return background(backgroundView)
        }
    }
}
