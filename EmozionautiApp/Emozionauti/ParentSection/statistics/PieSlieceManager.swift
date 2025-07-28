//
//  PieSliceManager.swift
//  Emozionauti
//
//  Created by Studente on 10/07/25.
//

import Foundation
import SwiftUI

let emotionColors: [String: Color] = [
    "felicita": Color(red:12/255,green:165/255,blue:7/255),
    "rabbia": Color(red:202/255,green:37/255,blue:22/255),
    "paura": Color(red:125/255,green:27/255,blue:191/255),
    "tristezza": Color(red:19/255,green:43/255,blue:137/255),
    "noia": Color(red:171/255,green:173/255,blue:171/255)
]

struct PieSliceData {
    var startAngle: Angle
    var endAngle: Angle
    var color: Color
}

struct PieSliceView: View {
    var pieSliceData: PieSliceData

    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let rect = geometry.frame(in: .local)
                let center = CGPoint(x: rect.midX, y: rect.midY)
                let radius = min(rect.width, rect.height) / 2

                path.move(to: center)
                path.addArc(
                    center: center,
                    radius: radius,
                    startAngle: pieSliceData.startAngle,
                    endAngle: pieSliceData.endAngle,
                    clockwise: false
                )
            }
            .fill(pieSliceData.color)
        }
    }
}

struct EmotionPieChartView: View {
    let emotionStats: [String: Int]
    let emotionColors: [String: Color]
    @Binding var trigger: Bool

    private var total: Double {
        Double(emotionStats.values.reduce(0, +))
    }

    private var slices: [PieSliceData] {
        var result: [PieSliceData] = []
        var startAngle = Angle(degrees: 0)

        for (emotion, count) in emotionStats {
            let percentage = Double(count) / total
            let angle = percentage * 360
            let endAngle = startAngle + Angle(degrees: angle)

            result.append(PieSliceData(
                startAngle: startAngle,
                endAngle: endAngle,
                color: emotionColors[emotion] ?? .gray
            ))

            startAngle = endAngle
        }

        return result
    }

    var body: some View {
        ZStack {
            ForEach(0..<slices.count, id: \.self) { index in
                PieSliceView(pieSliceData: slices[index])
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .frame(width: 200, height: 200)
    }
}
