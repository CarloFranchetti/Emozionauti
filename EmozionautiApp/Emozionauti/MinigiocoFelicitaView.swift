import SwiftUI
import SpriteKit

struct MinigiocoFelicitaView: View {
    var coloreFelicita: Color
    var coloreFelicitaOmbra: Color
    var coloreSfondo: Color
    
    @EnvironmentObject var navManager: NavigationManager
    @StateObject private var minigioco: MinigiocoFelicitaViewModel
    
    init(coloreFelicita: Color, coloreFelicitaOmbra: Color, coloreS: Color) {
        self.coloreFelicita = coloreFelicita
        self.coloreFelicitaOmbra = coloreFelicitaOmbra
        self.coloreSfondo = coloreS
        let viewModel = MinigiocoFelicitaViewModel(colore: UIColor(coloreFelicita), coloreSfondo: UIColor(coloreSfondo))
        _minigioco = StateObject(wrappedValue: viewModel)
    }


    var body: some View {
        ZStack {
            SpriteView(scene: makeScene())
                .ignoresSafeArea()
            
            if minigioco.giocoFinito{
                VStack {
                    Spacer()
                    Button(action: {
                        navManager.currentView = .canvas(emozione: "felicita")
                    }) {
                        Text("Avanti")
                            .font(.custom("Mitr-regular", size:30))
                            .padding()
                            .background(coloreFelicita)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .padding(.bottom, 50)
                }
            }
        }
    }

    func makeScene() -> SKScene {
        let scena = MinigiocoFelicita2(size: UIScreen.main.bounds.size)
        scena.viewModel = minigioco
        scena.scaleMode = .resizeFill
        return scena
    }
}

