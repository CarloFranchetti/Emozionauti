//
//  ParentDashboardView.swift
//  Emozionauti
//
//  Created by Studente on 4/07/25.
//

import SwiftUI

struct ParentDashboardView: View {
    @EnvironmentObject var navManager: NavigationManager
    @EnvironmentObject var diaryViewModel: DiaryViewModel
    @EnvironmentObject var drawings: DrawingModel
    @State private var showResetDrawingsAlert = false
    @State private var showResetEmotionsAlert = false

    var body: some View {
        List {
            Section(header: Text("Strumenti")) {
                Button {
                    navManager.currentView = .diary
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
                    navManager.currentView = .notificationSettings
                } label: {
                    Label("Gestione Notifiche", systemImage: "bell.badge")
                        .foregroundColor(.blue)
                }
                
                Button {
                    navManager.currentView = .animationManager
                } label: {
                    Label("Gestione Animazioni", systemImage: "video")
                        .foregroundColor(.blue)
                }
            }

            Section(header: Text("Azioni")) {
                Button {
                    showResetEmotionsAlert = true
                } label: {
                    Label("Reset emozioni", systemImage: "trash.fill")
                        .foregroundColor(.red)
                }
                .alert("Sei sicuro di voler resettare le emozioni?", isPresented: $showResetEmotionsAlert){
                    Button("Cancella", role: .cancel){}
                    Button("OK", role: .destructive){diaryViewModel.resetStats()}
                }
                
                Button {
                    showResetDrawingsAlert = true
                    
                } label: {
                    Label("Resetta disegni", systemImage: "eraser")
                        .foregroundColor(.red)
                }
                .alert("Sei sicuro di voler resettare i disegni?", isPresented: $showResetDrawingsAlert){
                    Button("Cancella", role: .cancel){}
                    Button("OK", role: .destructive){drawings.resetDrawings()}
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
