import SwiftUI
import AVFoundation

struct SadnessGame: View {
    @EnvironmentObject var navManager: NavigationManager
    var sadnessColor: Color
    var sadnessShadowColor: Color
    @State var play: Bool = false
    @State var message: String = "Pausa"
    @State var player: AVAudioPlayer?
    @State var endGame: Bool = false
    var song: String
    var image: String

    var body: some View {
        VStack(spacing: 40) {
            if endGame{
                VStack {
                    Text("ORA RIPOSIAMOCI!")
                        .font(.custom("Modak", size: 60))
                        .padding(.horizontal, 20)
                        .foregroundColor(sadnessColor)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                    Image("sleepingAstronaut2")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 500, height: 500)
                    Button(action: {
                        navManager.currentView = .canvas(text: "Disegna cosa ti ha reso triste...", emozione: "Tristezza 😢")
                    }) {
                        Text("Avanti")
                            .font(.custom("Mitr-Regular", size: 30))
                            .foregroundColor(.white)
                            .frame(width: 250, height: 100)
                            .background(sadnessColor)
                            .cornerRadius(20)
                            .padding(30)
                    } .shadow(color: sadnessShadowColor, radius: 0, x: 5, y: 10)
                }
            } else {
                VStack(spacing: 40) {
                    Text("Balla via la tristezza!")
                        .font(.custom("Mitr-Regular", size: 50))
                        .fontWeight(.bold)
                        .padding(.top, 50)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)

                    HStack {
                        Button(action: {
                            playMusic()
                        }) {
                            Image(systemName: play ? "speaker.fill" : "speaker.slash.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.white)
                                .padding()
                        }
                        .background(sadnessColor)
                        .cornerRadius(100)

                        Text(message)
                            .font(.custom("Mitr-Regular", size: 30))
                    }

                    GifImage(image) // Assicurati che GifImage esista nel progetto
                    Spacer()
                }
            }
        }
    }

    func playMusic() {
        play.toggle()
        message = play ? "Balliamo!" : "Pausa"

        if play {
            if player == nil {
                if let urlString = Bundle.main.path(forResource: song, ofType: "mp3") {
                    do {
                        try AVAudioSession.sharedInstance().setMode(.default)
                        try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                        player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
                    } catch {
                        print("Errore nella riproduzione audio")
                        return
                    }
                }
            }

            player?.play()

            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                play = false
                player?.stop()
                endGame = true
            }
        } else {
            player?.pause()
        }
    }
}
