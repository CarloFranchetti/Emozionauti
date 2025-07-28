//
//  BoredomGameView.swift
//  Emozionauti
//
//  Created by Studente on 22/07/25.
//

import SwiftUI
import SpriteKit

struct BoredomView: View {
    @EnvironmentObject var navManager: NavigationManager
    @Binding var ahead: Bool
    var boredomShadowColor: Color
    var boredomColor: Color
    
    @State private var boredomGame: GameScene = {
        let scene = GameScene()
        scene.size = CGSize(width: 1024, height: 768)
        scene.scaleMode = .resizeFill
        return scene
    }()

    var body: some View {
        ZStack {
            SpriteView(scene: {
                boredomGame.ahead = $ahead
                return boredomGame
                }())
                .ignoresSafeArea()
            if ahead{
                VStack{
                    Spacer()
                    Button(action: {
                        navManager.currentView = .canvas (text: "Disegna cosa ti ha reso annoiato...", emotion: "Noia 😴")
                    }) {
                        Text("Avanti")
                            .font(.custom("Mitr-Regular", size: 30))
                            .foregroundColor(.white)
                            .frame(width: 200, height: 60)
                            .background(boredomColor)
                            .cornerRadius(20)
                            .padding([.bottom],30)
                    } .shadow(color: boredomShadowColor, radius: 0, x: 5, y: 10)
                }
            }
                
        }
    }
}
