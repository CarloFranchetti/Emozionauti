import SwiftUI
import AudioToolbox

struct Alien: Identifiable {
    let id = UUID()
    var imageName: String
    let happyItemImageName: String
}

struct HappyItem: Identifiable, Hashable {
    let id = UUID()
    let imageName: String
}

struct MinigiocoNoia: View {
    @EnvironmentObject var navManager: NavigationManager
    
    let totalMatches = 3
    
    @State private var aliens = [
        Alien(imageName: "AlienoController", happyItemImageName: "Controller"),
        Alien(imageName: "AlienoLibro", happyItemImageName: "Libro"),
        Alien(imageName: "AlienoGelato", happyItemImageName: "Gelato")
    ]

    @State private var items = [
        HappyItem(imageName: "Gelato"),
        HappyItem(imageName: "Controller"),
        HappyItem(imageName: "Libro")
    ]

    @State private var matches: [UUID: String] = [:]
    @State private var showSuccess = false
    var coloreNoiaOmbra: Color
    var coloreNoia: Color
    var body: some View {
        VStack(spacing: 20) {
            Text("Collega gli alieni a cosa li rende felici!")
                .font(.custom("Mitr-Regular", size: 36))
                .multilineTextAlignment(.center)
                .padding(.top)

            if showSuccess {
                VStack(spacing: 10) {
                    Text("Ben fatto!")
                        .font(.title)
                        .foregroundColor(.green)
                        .transition(.opacity)
                    Spacer();
                    Button(action: {
                        navManager.currentView = .canvas
                    }) {
                        Text("Avanti")
                            .font(.custom("Mitr-Regular", size: 24))
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 200)
                            .background(coloreNoia)
                            .cornerRadius(12)
                    }.shadow(color: coloreNoiaOmbra, radius: 0, x: 10, y: 10)
                }
                .padding(.bottom, 20)
            }

            HStack(spacing: 60) {
                // Alieni (trascinabili)
                VStack(spacing: 60) {
                    ForEach(aliens) { alien in
                        Image(alien.imageName)
                            .resizable()
                            .frame(width: 180, height: 180)
                            .padding()
                            .draggable(alien.imageName)
                    }
                }

                Spacer()

                // Oggetti (destinazioni)
                VStack(spacing: 60) {
                    ForEach(items, id: \.self) { item in
                        Image(item.imageName)
                            .resizable()
                            .frame(width: 160, height: 160)
                            .padding()
                            .dropDestination(for: String.self) { dropped, _ in
                                if let draggedAlienImage = dropped.first {
                                    if let correctAlien = aliens.first(where: { $0.happyItemImageName == item.imageName }) {
                                        if draggedAlienImage == correctAlien.imageName {
                                            matches[item.id] = draggedAlienImage
                                            items.removeAll { $0.imageName == item.imageName }
                                            aliens.removeAll { $0.imageName == draggedAlienImage }
                                            checkForSuccess()
                                            playSuccessSound()
                                            return true
                                        }
                                    }
                                }

                                playErrorSound()
                                return false
                            }
                    }
                }
            }

            Spacer()
        }
        .padding()
    }

    func checkForSuccess() {
        if matches.count == totalMatches {
            withAnimation {
                showSuccess = true
            }
        }
    }

    func playSuccessSound() {
        AudioServicesPlaySystemSound(1104)
    }

    func playErrorSound() {
        AudioServicesPlaySystemSound(1023)
    }
}
