//
//  WisdomSituation.swift
//  TalkToBudda
//

import Foundation

struct WisdomSituation: Equatable {
    let id: String
    let title: String
    let subtitle: String

    static let predefined: [WisdomSituation] = [
        WisdomSituation(
            id: "anxious_after_work",
            title: "I feel anxious after work",
            subtitle: "Find a calmer way to meet the day."
        ),
        WisdomSituation(
            id: "hard_decision",
            title: "I need to make a hard decision",
            subtitle: "See the choice from a steadier angle."
        ),
        WisdomSituation(
            id: "relationship_struggle",
            title: "I'm struggling in a relationship",
            subtitle: "Bring more compassion and clarity."
        ),
        WisdomSituation(
            id: "procrastination",
            title: "I keep procrastinating",
            subtitle: "Reconnect with discipline and action."
        ),
        WisdomSituation(
            id: "calmer_perspective",
            title: "I need a calmer perspective",
            subtitle: "Slow the mind before responding."
        ),
        WisdomSituation(
            id: "meaning",
            title: "I feel lost about meaning",
            subtitle: "Look for grounding beyond the moment."
        ),
        WisdomSituation(
            id: "discipline",
            title: "I need discipline",
            subtitle: "Focus on what is in your control."
        )
    ]
}

struct WisdomContext: Codable, Equatable {
    let situationId: String
    let situationTitle: String
    let matchReason: String
}
