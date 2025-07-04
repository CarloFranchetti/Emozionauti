//
//  MinigiocoTristezza.swift
//  Emozionauti
//
//  Created by Studente on 04/07/25.
//

import SwiftUI

struct MinigiocoTristezza: View {
    var body: some View {
        Text("Balla via la tristezza!")
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
