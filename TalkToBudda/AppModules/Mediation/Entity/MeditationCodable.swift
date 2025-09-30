//
//  MeditationCodable.swift
//  TalkToBudda
//
//  Created by mac on 11/5/25.
//

struct MeditationCodable: Codable {
    let id: Int
    let name: String
    let purpose: String
    let method: String
    let benefits: String
    let how_to_practice: [String]
}
