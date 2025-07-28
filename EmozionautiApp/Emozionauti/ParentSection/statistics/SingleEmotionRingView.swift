//
//  SingleEmotionRingView.swift
//  Emozionauti
//
//  Created by Studente on 10/07/25.
//

import SwiftUI

struct SingleEmotionRingView: View {
    let emotion: String
    let count: Int
    let maxCount: Int
    let color: Color
    let image: Image
    let animate: Bool

    var body: some View {
        ZStack {
            Circle()
                .stroke(color.opacity(0.3), lineWidth: 10)
            Circle()
                .trim(from: 0, to: animate ? CGFloat(count) / CGFloat(maxCount) : 0)
                .stroke(color, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.easeOut(duration: 0.6), value: animate)
            image
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
        }
    }
}
