import SwiftUI
import SpriteKit
struct SchermataHome: View {
    let coloriEmozioni: [String: Color]
    @EnvironmentObject var navManager: NavigationManager
    @State var rotazione: Double = 0.0
    @StateObject private var sfondoAnimato: SfondoAnimatoViewModel
    init(coloriEmozioni: [String : Color]) {
        self.coloriEmozioni = coloriEmozioni
        let sfondo = SfondoAnimatoViewModel(coloreSfondo: UIColor(coloriEmozioni["sfondo"]!))
        _sfondoAnimato = StateObject(wrappedValue: sfondo)
    }
    
    var body: some View {
        GeometryReader{ geometry in
            NavigationStack {
                ZStack {
                  SpriteView(scene: {
                        let scene = SfondoAnimato()
                        scene.size = UIScreen.main.bounds.size
                        scene.scaleMode = .resizeFill
                        scene.viewModel = sfondoAnimato
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
                                navManager.currentView = .saltaAnimazioneRabbia
                            } label: {
                                Image("rabbia")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width*0.13, height: geometry.size.height*0.10)
                                    .background(coloriEmozioni["rabbia"])
                                    .cornerRadius(20)
                                    .padding()
                            }
                            .shadow(color: coloriEmozioni["rabbiaombra"]!, radius: 0, x: 5, y: 10)
                            
                            // FELICITÀ
                            Button {
                                navManager.currentView = .saltaAnimazioneFelicita
                            } label: {
                                Image("felicita")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width*0.13, height: geometry.size.height*0.10)
                                    .background(coloriEmozioni["felicita"])
                                    .cornerRadius(20)
                                    .padding()
                            }
                            .shadow(color: coloriEmozioni["felicitaombra"]!, radius: 0, x: 5, y: 10)
                            
                            // PAURA
                            Button {
                                
                                navManager.currentView = .saltaAnimazionePaura
                            } label: {
                                Image("paura")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width*0.13, height: geometry.size.height*0.10)
                                    .background(coloriEmozioni["paura"])
                                    .cornerRadius(20)
                                    .padding()
                            }
                            .shadow(color: coloriEmozioni["pauraombra"]!, radius: 0, x: 5, y: 10)
                        }
                        
                        HStack(spacing:80) {
                            // NOIA
                            Button {
                                
                                navManager.currentView = .saltaAnimazioneNoia
                            } label: {
                                Image("noia")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width*0.13, height: geometry.size.height*0.10)
                                    .background(coloriEmozioni["noia"])
                                    .cornerRadius(20)
                                    .padding()
                            }
                            .shadow(color: coloriEmozioni["noiaombra"]!, radius: 0, x: 5, y: 10)
                            
                            // TRISTEZZA
                            Button {
                               
                                navManager.currentView = .saltaAnimazioneTristezza
                            } label: {
                                Image("tristezza")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width*0.13, height: geometry.size.height*0.10)
                                    .background(coloriEmozioni["tristezza"])
                                    .cornerRadius(20)
                                    .padding()
                            }
                            .shadow(color: coloriEmozioni["tristezzaombra"]!, radius: 0, x: 5, y: 10)
                        }
                    }
                    .position(x:geometry.size.width/2,y:geometry.size.height/2)
                }
                .navigationBarBackButtonHidden(true)
            }
        }
        
    }
}


