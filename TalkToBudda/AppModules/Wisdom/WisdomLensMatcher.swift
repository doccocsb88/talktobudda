//
//  WisdomLensMatcher.swift
//  TalkToBudda
//

import Foundation

struct WisdomLensMatcher {
    func recommendations(for situation: WisdomSituation) -> [WisdomLensRecommendation] {
        switch situation.id {
        case "anxious_after_work":
            return [
                WisdomLensRecommendation(character: .buddha, reason: "Buddha helps you soften attachment and meet stress with compassion."),
                WisdomLensRecommendation(character: .meditationGuide, reason: "Meditation Guide gives you a practical way to settle your breath and body."),
                WisdomLensRecommendation(character: .zenMaster, reason: "Zen Master brings you back to the present moment before the mind runs ahead.")
            ]
        case "hard_decision":
            return [
                WisdomLensRecommendation(character: .socrates, reason: "Socrates helps you question the assumption underneath the decision."),
                WisdomLensRecommendation(character: .marcusAurelius, reason: "Marcus focuses on what is under your control and what is not."),
                WisdomLensRecommendation(character: .wisePhilosopher, reason: "The Wise Philosopher looks for harmony, timing, and the deeper pattern.")
            ]
        case "relationship_struggle":
            return [
                WisdomLensRecommendation(character: .spiritualTeacher, reason: "Spiritual Teacher helps you respond with compassion instead of reaction."),
                WisdomLensRecommendation(character: .buddha, reason: "Buddha helps you see suffering on both sides with less clinging."),
                WisdomLensRecommendation(character: .socrates, reason: "Socrates helps you separate what you know from what you are assuming.")
            ]
        case "procrastination":
            return [
                WisdomLensRecommendation(character: .marcusAurelius, reason: "Marcus brings discipline back to the next action you can control."),
                WisdomLensRecommendation(character: .zenMaster, reason: "Zen Master cuts through overthinking and returns you to doing one thing now."),
                WisdomLensRecommendation(character: .wisePhilosopher, reason: "The Wise Philosopher helps you find a balanced path between effort and resistance.")
            ]
        case "calmer_perspective":
            return [
                WisdomLensRecommendation(character: .zenMaster, reason: "Zen Master helps you pause before turning a moment into a story."),
                WisdomLensRecommendation(character: .buddha, reason: "Buddha brings gentleness to the fear or frustration underneath."),
                WisdomLensRecommendation(character: .meditationGuide, reason: "Meditation Guide offers a grounding practice you can use immediately.")
            ]
        case "meaning":
            return [
                WisdomLensRecommendation(character: .wisePhilosopher, reason: "The Wise Philosopher looks at meaning through virtue, harmony, and time."),
                WisdomLensRecommendation(character: .spiritualTeacher, reason: "Spiritual Teacher helps you reconnect with values larger than the moment."),
                WisdomLensRecommendation(character: .socrates, reason: "Socrates helps you ask what a meaningful life would require from you.")
            ]
        case "discipline":
            return [
                WisdomLensRecommendation(character: .marcusAurelius, reason: "Marcus turns discipline into a calm duty, not self-punishment."),
                WisdomLensRecommendation(character: .zenMaster, reason: "Zen Master keeps the path simple: return to the next right action."),
                WisdomLensRecommendation(character: .buddha, reason: "Buddha helps you practice discipline without harshness or attachment.")
            ]
        default:
            return fallbackRecommendations()
        }
    }

    func fallbackRecommendations() -> [WisdomLensRecommendation] {
        [
            WisdomLensRecommendation(character: .buddha, reason: "Buddha brings calm, compassion, and a wider view of suffering."),
            WisdomLensRecommendation(character: .marcusAurelius, reason: "Marcus focuses on what you can control with discipline and courage."),
            WisdomLensRecommendation(character: .socrates, reason: "Socrates helps you clarify the question before chasing an answer.")
        ]
    }
}
