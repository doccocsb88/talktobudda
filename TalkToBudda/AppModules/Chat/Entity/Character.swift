//
//  Character.swift
//  TalkToBudda
//
//  Created by mac on 6/5/25.
//

import UIKit
import RealmSwift

enum CharacterType: String, Codable, PersistableEnum, CaseIterable {
    case buddha = "buddha"
    case monk = "monk"
    case zenMaster = "zen_master"
    case meditationGuide = "meditation_guide"
    case spiritualTeacher = "spiritual_teacher"
    case jesus = "jesus"
    case mary = "mary"
    case wisePhilosopher = "wise_philosopher"
    case marcusAurelius = "marcus_aurelius"
    case socrates = "socrates"
    
    var displayName: String {
        switch self {
        case .buddha:
            return "Buddha"
        case .monk:
            return "Wise Monk"
        case .zenMaster:
            return "Zen Master"
        case .meditationGuide:
            return "Meditation Guide"
        case .spiritualTeacher:
            return "Spiritual Teacher"
        case .jesus:
            return "Jesus"
        case .mary:
            return "Mary"
        case .wisePhilosopher:
            return "Wise Philosopher"
        case .marcusAurelius:
            return "Marcus Aurelius"
        case .socrates:
            return "Socrates"
        }
    }
    
    var description: String {
        switch self {
        case .buddha:
            return "Gentle guidance for calm, balance, and mindfulness"
        case .monk:
            return "Quiet spiritual insight for patience, faith, and inner peace"
        case .zenMaster:
            return "Mindful perspective for presence, simplicity, and Zen reflection"
        case .meditationGuide:
            return "Steady support for meditation, breathing, and daily calm"
        case .spiritualTeacher:
            return "Thoughtful guidance on meaning, growth, and spiritual practice"
        case .jesus:
            return "A compassionate voice of love, forgiveness, and gentle guidance"
        case .mary:
            return "A nurturing presence offering comfort, care, and reassurance"
        case .wisePhilosopher:
            return "Ancient philosophical wisdom through stories, balance, and virtue"
        case .marcusAurelius:
            return "Stoic wisdom for facing adversity with courage and discipline"
        case .socrates:
            return "Questions that help you examine assumptions and think clearly"
        }
    }

    var bestForLabel: String {
        switch self {
        case .buddha:
            return "Best for calm reflection"
        case .monk:
            return "Best for daily discipline"
        case .zenMaster:
            return "Best for deep presence"
        case .meditationGuide:
            return "Best for guided practice"
        case .spiritualTeacher:
            return "Best for life direction"
        case .jesus:
            return "Best for forgiveness and faith"
        case .mary:
            return "Best for comfort and reassurance"
        case .wisePhilosopher:
            return "Best for thoughtful perspective"
        case .marcusAurelius:
            return "Best for resilience and control"
        case .socrates:
            return "Best for hard questions"
        }
    }

    var chatSubtitle: String {
        switch self {
        case .buddha:
            return "Mindfulness guide"
        case .monk:
            return "Monastic guide"
        case .zenMaster:
            return "Zen guide"
        case .meditationGuide:
            return "Meditation coach"
        case .spiritualTeacher:
            return "Spiritual guide"
        case .jesus:
            return "Faith guide"
        case .mary:
            return "Comforting guide"
        case .wisePhilosopher:
            return "Philosophy guide"
        case .marcusAurelius:
            return "Stoic guide"
        case .socrates:
            return "Questioning guide"
        }
    }

    var handoffSummary: String {
        switch self {
        case .buddha:
            return "Best when you want calm reflection, balance, and a softer pace of thought."
        case .monk:
            return "Best when you want steady habits, grounded perspective, and disciplined next steps."
        case .zenMaster:
            return "Best when you want direct perspective, fewer words, and deeper presence."
        case .meditationGuide:
            return "Best when you want practical exercises, breathing support, and guided calm."
        case .spiritualTeacher:
            return "Best when you want meaning, encouragement, and spiritual direction across life questions."
        case .jesus:
            return "Best when you want guidance rooted in love, forgiveness, faith, and mercy."
        case .mary:
            return "Best when you want reassurance, tenderness, and gentle steps through emotional pain."
        case .wisePhilosopher:
            return "Best when you want broader perspective, reflection, and wisdom through ideas."
        case .marcusAurelius:
            return "Best when you want resilience, self-command, and calm action under pressure."
        case .socrates:
            return "Best when you want sharper questions, self-examination, and clearer thinking."
        }
    }

