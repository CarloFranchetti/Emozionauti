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
                    .aspectRatio(contentMode: .fill)
                    .position(x:430,y:1300)
                HStack{
                    NavigationLink(destination: Animazione(coloreEmozione:coloriEmozioni["rabbia"]!,coloreOmbra: coloriEmozioni["rabbiaombra"]!, text:"Quando ti senti arrabbiato...")){
                        Image("rabbia")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .background(coloriEmozioni["rabbia"])
                            .cornerRadius(20)
                            .padding(80)
                        
                    }
                    .shadow(color: coloriEmozioni["rabbiaombra"]!, radius: 0, x: 5, y: 10)
                    
                        
                    NavigationLink(destination: Animazione(coloreEmozione:coloriEmozioni["felicita"]!,coloreOmbra: coloriEmozioni["felicitaombra"]!, text:"Quando ti senti felice...")){
                        Image("felicita")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .background(coloriEmozioni["felicita"])
                            .cornerRadius(20)
                            .padding(80)
                    }
                    .shadow(color:coloriEmozioni["felicitaombra"]!,radius:0,x:5,y:10)
                    NavigationLink(destination: Animazione(coloreEmozione:coloriEmozioni["paura"]!,coloreOmbra: coloriEmozioni["pauraombra"]!, text:"Quando hai paura...")){
                        Image("paura")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .background(coloriEmozioni["paura"])
                            .cornerRadius(20)
                            .padding(80)
                        
                    }
                    .shadow(color:coloriEmozioni["pauraombra"]!,radius:0,x:5,y:10)
                        
                }.position(x:400,y:450)
                    .padding(20)
                HStack{
                    NavigationLink(destination: Animazione(coloreEmozione:coloriEmozioni["noia"]!,coloreOmbra: coloriEmozioni["noiaombra"]!, text:"Quando sei annoiato...")){
                        Image("noia")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .background(coloriEmozioni["noia"])
                            .cornerRadius(20)
                            .padding(80)
                        
                    }
                    .shadow(color:coloriEmozioni["noiaombra"]!,radius:0,x:5,y:10)
                      
                        
                    NavigationLink(destination: Animazione(coloreEmozione:coloriEmozioni["tristezza"]!,coloreOmbra: coloriEmozioni["tristezzaombra"]!, text:"Quando ti senti triste...")){
                        Image("tristezza")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .background(coloriEmozioni["tristezza"])
                            .cornerRadius(20)
                            .padding(80)
                    }
                    .shadow(color:coloriEmozioni["tristezzaombra"]!,radius:0,x:5,y:10)
                }.position(x:400,y:650)
                    .padding(20)
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
                            .padding(80)
                        
                    }
                    NavigationLink(destination:ParentAccessView()){
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
                }.position(x:400,y:900)
                    .padding(20)
                
                
            }
        }
    }
    }

#Preview{
    ContentView()
}


