import Foundation
import SwiftUI

class DiaryViewModel: ObservableObject {
    @Published var emotionHistory: [String] = []

    init() {
        loadEmotionHistory()
    }

    func recordEmotion(_ emotion: String) {
        emotionHistory.append(emotion)
        saveEmotionHistory()
    }

    func emotionStats() -> [String: Int] {
        Dictionary(grouping: emotionHistory, by: { $0 })
            .mapValues { $0.count }
    }

    func resetStats() {
        emotionHistory.removeAll()
        saveEmotionHistory()
    }

    private func saveEmotionHistory() {
        UserDefaults.standard.set(emotionHistory, forKey: "EmotionHistory")
    }

    private func loadEmotionHistory() {
        if let saved = UserDefaults.standard.array(forKey: "EmotionHistory") as? [String] {
            emotionHistory = saved
        }
    }
}


