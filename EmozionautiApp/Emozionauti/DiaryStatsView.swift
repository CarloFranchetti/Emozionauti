import SwiftUI

struct DiaryStatsView: View {
    @StateObject private var viewModel = DiaryViewModel()

    var body: some View {
        VStack {
            if viewModel.emotionHistory.isEmpty {
                Text("Nessuna emozione registrata.")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List {
                    ForEach(viewModel.emotionStats().sorted(by: { $0.value > $1.value }), id: \.key) { emotion, count in
                        HStack {
                            Text(emotion)
                            Spacer()
                            Text("\(count) volte")
                                .foregroundColor(.secondary)
                        }
                    }
                }

                Button("Resetta statistiche") {
                    viewModel.resetStats()
                }
                .foregroundColor(.red)
                .padding(.top)
            }
        }
        .navigationTitle("Statistiche Emozioni")
    }
}
