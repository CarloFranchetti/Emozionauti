import SwiftUI
import SpriteKit
struct HomeScreen: View {
    let emotionsColors: [String: Color]
    @EnvironmentObject var navManager: NavigationManager
    @State var rotation: Double = 0.0
    @StateObject private var animatedBackground: AnimatedBackgroundViewModel
    init(emotionsColors: [String : Color]) {
        self.emotionsColors = emotionsColors
        let background = AnimatedBackgroundViewModel(backgroundColor: UIColor(emotionsColors["background"]!))
        _animatedBackground = StateObject(wrappedValue: background)
    }
    
    var body: some View {
        GeometryReader{ geometry in
            NavigationStack {
                ZStack {
                  SpriteView(scene: {
                        let scene = AnimatedBackground()
                        scene.size = UIScreen.main.bounds.size
                        scene.scaleMode = .resizeFill
                        scene.viewModel = animatedBackground
                        return scene
                    }())
                    .ignoresSafeArea()
                    .allowsHitTesting(false)
                    
                    //Pulsante impostazioni
                    Button {
                        navManager.currentView = .parentalControl
                    } label: {
                        Image(systemName: "gearshape")
                            .resizable()
                            .scaledToFit()
                            .padding()
                            .foregroundColor(.white)
                            .frame(width: geometry.size.width*0.1, height: geometry.size.height*0.1)
                            .cornerRadius(20)
                            .padding(80)
                    }
                    .position(x:geometry.size.width-50,y:geometry.size.height/20)
                    
                    VStack(alignment: .center, spacing:70) {
                        HStack(spacing:80) {
                            // RABBIA
                            Button {
                                navManager.currentView = .skipAngerAnimation
                            } label: {
                                Image("anger")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width*0.13, height: geometry.size.height*0.10)
                                    .background(emotionsColors["anger"])
                                    .cornerRadius(20)
                                    .padding()
                            }
                            .shadow(color: emotionsColors["angershadow"]!, radius: 0, x: 5, y: 10)
                            
                            // FELICITÀ
                            Button {
                                navManager.currentView = .skipHappinessAnimation
                            } label: {
                                Image("happiness")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width*0.13, height: geometry.size.height*0.10)
                                    .background(emotionsColors["happiness"])
                                    .cornerRadius(20)
                                    .padding()
                            }
                            .shadow(color: emotionsColors["happinessshadow"]!, radius: 0, x: 5, y: 10)
                            
                            // PAURA
                            Button {
                                
                                navManager.currentView = .skipFearAnimation
                            } label: {
                                Image("fear")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width*0.13, height: geometry.size.height*0.10)
                                    .background(emotionsColors["fear"])
                                    .cornerRadius(20)
                                    .padding()
                            }
                            .shadow(color: emotionsColors["fearshadow"]!, radius: 0, x: 5, y: 10)
                        }
                        
                        HStack(spacing:80) {
                            // NOIA
                            Button {
                                
                                navManager.currentView = .skipBoredomAnimation
                            } label: {
                                Image("boredom")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width*0.13, height: geometry.size.height*0.10)
                                    .background(emotionsColors["boredom"])
                                    .cornerRadius(20)
                                    .padding()
                            }
                            .shadow(color: emotionsColors["boredomshadow"]!, radius: 0, x: 5, y: 10)
                            
                            // TRISTEZZA
                            Button {
                               
                                navManager.currentView = .skipSadnessAnimation
                            } label: {
                                Image("sadness")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width*0.13, height: geometry.size.height*0.10)
                                    .background(emotionsColors["sadness"])
                                    .cornerRadius(20)
                                    .padding()
                            }
                            .shadow(color: emotionsColors["sadnessshadow"]!, radius: 0, x: 5, y: 10)
                        }
                    }
                    .position(x:geometry.size.width/2,y:geometry.size.height/2)
                }
                .navigationBarBackButtonHidden(true)
            }
        }
        
    }
}


