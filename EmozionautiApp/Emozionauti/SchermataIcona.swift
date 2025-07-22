import SwiftUI
import SpriteKit
import AVFoundation
import AudioToolbox

struct SchermataIcona: View {
    @EnvironmentObject var navManager: NavigationManager
    @State private var progress: Double = 0.0
    let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            Color(red:12/255, green:10/255, blue:96/255)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Image("logoEmozionauti")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250)
                    .cornerRadius(20)
                    .shadow(radius: 10)

                Text("Emozionauti")
                    .font(.custom("AvenirNext-Bold", size: 45))
                    .foregroundColor(.white)

                ProgressView(value: progress)
                    .progressViewStyle(.linear)
                    .frame(width: 300)
                    .tint(.yellow)
                    .padding(.top, 30)
            }
        }
        .onAppear {
            playPopSound()
        }
        .onReceive(timer) { _ in
            if progress < 1.0 {
                progress += 0.05
            } else {
                navManager.currentView = .home
                // Ferma il timer una volta completato
                timer.upstream.connect().cancel()
            }
        }
    }

    func playPopSound() {
        AudioServicesPlaySystemSound(1104)
    }
}
