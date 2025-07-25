import SwiftUI
import SpriteKit

struct HappinessGameView: View {
    var happinessColor: Color
    var happinessShadowColor: Color
    var backgroundColor: Color
    
    @EnvironmentObject var navManager: NavigationManager
    @StateObject private var game: HappinessGameViewModel
    
    init(happinessColor: Color, happinessShadowColor: Color, backgroundC: Color) {
        self.happinessColor = happinessColor
        self.happinessShadowColor = happinessShadowColor
        self.backgroundColor = backgroundC
        let viewModel = HappinessGameViewModel(happinessColor: UIColor(happinessColor), backgroundColor: UIColor(backgroundColor))
        _game = StateObject(wrappedValue: viewModel)
    }


    var body: some View {
        ZStack {
            SpriteView(scene: makeScene())
                .ignoresSafeArea()
            
            if game.endGame{
                VStack {
                    Spacer()
                    Button(action: {
                        navManager.currentView = .canvas(text: "Disegna cosa ti ha reso felice...",emotion: "Felicità 😀")
                    }) {
                        Text("Avanti")
                            .font(.custom("Mitr-regular", size:30))
                            .frame(width: 200, height: 60)
                            .background(happinessColor)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .padding()
                    }
                    .shadow(color: happinessShadowColor, radius: 0, x: 5, y:10)
                    .padding(.bottom, 50)
                }
            }
        }
    }

    func makeScene() -> SKScene {
        let scene = HappinessGame(size: UIScreen.main.bounds.size)
        scene.viewModel = game
        scene.scaleMode = .resizeFill
        return scene
    }
}

