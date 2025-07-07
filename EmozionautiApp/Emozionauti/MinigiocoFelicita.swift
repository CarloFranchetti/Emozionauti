//
//  MinigiocoFelicita.swift
//  Emozionauti
//
//  Created by Studente on 04/07/25.
//

import SwiftUI

struct MinigiocoFelicita: View {
    let vectorImage = [Image("astronauta1"), Image("astronauta2"),Image("astronauta3")]
    var body: some View {
        Text("Conta gli astronauti!")
            .font(.custom("Mitr-Regular",size:50))
            .fontWeight(.bold)
            .padding(.top, 50)
            .foregroundColor(.black)
            .multilineTextAlignment(.center)
        
        Spacer()

    }
}

#Preview {
    ContentView()
}
