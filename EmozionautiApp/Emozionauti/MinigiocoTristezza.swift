import SwiftUI
import AVFoundation



struct MinigiocoTristezza: View {
    @EnvironmentObject var navManager: NavigationManager
    var coloreTriste: Color
    @State var play: Bool = false
    @State var messaggio: String = "Pausa"
    @State var player: AVAudioPlayer?
    @State var fine: Bool = false
    @State var song: String
    @State var image: String
    var body: some View {
        if !fine{
            Text("Balla via la tristezza!")
                .font(.custom("Mitr-Regular",size:50))


    var body: some View {
        VStack(spacing: 40) {
            Text("Balla via la tristezza!")
                .font(.custom("Mitr-Regular", size: 50))
                .fontWeight(.bold)
                .padding(.top, 50)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
            HStack(){
                Button(action:{ playMusic()
                }){
                    Image(systemName: (play ? "speaker.fill": "speaker.slash.fill"))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white)
                        .padding()
                }.background (coloreTriste)
                    .cornerRadius(100)
                Text(messaggio)
                    .font(.custom("Mitr-Regular",size:30))
            }
            GifImage(image)
            Spacer()
        }
        else{
            VStack{
                Text("ORA RIPOSIAMOCI!")
                    .font(.custom("Modak", size:60))
                    .padding([.horizontal],20)
                    .foregroundColor(coloreTriste)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                Image("sleepingAstronaut")
                    .resizable()
                    .scaledToFit()
                    .frame(width:300,height:300)
            }
            
        }

        
 
    }
    
    func playMusic(){
        play = !play;
        messaggio = play ? "Balliamo!":"Pausa";
        if play {
            if player == nil{
                if let urlString = Bundle.main.path(forResource: song, ofType:"mp3"){
                    do{
                        try AVAudioSession.sharedInstance().setMode(.default)
                        try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                        
                        player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
                    }catch{
                        print("Qualcosa è andato storto!");
                        return;
                    }
                }
            }
            player?.play()
            DispatchQueue.main.asyncAfter(deadline: .now() + 240) {
                           play = false
                           player?.stop()
                           fine = true
            }
        }else{
            player?.pause();
        }
    }
    
}
