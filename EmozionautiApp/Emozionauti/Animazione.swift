//
//  Animazione.swift
//  Emozionauti
//
//  Created by Studente on 04/07/25.
//


import SwiftUI





struct Animazione<Minigioco: View>: View {
    var coloreEmozione: Color
    var coloreOmbra: Color
    var text: String
    var minigioco: () -> Minigioco
    var body: some View {
        NavigationStack{
            ZStack {
               // let sfondoEmozione = Color(red:255/255,green:102/255,blue:104/255)
                let sfondoBlu = Color(red:12/255,green:10/255,blue:96/255)
              //  let ombraEmozione = Color(red:205/255,green:41/255,blue:61/255)
                Color(sfondoBlu)
                    .ignoresSafeArea()
                VStack{
                    Text(text)
                        .font(.custom("Mitr-Regular",size:50))
                        .fontWeight(.bold)
                        .padding(.top, 100)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    Spacer()
                    NavigationLink(destination: minigioco()){
                        Text("Avanti")
                            .foregroundColor(Color(sfondoBlu))
                            .font(.custom("Mitr-Regular",size:50))
                    }.background(Color(coloreEmozione))
                        .cornerRadius( 25)
                        .frame(width: 300, height: 100)
                        .tint(Color.green)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color(coloreOmbra), lineWidth: 1)
                        )
                        .background(Color(coloreEmozione))
                        .cornerRadius(25)
                        .padding([.bottom,.trailing],50)
                        .shadow(color: Color(coloreOmbra), radius: 0, x: 10, y: 10)
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}
    

#Preview {
    ContentView()
}
