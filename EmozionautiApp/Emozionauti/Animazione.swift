import SwiftUI
import AVKit
struct Animazione: View {
    @EnvironmentObject var navManager: NavigationManager

    var coloreEmozione: Color
    var coloreOmbra: Color
    var text: String
    var nextView: NavigationViewType
    var fine: Bool = false
    var body: some View {
        ZStack {
            //let sfondoBlu = Color(red: 12/255, green: 10/255, blue: 96/255)
            //Color(sfondoBlu)
             //   .ignoresSafeArea()
            VideoPlayerView(videoName: "AnimazioneRabbia")
                .ignoresSafeArea()
                .aspectRatio(contentMode: .fill)
            VStack() {
                Text(text)
                    .font(.custom("Mitr-regular", size: 50))
                    .foregroundColor(.white)
                Spacer()
            }
            .padding()
            if fine{
                Button(action: {
                    navManager.currentView = nextView
                }) {
                    Text("Inizia il minigioco")
                        .font(.custom("Mitr-regular", size: 50))
                }
                .padding()
                .background(coloreOmbra)
                .foregroundColor(.white)
                .cornerRadius(10)
                
            }
        }
    }
}
