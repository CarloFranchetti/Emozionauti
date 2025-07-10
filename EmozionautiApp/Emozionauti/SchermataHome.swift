import SwiftUI

struct SchermataHome: View {
    let coloriEmozioni: [String: Color]
    @EnvironmentObject var navManager: NavigationManager

    var body: some View {
        NavigationStack { 
            ZStack {
                Color(red:12/255, green:10/255, blue:96/255)
                    .ignoresSafeArea()
                Image("sfondo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                Image("pianeta")
                    .resizable()
                    .position(x:400,y:1100)
                    .aspectRatio(contentMode: .fill)

                VStack(alignment: .center, spacing:70) {
                    HStack(spacing:80) {
                        // RABBIA
                        Button {
                            navManager.currentView = .animazioneRabbia
                        } label: {
                            Image("rabbia")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .background(coloriEmozioni["rabbia"])
                                .cornerRadius(20)
                                .padding()
                        }
                        .shadow(color: coloriEmozioni["rabbiaombra"]!, radius: 0, x: 5, y: 10)

                        // FELICITÀ
                        Button {
                            navManager.currentView = .animazioneFelicita
                        } label: {
                            Image("felicita")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .background(coloriEmozioni["felicita"])
                                .cornerRadius(20)
                                .padding()
                        }
                        .shadow(color: coloriEmozioni["felicitaombra"]!, radius: 0, x: 5, y: 10)

                        // PAURA
                        Button {
                            navManager.currentView = .animazionePaura
                        } label: {
                            Image("paura")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .background(coloriEmozioni["paura"])
                                .cornerRadius(20)
                                .padding()
                        }
                        .shadow(color: coloriEmozioni["pauraombra"]!, radius: 0, x: 5, y: 10)
                    }

                    HStack(spacing:80) {
                        // NOIA
                        Button {
                            navManager.currentView = .animazioneNoia
                        } label: {
                            Image("noia")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .background(coloriEmozioni["noia"])
                                .cornerRadius(20)
                                .padding()
                        }
                        .shadow(color: coloriEmozioni["noiaombra"]!, radius: 0, x: 5, y: 10)

                        // TRISTEZZA
                        Button {
                            navManager.currentView = .animazioneTristezza
                        } label: {
                            Image("tristezza")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .background(coloriEmozioni["tristezza"])
                                .cornerRadius(20)
                                .padding()
                        }
                        .shadow(color: coloriEmozioni["tristezzaombra"]!, radius: 0, x: 5, y: 10)
                    }
                }
                .position(x:400,y:500)

                HStack {
                    Button {
                        navManager.currentView = .diario
                    } label: {
                        Image(systemName: "book.fill")
                            .resizable()
                            .scaledToFit()
                            .padding()
                            .foregroundColor(.white)
                            .frame(width: 100, height: 100)
                            .background(Color(red:12/255,green:10/255,blue:96/255))
                            .cornerRadius(20)
                            .padding()
                    }

                    Button {
                        navManager.currentView = .canvas
                    } label: {
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .padding()
                            .foregroundColor(.white)
                            .frame(width: 100, height: 100)
                            .background(Color(red:12/255,green:10/255,blue:96/255))
                            .cornerRadius(20)
                            .padding(80)
                    }
                }
                .position(x:500,y:900)
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}
