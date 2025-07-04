//
//  Animazione.swift
//  Emozionauti
//
//  Created by Studente on 04/07/25.
//


import SwiftUI

struct Colore{
    var red: Double
    var green: Double
    var blue: Double
}



struct Animazione: View {
    var body: some View {
        NavigationStack{
            ZStack {
                let sfondoEmozione = Colore(red:255/255,green:102/255,blue:104/255)
                let sfondoBlu = Colore(red:12/255,green:10/255,blue:96/255)
                let ombraEmozione = Colore(red:205/255,green:41/255,blue:61/255)
                Color(red: sfondoBlu.red, green: sfondoBlu.green, blue: sfondoBlu.blue)
                    .ignoresSafeArea()
                VStack{
                    Text("Quando ti senti arrabbiato...")
                        .font(.custom("Mitr-Regular",size:50))
                        .fontWeight(.bold)
                        .padding(.top, 200)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    Spacer()
                    NavigationLink(destination: Minigioco()){
                        Text("Avanti")
                            .foregroundColor(Color(red: sfondoBlu.red, green: sfondoBlu.green, blue: sfondoBlu.blue))
                            .font(.custom("Mitr-Regular",size:50))
                    }.background(Color(red: sfondoEmozione.red, green: sfondoEmozione.green, blue: sfondoEmozione.blue))
                        .cornerRadius( 25)
                        .frame(width: 300, height: 100)
                        .tint(Color.green)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color(red:ombraEmozione.red, green: ombraEmozione.green, blue:ombraEmozione.blue), lineWidth: 1)
                        )
                        .background(Color(red: sfondoEmozione.red, green: sfondoEmozione.green, blue: sfondoEmozione.blue))
                        .cornerRadius(25)
                        .padding([.bottom,.trailing],50)
                        .shadow(color: Color(red:ombraEmozione.red, green: ombraEmozione.green, blue:ombraEmozione.blue), radius: 0, x: 10, y: 10)
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}
    

#Preview {
    Animazione()
}
