import SwiftUI
import AVKit
struct Animazione: View {
    @EnvironmentObject var navManager: NavigationManager
    var animazione : String
    var coloreEmozione: Color
    var coloreOmbra: Color
    var text: String
    var nextView: NavigationViewType
    @State private var fine: Bool = false
    var body: some View {
        ZStack {
            VideoPlayerView(videoName: animazione, isVideoFinished: $fine)
                .ignoresSafeArea()
                .aspectRatio(contentMode: .fill)
            VStack() {
                //Text(text)
                //    .font(.custom("Mitr-regular", size: 50))
               //     .foregroundColor(.white)
                Spacer()
                if fine{
                    Button(action: {
                        navManager.currentView = nextView
                    }) {
                        Text("Inizia il minigioco")
                            .font(.custom("Mitr-regular", size: 45))
                            .background(coloreEmozione)
                            .foregroundColor(.white)
                            .frame(width: 500, height: 200)
                            .cornerRadius(20)
                    }.shadow(color: coloreOmbra, radius: 0, x: 5, y:5)
            }
            
            
                
            }
        }
    }
}
