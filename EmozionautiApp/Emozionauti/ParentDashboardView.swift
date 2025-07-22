import SwiftUI

struct ParentDashboardView: View {
    @EnvironmentObject var navManager: NavigationManager
    @EnvironmentObject var diaryViewModel: DiaryViewModel
    @EnvironmentObject var disegni: DisegniModel
    @State private var showResetDisegniAlert = false
    @State private var showResetEmozioniAlert = false

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
                    Label("Galleria", systemImage: "photo.stack")
                        .foregroundColor(.blue)
                }
                
                Button {
                    navManager.currentView = .gallery
                } label: {
                    Label("Gestione Notifiche", systemImage: "bell.badge")
                        .foregroundColor(.blue)
                }
            }

            Section {
                Button {
                    showResetEmozioniAlert = true
                } label: {
                    Label("Reset emozioni", systemImage: "trash.fill")
                        .foregroundColor(.red)
                }
                .alert("Sei sicuro di voler resettare le emozioni?", isPresented: $showResetEmozioniAlert){
                    Button("Cancella", role: .cancel){}
                    Button("OK", role: .destructive){diaryViewModel.resetStats()}
                }
                
                Button {
                    showResetEmozioniAlert = true
                    
                } label: {
                    Label("Resetta disegni", systemImage: "eraser")
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
    }
}