    var featuredCardSubtitle: String {
        switch self {
        case .buddha:
            return "See things with new eyes"
        case .monk:
            return "Strengthen daily habits and focus"
        case .zenMaster:
            return "Explore deeper wisdom within"
        case .meditationGuide:
            return "Return to breath with steady guidance"
        case .spiritualTeacher:
            return "Reflect on meaning with grounded support"
        case .jesus:
            return "Lean into love, mercy, and forgiveness"
        case .mary:
            return "Receive comfort, care, and reassurance"
        case .wisePhilosopher:
            return "Broaden perspective through timeless ideas"
        case .marcusAurelius:
            return "Practice resilience and self-command"
        case .socrates:
            return "Question assumptions and think more clearly"
        }
    }
    
    var avatarImageName: String {
        switch self {
        case .buddha:
            return "ic-budda-02"//"buddha_avatar"
        case .monk:
            return "monk_avatar"
        case .zenMaster:
            return "zen_master_avatar"
        case .meditationGuide:
            return "meditation_guide_avatar"
        case .spiritualTeacher:
            return "spiritual_teacher_avatar"
        case .jesus:
            return "jesus_avatar"
        case .mary:
            return "mary_avatar"
        case .wisePhilosopher:
            return "wise_philosopher_avatar"
        case .marcusAurelius:
            return "marcus_aurelius_avatar"
        case .socrates:
            return "socrates_avatar"
        }
    }
    
    var greetingMessage: String {
        switch self {
        case .buddha:
            return "Welcome, seeker of wisdom. I am here to guide you on your path to enlightenment."
        case .monk:
            return "Greetings, fellow traveler. Let us walk the path of wisdom together."
        case .zenMaster:
            return "In this moment, we meet. What wisdom do you seek?"
        case .meditationGuide:
            return "Hello, I'm here to help you find peace and clarity through meditation."
        case .spiritualTeacher:
            return "Welcome, dear soul. I'm here to share spiritual insights and guidance."
        case .jesus:
            return "Peace be with you. Let us walk with love, forgiveness, and a gentler heart."
        case .mary:
            return "You are not alone. Share what weighs on your heart, and let us seek comfort together."
        case .wisePhilosopher:
            return "Greetings. Let us look at your question through the old wisdom of balance, virtue, and the way of nature."
        case .marcusAurelius:
            return "I am Marcus Aurelius. Let us face this moment with reason, discipline, and attention to what is within your control."
        case .socrates:
            return "I am Socrates. Rather than rush to an answer, let us question carefully until the truth becomes clearer."
        }
    }

    var avatarSymbolName: String {
        switch self {
        case .buddha:
            return "sun.max"
        case .monk:
            return "figure.walk"
        case .zenMaster:
            return "torii.gate"
        case .meditationGuide:
            return "flame"
        case .spiritualTeacher:
            return "book"
        case .jesus:
            return "heart"
        case .mary:
            return "moon.stars"
        case .wisePhilosopher:
            return "leaf"
        case .marcusAurelius:
            return "shield"
        case .socrates:
            return "bubble.left.and.bubble.right"
        }
    }

    var avatarInitials: String {
        switch self {
        case .buddha:
            return "B"
        case .monk:
            return "WM"
        case .zenMaster:
            return "ZM"
        case .meditationGuide:
            return "MG"
        case .spiritualTeacher:
            return "ST"
        case .jesus:
            return "J"
        case .mary:
            return "M"
        case .wisePhilosopher:
            return "WP"
        case .marcusAurelius:
            return "MA"
        case .socrates:
            return "S"
        }
    }

