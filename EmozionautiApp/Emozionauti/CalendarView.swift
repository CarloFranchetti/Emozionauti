
import SwiftUI

struct CalendarView: View {
    @Binding var dataSelezionata: Date
    @EnvironmentObject var diaryViewModel: DiaryViewModel

    @State private var offsetMeseCorrente: Int = 0
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)

    private var meseMostrato: Date {
        Calendar.current.date(byAdding: .month, value: offsetMeseCorrente, to: Date()) ?? Date()
    }

    private var meseAnnoTitolo: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL yyyy"
        return formatter.string(from: meseMostrato).capitalized
    }

    private var giorniMeseMostrato: [Date] {
        let calendario = Calendar.current
        guard let range = calendario.range(of: .day, in: .month, for: meseMostrato),
              let inizioMese = calendario.date(from: calendario.dateComponents([.year, .month], from: meseMostrato)) else {
            return []
        }

        return range.compactMap { giorno in
            calendario.date(byAdding: .day, value: giorno - 1, to: inizioMese)
        }
    }

    private var daysWithEmotions: Set<Date> {
        Set(diaryViewModel.emotionHistory.map {
            Calendar.current.startOfDay(for: $0.date)
        })
    }
    
    let coloriEmozioni: [String: Color] = [
        "felicita": Color(red:12/255,green:165/255,blue:7/255),
        "rabbia": Color(red:202/255,green:37/255,blue:22/255),
        "paura": Color(red:125/255,green:27/255,blue:191/255),
        "tristezza": Color(red:19/255,green:43/255,blue:137/255),
        "noia": Color(red:171/255,green:173/255,blue:171/255)
    ]
    
    let immaginiEmozioni: [String: Image] = [
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
                    offsetMeseCorrente -= 1
                }) {
                    Image(systemName: "chevron.left")
                }

                Spacer()

                Text(meseAnnoTitolo)
                    .font(.headline)

                Spacer()

                Button(action: {
                    offsetMeseCorrente += 1
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
                ForEach(giorniMeseMostrato, id: \.self) { date in
                    let selezionato = Calendar.current.isDate(date, inSameDayAs: dataSelezionata)
                    let haEmozioni = daysWithEmotions.contains(Calendar.current.startOfDay(for: date))
                    let oggi = Calendar.current.isDateInToday(date)
                    let emozioni = Array(Set(diaryViewModel.emotionsForDate(date))).prefix(5)
                    let intensita = diaryViewModel.emotionIntensity(for: date)
                    let coloreHeat = heatmapColor(for: intensita)

                    Button {
                        dataSelezionata = date
                    } label: {
                        CalendarDayCell(
                            date: date,
                            selezionato: selezionato,
                            oggi: oggi,
                            haEmozioni: haEmozioni,
                            emozioni: Array(emozioni),
                            immaginiEmozioni: immaginiEmozioni,
                            intensita: intensita,
                            coloreHeatMap: coloreHeat
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
        let selezionato: Bool
        let oggi: Bool
        let haEmozioni: Bool
        let emozioni: [String]
        let immaginiEmozioni: [String: Image]
        let intensita: Double
        let coloreHeatMap: Color

        var body: some View {
            VStack(spacing: 4) {
                if !emozioni.isEmpty {
                    HStack(spacing: 2) {
                        ForEach(emozioni, id: \.self) { emozione in
                            (immaginiEmozioni[emozione] ?? Image(systemName: "questionmark"))
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
                            if selezionato {
                                Color.blue.opacity(0.8).clipShape(Circle())
                            } else if intensita > 0 {
                                Circle().fill(coloreHeatMap)
                            }

                            if oggi {
                                Circle().stroke(Color.blue, lineWidth: 2)
                            }
                        }
                    )
                    .foregroundColor(haEmozioni ? .primary : .gray)

                if haEmozioni {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 6, height: 6)
                }
            }
        }
    }
}
