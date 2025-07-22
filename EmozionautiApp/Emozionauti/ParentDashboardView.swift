import SwiftUI

struct ParentDashboardView: View {
    @EnvironmentObject var navManager: NavigationManager
    @EnvironmentObject var diaryViewModel: DiaryViewModel
    @EnvironmentObject var disegni: DisegniModel
    @State private var showResetAlert = false
    @State private var showResetDisegniAlert = false

    var body: some View {
        List {
            Section(header: Text("Strumenti")) {
                Button {
                    navManager.currentView = .diario
                } label: {
                    Label("Statistiche Emozioni", systemImage: "chart.bar.fill")
                }
                
                Button {
                    navManager.currentView = .gallery
                } label: {
                    Label("Galleria", systemImage: "arrow.backward.circle")
                        .foregroundColor(.blue)
                }
            }

            Section {
                Button {
                    diaryViewModel.resetStats()
                    showResetAlert = true
                } label: {
                    Label("Reset emozioni", systemImage: "trash.fill")
                        .foregroundColor(.red)
                }
                
                Button {
                    showResetDisegniAlert = true
                    
                } label: {
                    Label("Resetta disegni", systemImage: "x.circle.fill")
                        .foregroundColor(.red)
                }
                .alert("Sei sicuro di voler resettare i disegni?", isPresented: $showResetDisegniAlert){
                    Button("Cancella", role: .cancel){}
                    Button("OK", role: .destructive){disegni.resettaDisegni()}
                }

                Button {
                    navManager.currentView = .home
                } label: {
                    Label("Torna al menu principale", systemImage: "arrow.backward.circle")
                        .foregroundColor(.red)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Area Genitori")
        .alert("Emozioni resettate correttamente", isPresented: $showResetAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}
