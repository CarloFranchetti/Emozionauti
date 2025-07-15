import SwiftUI

struct ParentDashboardView: View {
    @EnvironmentObject var navManager: NavigationManager

    var body: some View {
        List {
            Section(header: Text("Strumenti")) {
                Button {
                    navManager.currentView = .diario
                }
                label: {
                    Label("Statistiche Emozioni", systemImage: "chart.bar.fill")
                }
            }

            Section {
                Button {
                    navManager.currentView = .home
                } label: {
                    Label("Reset emozioni", systemImage: "trash.fill")
                        .foregroundColor(.red)
                }

                Button {
                    navManager.currentView = .home
                } label: {
                    Label("Torna al menu principale", systemImage: "arrow.backward.circle")
                        .foregroundColor(.red)
                }
                
                Button {
                    navManager.currentView = .gallery
                } label: {
                    Label("Galleria", systemImage: "arrow.backward.circle")
                        .foregroundColor(.red)
                }
            }
        }
        .navigationTitle("Area Genitori")
    }
}
