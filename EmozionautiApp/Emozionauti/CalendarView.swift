
import SwiftUI

struct CalendarView: View {
    @Binding var selectedDate: Date
    @EnvironmentObject var diaryViewModel: DiaryViewModel

    @State private var currentMonthOffset: Int = 0
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)

    private var displayedMonth: Date {
        Calendar.current.date(byAdding: .month, value: currentMonthOffset, to: Date()) ?? Date()
    }

    private var monthYearTitle: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL yyyy"
        return formatter.string(from: displayedMonth).capitalized
    }

    private var daysInDisplayedMonth: [Date] {
        let calendar = Calendar.current
        guard let range = calendar.range(of: .day, in: .month, for: displayedMonth),
              let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: displayedMonth)) else {
            return []
        }

        return range.compactMap { day in
            calendar.date(byAdding: .day, value: day - 1, to: startOfMonth)
        }
    }

    private var daysWithEmotions: Set<Date> {
        Set(diaryViewModel.emotionHistory.map {
            Calendar.current.startOfDay(for: $0.date)
        })
    }
    
    let emotionColors: [String: Color] = [
        "felicita": Color(red:12/255,green:165/255,blue:7/255),
        "rabbia": Color(red:202/255,green:37/255,blue:22/255),
        "paura": Color(red:125/255,green:27/255,blue:191/255),
        "tristezza": Color(red:19/255,green:43/255,blue:137/255),
        "noia": Color(red:171/255,green:173/255,blue:171/255)
    ]
    
    let emotionImages: [String: Image] = [
        "felicita": Image("felicita"),
        "rabbia": Image("rabbia"),
        "paura": Image("paura"),
        "tristezza": Image("tristezza"),
        "noia": Image("noia")
    ]
    
    func heatmapColor(for intensity: Double) -> Color {
        switch intensity {
        case 0..<0.3:
            return Color.green.opacity(0.3)
        case 0.3..<0.6:
            return Color.orange.opacity(0.5)
        case 0.6...:
            return Color.red.opacity(0.6)
        default:
            return .clear
        }
    }
    
    var body: some View {
        VStack(spacing: 16) {
            //Header con mese corrente e frecce
            HStack {
                Button(action: {
                    currentMonthOffset -= 1
                }) {
                    Image(systemName: "chevron.left")
                }

                Spacer()

                Text(monthYearTitle)
                    .font(.headline)

                Spacer()

                Button(action: {
                    currentMonthOffset += 1
                }) {
                    Image(systemName: "chevron.right")
                }
            }
            .padding(.horizontal)

            //Giorni della settimana
            HStack {
                ForEach(["Lun", "Mar", "Mer", "Gio", "Ven", "Sab", "Dom"], id: \.self) { day in
                    Text(day)
                        .font(.caption)
                        .frame(maxWidth: .infinity)
                }
            }

            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(daysInDisplayedMonth, id: \.self) { date in
                    let isSelected = Calendar.current.isDate(date, inSameDayAs: selectedDate)
                    let hasEmotion = daysWithEmotions.contains(Calendar.current.startOfDay(for: date))
                    let isToday = Calendar.current.isDateInToday(date)
                    let emotions = Array(Set(diaryViewModel.emotionsForDate(date))).prefix(5)
                    let intensity = diaryViewModel.emotionIntensity(for: date)
                    let heatColor = heatmapColor(for: intensity)

                    Button {
                        selectedDate = date
                    } label: {
                        CalendarDayCell(
                            date: date,
                            isSelected: isSelected,
                            isToday: isToday,
                            hasEmotion: hasEmotion,
                            emotions: Array(emotions),
                            emotionImage: emotionImages,
                            intensity: intensity,
                            heatmapColor: heatColor
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .padding()
    }
    
    struct CalendarDayCell: View {
        let date: Date
        let isSelected: Bool
        let isToday: Bool
        let hasEmotion: Bool
        let emotions: [String]
        let emotionImage: [String: Image]
        let intensity: Double
        let heatmapColor: Color

        var body: some View {
            VStack(spacing: 4) {
                if !emotions.isEmpty {
                    HStack(spacing: 2) {
                        ForEach(emotions, id: \.self) { emotion in
                            (emotionImage[emotion] ?? Image(systemName: "questionmark"))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 10, height: 10)
                        }
                    }
                }

                Text("\(Calendar.current.component(.day, from: date))")
                    .font(.system(size: 16, weight: .bold))
                    .frame(width: 36, height: 36)
                    .background(
                        ZStack {
                            if isSelected {
                                Color.blue.opacity(0.8).clipShape(Circle())
                            } else if intensity > 0 {
                                Circle().fill(heatmapColor)
                            }

                            if isToday {
                                Circle().stroke(Color.blue, lineWidth: 2)
                            }
                        }
                    )
                    .foregroundColor(hasEmotion ? .primary : .gray)

                if hasEmotion {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 6, height: 6)
                }
            }
        }
    }
}
