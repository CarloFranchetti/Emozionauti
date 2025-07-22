
import SwiftUI
import SpriteKit

struct MinigiocoNoia: View {
    @EnvironmentObject var navManager: NavigationManager
    @Binding var vaiAvanti: Bool
    var coloreNoiaOmbra: Color
    var coloreNoia: Color
    var scene: SKScene {
        let scene = GameScene()
        scene.size = CGSize(width: 1024, height: 768)
        scene.vaiAvanti = $vaiAvanti
        scene.scaleMode = .resizeFill
        return scene
    }

    var body: some View {
        VStack {
            Text("Minigioco Noia")
                .font(.largeTitle)
                .opacity(vaiAvanti ? 0:1)
                .padding()
            

            SpriteView(scene: scene)
                .frame(width: 1024, height: 768)
                .ignoresSafeArea()
            if vaiAvanti{
                Button(action: {
                    navManager.currentView = .canvas (text: "Disegna cosa ti ha reso annoiato...", emozione: "Noia 😴")
                }) {
                    Text("Avanti")
                        .font(.custom("Mitr-Regular", size: 30))
                        .foregroundColor(.white)
                        .frame(width: 250, height: 100)
                        .background(coloreNoia)
                        .cornerRadius(20)
                        .padding(30)
                } .shadow(color: coloreNoiaOmbra, radius: 0, x: 5, y: 10)
            }
                
        }
    }
}