    var avatarPalette: [UIColor] {
        switch self {
        case .buddha:
            return [UIColor(hexString: "#E8C98C"), UIColor(hexString: "#C9954D")]
        case .monk:
            return [UIColor(hexString: "#DDB980"), UIColor(hexString: "#A86C3A")]
        case .zenMaster:
            return [UIColor(hexString: "#D3C1A4"), UIColor(hexString: "#8F6A43")]
        case .meditationGuide:
            return [UIColor(hexString: "#E3D2B2"), UIColor(hexString: "#C49B63")]
        case .spiritualTeacher:
            return [UIColor(hexString: "#DCC6A3"), UIColor(hexString: "#A37B43")]
        case .jesus:
            return [UIColor(hexString: "#D9B7A0"), UIColor(hexString: "#A66B58")]
        case .mary:
            return [UIColor(hexString: "#C9D4E4"), UIColor(hexString: "#8B99B8")]
        case .wisePhilosopher:
            return [UIColor(hexString: "#CFD7B1"), UIColor(hexString: "#7E9461")]
        case .marcusAurelius:
            return [UIColor(hexString: "#CDBE8F"), UIColor(hexString: "#8C7A46")]
        case .socrates:
            return [UIColor(hexString: "#D8C6BA"), UIColor(hexString: "#8F6A59")]
        }
    }

    var avatarImage: UIImage {
        if let image = UIImage(named: avatarImageName) {
            return image
        }
        return Self.makeGeneratedAvatar(
            initials: avatarInitials,
            symbolName: avatarSymbolName,
            colors: avatarPalette
        )
    }

    private static func makeGeneratedAvatar(initials: String, symbolName: String, colors: [UIColor]) -> UIImage {
        let size = CGSize(width: 120, height: 120)
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            let rect = CGRect(origin: .zero, size: size)
            let cgColors = colors.map(\.cgColor) as CFArray
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let locations: [CGFloat] = [0, 1]
            let gradient = CGGradient(colorsSpace: colorSpace, colors: cgColors, locations: locations)

            context.cgContext.saveGState()
            let circlePath = UIBezierPath(ovalIn: rect)
            circlePath.addClip()
            if let gradient {
                context.cgContext.drawLinearGradient(
                    gradient,
                    start: CGPoint(x: 0, y: 0),
                    end: CGPoint(x: size.width, y: size.height),
                    options: []
                )
            }

            UIColor.white.withAlphaComponent(0.18).setFill()
            context.cgContext.fillEllipse(in: CGRect(x: 14, y: 12, width: 48, height: 34))
            UIColor.black.withAlphaComponent(0.06).setStroke()
            context.cgContext.setLineWidth(2)
            context.cgContext.strokeEllipse(in: rect.insetBy(dx: 2, dy: 2))
            context.cgContext.restoreGState()

            let symbolConfig = UIImage.SymbolConfiguration(pointSize: 32, weight: .medium)
            if let symbol = UIImage(systemName: symbolName, withConfiguration: symbolConfig)?
                .withTintColor(.white.withAlphaComponent(0.88), renderingMode: .alwaysOriginal) {
                let symbolRect = CGRect(x: 44, y: 26, width: 32, height: 32)
                symbol.draw(in: symbolRect)
            }

            let paragraph = NSMutableParagraphStyle()
            paragraph.alignment = .center
            let attributes: [NSAttributedString.Key: Any] = [
                .font: FontFamily.PlayfairDisplay.bold.font(size: 28),
                .foregroundColor: UIColor.white,
                .paragraphStyle: paragraph
            ]
            let textRect = CGRect(x: 12, y: 68, width: 96, height: 34)
            initials.draw(in: textRect, withAttributes: attributes)
        }
    }
}

struct Character: Codable {
    let type: CharacterType
    let name: String
    let description: String
    let avatarImageName: String
    
    init(type: CharacterType) {
        self.type = type
        self.name = type.displayName
        self.description = type.description
        self.avatarImageName = type.avatarImageName
    }
    
    
    var greetingMessage: String {
        return type.greetingMessage
    }

    var avatarImage: UIImage {
        return type.avatarImage
    }

    var bestForLabel: String {
        return type.bestForLabel
    }

    var chatSubtitle: String {
        return type.chatSubtitle
    }

    var handoffSummary: String {
        return type.handoffSummary
    }

    var featuredCardSubtitle: String {
        return type.featuredCardSubtitle
    }
}
