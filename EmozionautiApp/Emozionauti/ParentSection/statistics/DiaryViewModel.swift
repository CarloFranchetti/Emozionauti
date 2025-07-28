//
//  DiaryViewModel.swift
//  Emozionauti
//
//  Created by Studente on 10/07/25.
//

import Foundation
import SwiftUI
import Charts


struct EmotionCount: Identifiable {
    var id = UUID()
    var date: Date
    var count: Int
}

struct EmotionEntry: Identifiable {
    var id = UUID()
    var date: Date
    var emotion: String
    var count: Int
}

class DiaryViewModel: ObservableObject {
    @Published var emotionHistory: [(date: Date, emotion: String)] = []
    
    init() {
        loadEmotionHistory()
    }

    func recordEmotion(_ emotion: String) {
        let today = Calendar.current.startOfDay(for: Date())
        emotionHistory.append((date: today, emotion: emotion))
        saveEmotionHistory()
    }

    func emotionStats(for date: Date) -> [String: Int] {
        let day = Calendar.current.startOfDay(for: date)
        let emotionsForDate = emotionHistory
            .filter { Calendar.current.isDate($0.date, inSameDayAs: day) }
            .map { $0.emotion }
        return Dictionary(grouping: emotionsForDate, by: { $0 })
            .mapValues { $0.count }
    }

    func resetStats() {
        emotionHistory.removeAll()
        saveEmotionHistory()
    }

    private func saveEmotionHistory() {
        let data = emotionHistory.map { ["date": $0.date.timeIntervalSince1970, "emotion": $0.emotion] }
        UserDefaults.standard.set(data, forKey: "EmotionHistory")
    }

    private func loadEmotionHistory() {
        if let saved = UserDefaults.standard.array(forKey: "EmotionHistory") as? [[String: Any]] {
            self.emotionHistory = saved.compactMap {
                guard let time = $0["date"] as? TimeInterval,
                      let emotion = $0["emotion"] as? String else { return nil }
                return (date: Date(timeIntervalSince1970: time), emotion: emotion)
            }
        }
    }
    
    func emotionCountByDayThisWeek() -> [EmotionCount] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        var counts: [Date: Int] = [:]
        for dayOffset in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: -dayOffset, to: today) {
                counts[date] = 0
            }
        }
        for entry in emotionHistory {
            let entryDate = calendar.startOfDay(for: entry.date)
            if counts.keys.contains(entryDate) {
                counts[entryDate, default: 0] += 1
            }
        }
        return counts.map { EmotionCount(date: $0.key, count: $0.value) }
            .sorted { $0.date < $1.date }
    }
    
    func emotionCountByDayThisMonth() -> [EmotionCount] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: today))!
        var counts: [Date: Int] = [:]

        if let range = calendar.range(of: .day, in: .month, for: today) {
            for day in range {
                if let date = calendar.date(byAdding: .day, value: day - 1, to: startOfMonth) {
                    counts[date] = 0
                }
            }
        }

        for entry in emotionHistory {
            let day = calendar.startOfDay(for: entry.date)
            if calendar.isDate(day, equalTo: today, toGranularity: .month) {
                counts[day, default: 0] += 1
            }
        }

        return counts.map { EmotionCount(date: $0.key, count: $0.value) }
            .sorted { $0.date < $1.date }
    }
    
    func hasEmotion(on date: Date) -> Bool {
        let day = Calendar.current.startOfDay(for: date)
        return emotionHistory.contains { Calendar.current.isDate($0.date, inSameDayAs: day) }
    }
    
    func emotionsForDate(_ date: Date) -> [String] {
        let day = Calendar.current.startOfDay(for: date)
        return emotionHistory
            .filter { Calendar.current.isDate($0.date, inSameDayAs: day) }
            .map { $0.emotion }
    }
    
    func emotionEntriesGroupedByDay(weekly: Bool) -> [EmotionEntry] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        let startDate: Date
        if weekly {
            startDate = calendar.date(byAdding: .day, value: -6, to: today)!
        } else {
            startDate = calendar.date(byAdding: .month, value: -1, to: today)!
        }

        let filtered = emotionHistory.filter { $0.date >= startDate }

        let grouped = Dictionary(grouping: filtered) { entry in
            calendar.startOfDay(for: entry.date)
        }

        var result: [EmotionEntry] = []

        for (date, entries) in grouped {
            let counts = Dictionary(grouping: entries.map { $0.emotion }, by: { $0 }).mapValues { $0.count }

            for (emotion, count) in counts {
                result.append(EmotionEntry(date: date, emotion: emotion, count: count))
            }
        }

        return result.sorted { $0.date < $1.date }
    }
    
    func emotionIntensity(for date: Date) -> Double {
        let count = emotionStats(for: date).values.reduce(0, +)
        let maxCount = emotionHistory
            .map { Calendar.current.startOfDay(for: $0.date) }
            .reduce(into: [:]) { $0[$1, default: 0] += 1 }
            .values.max() ?? 1

        return Double(count) / Double(maxCount)
    }
}


