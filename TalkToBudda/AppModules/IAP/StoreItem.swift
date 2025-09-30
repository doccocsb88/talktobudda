//
//  StoreItem.swift
//  TalkToBudda
//
//  Created by mac on 15/5/25.
//


enum StoreItem: Int, Codable, CaseIterable {
    case karma = 0, weekly1, weeklytrial1, monthly1, monthly2
    
    var productId: String {
        switch self {
        case .karma:
            return "hai.codetu.TalkToBudda.1karma"
        case .weekly1:
            return "hai.codetu.TalkToBudda.weekly1"
        case .weeklytrial1:
            return "hai.codetu.TalkToBudda.weeklytrial1"
        case .monthly1:
            return "hai.codetu.TalkToBudda.monthly1"
        case .monthly2:
            return "hai.codetu.TalkToBudda.monthly2"
        }
    }
    
    var itemType: ItemType {
        switch self {
        case .karma:
            return .consumable
        case .weeklytrial1:
            return .trial
        default:
            return .nontrial
        }
    }
    
    var title: String {
        switch self {
        case .karma:
            return ""
        case .weekly1:
            return "Weekly"
        case .weeklytrial1:
            return "Weekly Trial"
        case .monthly1:
            return "Monthly"
        case .monthly2:
            return "Monthly"
        }
    }
}

struct StoreConfig: Codable {
    
}


enum ItemType: Codable {
    case trial
    case nontrial
    case consumable
}
