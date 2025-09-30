//
//  Character.swift
//  TalkToBudda
//
//  Created by mac on 6/5/25.
//

import Foundation
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
            return "Chúa Jesus"
        case .mary:
            return "Đức Maria"
        case .wisePhilosopher:
            return "Nhà Hiền Triết"
        case .marcusAurelius:
            return "Marcus Aurelius"
        case .socrates:
            return "Socrates"
        }
    }
    
    var description: String {
        switch self {
        case .buddha:
            return "The enlightened one, sharing wisdom and compassion"
        case .monk:
            return "A devoted monk with deep spiritual insights"
        case .zenMaster:
            return "A master of Zen philosophy and mindfulness"
        case .meditationGuide:
            return "A gentle guide for your meditation journey"
        case .spiritualTeacher:
            return "A wise teacher of spiritual principles"
        case .jesus:
            return "Giọng văn yêu thương, tha thứ, khuyên bảo nhẹ nhàng"
        case .mary:
            return "Giọng mẫu tử, an ủi, vỗ về"
        case .wisePhilosopher:
            return "Giọng triết lý sâu sắc, dùng ngụ ngôn (Lão Tử, Khổng Tử)"
        case .marcusAurelius:
            return "Triết lý Stoicism, cách đối mặt nghịch cảnh"
        case .socrates:
            return "Phương pháp đặt câu hỏi để tự khai sáng"
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
            return "Chào con, Ta yêu thương con vô cùng. Hãy để Ta dẫn dắt con trên con đường của tình yêu và sự tha thứ."
        case .mary:
            return "Con yêu ơi, mẹ ở đây để an ủi và vỗ về con. Hãy chia sẻ những lo lắng của con với mẹ."
        case .wisePhilosopher:
            return "Xin chào, ta là nhà hiền triết. Hãy để ta chia sẻ những triết lý sâu sắc qua những câu chuyện ngụ ngôn."
        case .marcusAurelius:
            return "Chào bạn, tôi là Marcus Aurelius. Hãy cùng tôi học cách đối mặt với nghịch cảnh bằng triết lý Stoicism."
        case .socrates:
            return "Xin chào! Tôi là Socrates. Thay vì cho bạn câu trả lời, tôi sẽ đặt câu hỏi để bạn tự khám phá chân lý."
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
}
