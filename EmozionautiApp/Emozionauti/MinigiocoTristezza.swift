//
//  MinigiocoTristezza.swift
//  Emozionauti
//
//  Created by Studente on 04/07/25.
//

import SwiftUI
import AVFoundation



struct MinigiocoTristezza: View {
    var coloreTriste: Color
    @State var play: Bool = false
    @State var messaggio: String = "Pausa"
    @State var player: AVAudioPlayer?
    var body: some View {
        Text("Balla via la tristezza!")
            .font(.custom("Mitr-Regular",size:50))
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
        GifImage("dancingAlien")
        Spacer()
        
 
    }
    
    func playMusic(){
        play = !play;
        messaggio = play ? "Balliamo!":"Pausa";
        if play {
            if player == nil{
                if let urlString = Bundle.main.path(forResource: "songysong", ofType:"mp3"){
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
        }else{
            player?.pause();
        }
    }
    
}

#Preview {
    ContentView()
}
