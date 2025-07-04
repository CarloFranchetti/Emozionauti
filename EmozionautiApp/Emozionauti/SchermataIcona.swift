import SwiftUI
import SpriteKit
import AVFoundation
import AudioToolbox

struct SchermataIcona: View {
    @State private var progress: Double = 0.0
    @State private var showProgress = true
    let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            // Sfondo con stelle animate
            Color(red:12/255,green:10/255,blue:96/255)
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
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                if showProgress {
                    ProgressView(value: progress)
                        .progressViewStyle(.linear)
                        .frame(width: 500)
                        .tint(.yellow)
                        .padding(.top, 30)
                }
            }
        }
        .onAppear {
            playPopSound()
        }
        .onReceive(timer) { _ in
            if showProgress {
                if progress < 1.0 {
                    progress += 0.02
                } else {
                    showProgress = false
                }
            }
        }
    }

    func playPopSound() {
        AudioServicesPlaySystemSound(1104)
    }
}
