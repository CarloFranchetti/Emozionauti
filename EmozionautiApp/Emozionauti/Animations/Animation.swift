//
//  Animation.swift
//  Emozionauti
//
//  Created by Studente on 4/07/25.
//

import SwiftUI
import AVKit


struct Animation: View {
    @EnvironmentObject var navManager: NavigationManager
    @State private var end: Bool = false
    var animation : String
    var emotionColor: Color
    var shadowColor: Color
    var nextView: NavigationViewType

    
    var body: some View {
        ZStack {
            VideoPlayerView(videoName: animation, isVideoFinished: $end)
                .ignoresSafeArea()
                .aspectRatio(contentMode: .fill)
            VStack() {
                Spacer()
                if end{
                    Button(action: {
                        navManager.currentView = nextView
                    }) {
                        Text("Inizia il minigioco")
                            .font(.custom("Mitr-regular", size: 45))
                            .frame(width: 500, height: 100)
                            .background(emotionColor)
                            .cornerRadius(20)
                            .foregroundColor(.white)
                            .padding()
                    }.shadow(color: shadowColor, radius: 0, x: 5, y:5)
            }
            
            
                
            }
        }
    }
}
