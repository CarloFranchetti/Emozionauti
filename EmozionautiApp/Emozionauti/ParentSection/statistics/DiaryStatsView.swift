//
//  DiaryStatsView.swift
//  Emozionauti
//
//  Created by Studente on 10/07/25.
//


import SwiftUI
import Charts

struct DiaryStatsView: View {
    @EnvironmentObject var diaryViewModel: DiaryViewModel
    @State private var selectedDate = Date()
    @State private var showWeeklyChart = true
    @State private var animateRings = false
    @State private var animatePie = false
    @State private var selectedEmotion: String? = nil

    let emotionImages: [String: Image] = [
        "anger": Image("Anger"),
        "fear": Image("Fear"),
        "happiness": Image("Happiness"),
        "sadness": Image("Sadness"),
        "boredom": Image("Boredom")
    ]
    
    let emotionColors: [String: Color] = [
        "happiness": Color(red:12/255,green:165/255,blue:7/255),
        "anger": Color(red:202/255,green:37/255,blue:22/255),
        "fear": Color(red:125/255,green:27/255,blue:191/255),
        "sadness": Color(red:19/255,green:43/255,blue:137/255),
        "boredom": Color(red:171/255,green:173/255,blue:171/255)
    ]

    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                Text("Calendario delle Emozioni")
                    .font(.title3)
                    .bold()
                    .padding(.top, 70)
                CalendarView(selectedDate: $selectedDate)
                    .environmentObject(diaryViewModel)
                    .frame(height: geo.size.height * 0.45)
                Divider()
                let stats = diaryViewModel.emotionStats(for: selectedDate)
                if stats.isEmpty {
                    Spacer()
                    Text("Nessuna emozione registrata per questa data.")
                        .foregroundColor(.gray)
                        .padding()
                    Spacer()
                } else {
                    Spacer()
                    HStack(alignment: .center, spacing: 24) {
                        EmotionPieChartView(
                            emotionStats: stats,
                            emotionColors: emotionColors,
                            trigger: $animatePie
                        )
                        .frame(width: 200, height: 200)
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(stats.sorted(by: { $0.value > $1.value }), id: \.key) { emotion, value in
                                let percentage = Double(value) / Double(stats.values.reduce(0, +)) * 100
                                HStack(spacing: 8) {
                                    Circle()
                                        .fill(emotionColors[emotion] ?? .gray)
                                        .frame(width: 10, height: 10)

                                    (emotionImages[emotion] ?? Image(systemName: "questionmark.circle"))
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20, height: 20)

                                    Text(String(format: "%.0f%%", percentage))
                                        .font(.subheadline)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    Spacer()
                    HStack(spacing: 24) {
                        ForEach(stats.sorted(by: { $0.key < $1.key }), id: \.key) { emotion in
                            let count = stats[emotion.key] ?? 0
                            let maxCount = stats.values.max() ?? 1
                            SingleEmotionRingView(
                                emotion: emotion.key,
                                count: count,
                                maxCount: maxCount,
                                color: emotionColors[emotion.key] ?? .gray,
                                image: emotionImages[emotion.key] ?? Image(systemName: "questionmark.circle"),
                                animate: animateRings
                            )
                            .frame(width: 80, height: 80)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 24)
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .onAppear {
                withAnimation {
                    animatePie = true
                    animateRings = true
                }
            }
            .onChange(of: selectedDate) { _ in
                animateRings = false
                animatePie = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    animateRings = true
                    animatePie = true
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Statistiche Emozioni")
                    .font(.system(size: 36, weight: .bold))
            }
        }
    }
}
