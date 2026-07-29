//
//  ScriptureReadingProgressStore.swift
//  TalkToBudda
//
//  Created by Codex on 29/7/26.
//

import Foundation

struct ScriptureReadingProgress: Codable, Equatable {
    let scriptureName: String
    let scriptureTitle: String
    let resourceTagRawValue: String
    var currentPage: Int
    var totalPages: Int
    var lastOpenedAt: Date

    var progressFraction: Double {
        guard totalPages > 0 else { return 0 }
        return min(max(Double(currentPage + 1) / Double(totalPages), 0), 1)
    }

    var progressPercentText: String {
        "\(Int((progressFraction * 100).rounded()))%"
    }

    var pageStatusText: String {
        guard totalPages > 0 else { return "Page \(currentPage + 1)" }
        return "Page \(currentPage + 1) of \(totalPages)"
    }
}

final class ScriptureReadingProgressStore {
    static let shared = ScriptureReadingProgressStore()

    private let storageKey = "ScriptureReadingProgressStore.records"

    private init() {}

    func allRecords() -> [ScriptureReadingProgress] {
        guard let data = UserDefaults.standard.data(forKey: storageKey),
              let records = try? JSONDecoder().decode([ScriptureReadingProgress].self, from: data) else {
            return []
        }

        return records.sorted { $0.lastOpenedAt > $1.lastOpenedAt }
    }

    func mostRecentRecord() -> ScriptureReadingProgress? {
        allRecords().first
    }

    func progress(for scripture: ScriptureEntity) -> ScriptureReadingProgress? {
        allRecords().first(where: { $0.scriptureName == scripture.name })
    }

    func saveProgress(for scripture: ScriptureEntity, currentPage: Int, totalPages: Int) {
        var records = allRecords()
        let record = ScriptureReadingProgress(
            scriptureName: scripture.name,
            scriptureTitle: scripture.shortDisplayTitle,
            resourceTagRawValue: scripture.resourceTag.rawValue,
            currentPage: max(currentPage, 0),
            totalPages: max(totalPages, 0),
            lastOpenedAt: Date()
        )

        if let index = records.firstIndex(where: { $0.scriptureName == scripture.name }) {
            records[index] = record
        } else {
            records.append(record)
        }

        persist(records)
    }

    private func persist(_ records: [ScriptureReadingProgress]) {
        guard let data = try? JSONEncoder().encode(records) else { return }
        UserDefaults.standard.set(data, forKey: storageKey)
    }
}
