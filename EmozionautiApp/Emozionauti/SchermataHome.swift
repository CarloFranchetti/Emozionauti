import SwiftUI

struct SchermataHome: View {
    let coloriEmozioni: [String: Color]
    @EnvironmentObject var navManager: NavigationManager
    @EnvironmentObject var diaryViewModel: DiaryViewModel
    @State var rotazione: Double = 0.0
    
    
    var body: some View {
        GeometryReader{ geometry in
            NavigationStack {
                ZStack {
                    Color(red:12/255, green:10/255, blue:96/255)
                        .ignoresSafeArea()
                    Image("sfondo")
                        .resizable()
                        .frame(width: geometry.size.width,height: geometry.size.height)
                        .aspectRatio(contentMode: .fill)
                    Image("pianeta")
                        .resizable()
                        .position(x:geometry.size.width/2,y:geometry.size.height)
                        .aspectRatio(contentMode: .fill)
                        .rotationEffect(.degrees(rotazione), anchor: .center)
                        .onAppear{
                            withAnimation(.linear(duration: 1).speed(0.1).repeatForever(autoreverses: false)) {
                                rotazione = 360.0
                            }
                        }
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
                            .background(Color(red:12/255,green:10/255,blue:96/255))
                            .cornerRadius(20)
                            .padding(80)
                    }
                    .position(x:geometry.size.width-50,y:geometry.size.height/20)
                    
                    VStack(alignment: .center, spacing:70) {
                        HStack(spacing:80) {
                            // RABBIA
                            Button {
                                diaryViewModel.recordEmotion("rabbia")
                                navManager.currentView = .animazioneRabbia
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
                                diaryViewModel.recordEmotion("felicità")
                                navManager.currentView = .animazioneFelicita
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
                                diaryViewModel.recordEmotion("paura")
                                navManager.currentView = .animazionePaura
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
                                diaryViewModel.recordEmotion("noia")
                                navManager.currentView = .animazioneNoia
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
                                diaryViewModel.recordEmotion("tristezza")
                                navManager.currentView = .animazioneTristezza
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
