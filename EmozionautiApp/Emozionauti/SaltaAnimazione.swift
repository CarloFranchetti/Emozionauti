//
//  SaltaAnimazione.swift
//  Emozionauti
//
//  Created by Studente on 22/07/25.
//

import SwiftUI

struct SaltaAnimazione: View {
    var sfondo: Color
    var colore: Color
    var coloreOmbra: Color
    var nextViewAnimazione: NavigationViewType
    var nextViewMinigioco: NavigationViewType
    @EnvironmentObject var navManager: NavigationManager
    var body: some View {
        ZStack{
            Color(sfondo)
                .ignoresSafeArea()
            VStack(alignment: .center, spacing: 30){
                Button {
                    navManager.currentView = nextViewAnimazione
                } label: {
                    Text("Vai all'animazione")
                        .frame(width: 300, height: 300)
                        .background(colore)
                        .cornerRadius(20)
                        .padding()
                }
                .shadow(color: coloreOmbra, radius: 0, x: 5, y: 10)
                Button {
                    navManager.currentView = nextViewMinigioco
                } label: {
                    Image("Vai al minigioco")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 300)
                        .background(colore)
                        .cornerRadius(20)
                        .padding()
                }
                .shadow(color: coloreOmbra, radius: 0, x: 5, y: 10)
            }
            
            }
    }
}
