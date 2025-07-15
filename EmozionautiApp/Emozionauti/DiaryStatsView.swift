import SwiftUI

struct DiaryStatsView: View {
    @EnvironmentObject var diaryViewModel: DiaryViewModel
    
    var body: some View {
        VStack {
            if diaryViewModel.emotionHistory.isEmpty {
                Text("Nessuna emozione registrata.")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List {
                    ForEach(diaryViewModel.emotionStats().sorted(by: { $0.value > $1.value }), id: \.key) { emotion, count in
                        HStack {
                            Text(emotion)
                            Spacer()
                            Text("\(count) volte")
                                .foregroundColor(.gray)
                        }
                    }
                }
                .foregroundColor(.red)
                .padding(.top)
            }
        }
        .navigationTitle("Statistiche Emozioni")
    }
}
