import SwiftUI

struct ParentDashboardView: View {
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Strumenti")) {
                    NavigationLink(destination: DiaryStatsView()) {
                        Label("Statistiche Emozioni", systemImage: "chart.bar.fill")
                    }
                    NavigationLink(destination: SettingsView()) {
                        Label("Impostazioni App", systemImage: "gearshape.fill")
                    }
                }

                Section {
                    NavigationLink(destination: ParentAccessView()) {
                        Label("Esci", systemImage: "arrow.backward.circle")
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("Area Genitori")
        }
    }
}
