//
//  SchermataHome.swift
//  Emozionauti
//
//  Created by Studente on 01/07/25.
//

import SwiftUI


struct SchermataHome: View {
    let coloriEmozioni:[String:Color]
    var body: some View {
        NavigationStack{
            ZStack{ // permette il colore dietro a tutto
                Color(red:12/255,green:10/255,blue:96/255)
                    .ignoresSafeArea() //inserire valori tra 0.0 e 1.0 quindi dividere i valori per 255
                Image("sfondo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                Image("pianeta")
                    .resizable()
                    .position(x:400,y:1100)
                    .aspectRatio(contentMode: .fill)
                VStack(alignment: .center, spacing:70){
                    HStack(spacing:80){
                        NavigationLink(destination: Animazione(coloreEmozione:coloriEmozioni["rabbia"]!,coloreOmbra: coloriEmozioni["rabbiaombra"]!, text:"Quando ti senti arrabbiato..." ,minigioco:{ MinigiocoRabbia(colore:coloriEmozioni["rabbiaombra"]!) })) {
                            Image("rabbia")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .background(coloriEmozioni["rabbia"])
                                .cornerRadius(20)
                                .padding()
                            
                        }
                        .shadow(color: coloriEmozioni["rabbiaombra"]!, radius: 0, x: 5, y: 10)
                        
                        
                        NavigationLink(destination: Animazione(coloreEmozione:coloriEmozioni["felicita"]!,coloreOmbra: coloriEmozioni["felicitaombra"]!, text:"Quando ti senti felice...",minigioco:{MinigiocoFelicita()})){
                            Image("felicita")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .background(coloriEmozioni["felicita"])
                                .cornerRadius(20)
                                .padding()
                        }
                        .shadow(color:coloriEmozioni["felicitaombra"]!,radius:0,x:5,y:10)
                        NavigationLink(destination: Animazione(coloreEmozione:coloriEmozioni["paura"]!,coloreOmbra: coloriEmozioni["pauraombra"]!, text:"Quando hai paura...",minigioco: {MinigiocoPaura()})){
                            Image("paura")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .background(coloriEmozioni["paura"])
                                .cornerRadius(20)
                                .padding()
                            
                        }
                        .shadow(color:coloriEmozioni["pauraombra"]!,radius:0,x:5,y:10)
                        
                    }
                    HStack(spacing: 80){
                        NavigationLink(destination: Animazione(coloreEmozione:coloriEmozioni["noia"]!,coloreOmbra: coloriEmozioni["noiaombra"]!, text:"Quando sei annoiato...", minigioco:{MinigiocoNoia()})){
                            Image("noia")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .background(coloriEmozioni["noia"])
                                .cornerRadius(20)
                                .padding()
                            
                        }
                        .shadow(color:coloriEmozioni["noiaombra"]!,radius:0,x:5,y:10)
                        
                        
                        NavigationLink(destination: Animazione(coloreEmozione:coloriEmozioni["tristezza"]!,coloreOmbra: coloriEmozioni["tristezzaombra"]!, text:"Quando ti senti triste...", minigioco:{MinigiocoTristezza()})){
                            Image("tristezza")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .background(coloriEmozioni["tristezza"])
                                .cornerRadius(20)
                                .padding()
                        }
                        .shadow(color:coloriEmozioni["tristezzaombra"]!,radius:0,x:5,y:10)
                    }
                }.position(x:400,y:500)
            
            HStack{
                NavigationLink(destination: DiaryStatsView()){
                    Image(systemName: "book.fill")
                        .resizable()
                        .scaledToFit()
                        .padding()
                        .foregroundColor(.white)
                        .frame(width: 100, height: 100)
                        .background( Color(red:12/255,green:10/255,blue:96/255))
                        .cornerRadius(20)
                        .padding()
                    
                }
                NavigationLink(destination:ContentView1()){
                    Image(systemName: "person.fill")
                        .resizable()
                        .scaledToFit()
                        .padding()
                        .foregroundColor(.white)
                        .frame(width: 100, height: 100)
                        .background (Color(red:12/255,green:10/255,blue:96/255))
                        .cornerRadius(20)
                        .padding(80)
                }
            }.position(x:500,y:900)
            // .padding(20)
            
            
            }
        
        }
    }
}


#Preview{
    ContentView()
}


