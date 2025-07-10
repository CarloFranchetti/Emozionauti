import SwiftUI

struct ParentDashboardView: View {
    @EnvironmentObject var navManager: NavigationManager

    var body: some View {
        List {
            Section(header: Text("Strumenti")) {
                Button {
                    navManager.currentView = .diario
                } label: {
                    Label("Statistiche Emozioni", systemImage: "chart.bar.fill")
                }

                Button {
                    navManager.currentView = .settings
                } label: {
                    Label("Impostazioni App", systemImage: "gearshape.fill")
                }
            }

            Section {
                Button {
                    navManager.currentView = .home
                } label: {
                    Label("Torna al menu principale", systemImage: "arrow.backward.circle")
                        .foregroundColor(.red)
                }
            }
        }
        .navigationTitle("Area Genitori")
    }
}
