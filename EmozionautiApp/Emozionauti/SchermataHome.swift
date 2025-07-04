//
//  SchermataHome.swift
//  Emozionauti
//
//  Created by Studente on 01/07/25.
//

import SwiftUI

struct SchermataHome: View {
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
                    .position(x:450,y:1300)
                    .aspectRatio(contentMode: .fill)
                    .padding()
                VStack(spacing:40){
                    HStack(spacing:26){
                        NavigationLink(destination: Animazione()){
                            Image("rabbia")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100,height:100)
                                .background(Color(red:255/255,green:102/255,blue:104/255))
                                .cornerRadius(20)
                                .padding()
                            
                        }
                        .shadow(color: Color(red:202/255,green:37/255,blue:22/255), radius: 0, x: 5, y: 10)
                        
                        
                        NavigationLink(destination: Animazione()){
                            Image("felicita")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100,height:100)
                                .background(Color(red:70/255,green:239/255,blue:48/255))
                                .cornerRadius(20)
                                .padding()
                        }
                        .shadow(color:Color(red:12/255,green:165/255,blue:7/255),radius:0,x:5,y:10)
                        NavigationLink(destination: Animazione()){
                            Image("paura")
                                .resizable()
                                .frame(width: 100,height:100)
                                .aspectRatio(contentMode: .fit)
                                .background(Color(red:194/255,green:168/255,blue:230/255))
                                .cornerRadius(20)
                                .padding()
                            
                        }
                        .shadow(color:Color(red:125/255,green:27/255,blue:191/255),radius:0,x:5,y:10)
                        
                    }
                    .padding(20)
                    HStack(alignment:.center,spacing:40){
                        NavigationLink(destination: Animazione()){
                            Image("noia")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .background(Color(red:171/255,green:173/255,blue:171/255))
                                .cornerRadius(20)
                                .padding()
                            
                        }
                        .shadow(color:Color(red:66/255,green:64/255,blue:56/255),radius:0,x:5,y:10)
                        
                        
                        NavigationLink(destination: Animazione()){
                            Image("tristezza")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .background(Color(red:123/255,green:206/255,blue:248/255))
                                .cornerRadius(20)
                                .padding()
                        }
                        .shadow(color:Color(red:19/255,green:43/255,blue:137/255),radius:0,x:5,y:10)
                    }//.position(x:400,y:650)
                    //  .padding(20)
                    }
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
                }.position(x:500,y:1100)
                    // .padding(20)
                    
                    
                }
            
            
        }
    }
}


#Preview {
    SchermataHome()
}
