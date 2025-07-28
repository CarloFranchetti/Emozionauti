//
//  MultiEmotionRingView.swift
//  Emozionauti
//
//  Created by Studente on 10/07/25.
//

import SwiftUI

struct MultiEmotionRingView: View {
    let emotionStats: [String: Int]
    let emotionColors: [String: Color]
    let emotionImages: [String: Image]
    let animate: Bool

    private var maxCount: Int {
        emotionStats.values.max() ?? 1
    }

    private var emotionKeys: [String] {
        Array(emotionStats.keys.sorted())
    }

    var body: some View {
        VStack(spacing: 16) {
            ForEach(emotionKeys, id: \.self) { emotion in
                SingleEmotionRingView(
                    emotion: emotion,
                    count: emotionStats[emotion] ?? 0,
                    maxCount: maxCount,
                    color: emotionColors[emotion] ?? .gray,
                    image: emotionImages[emotion] ?? Image(systemName: "questionmark.circle"),
                    animate: animate
                )
            }
        }
        .padding(.top)
    }
}
