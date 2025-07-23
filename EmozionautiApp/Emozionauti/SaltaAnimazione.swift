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
                Button (
                    action: {navManager.currentView = nextViewAnimazione}
                ){ Text("Vai all'animazione")
                        .font(.custom("Mitr-regular", size: 45))
                        .frame(width: 500, height: 100)
                        .background(colore)
                        .cornerRadius(20)
                        .foregroundColor(.white)
                        .padding()
                }
                .shadow(color: coloreOmbra, radius: 0, x: 5, y: 10)
                Button (
                    action:{navManager.currentView = nextViewMinigioco}
                ){ Text("Vai al minigioco")
                        .font(.custom("Mitr-regular", size: 45))
                        .frame(width: 500, height: 100)
                        .background(colore)
                        .cornerRadius(20)
                        .foregroundColor(.white)
                        .padding()
                }
                .shadow(color: coloreOmbra, radius: 0, x: 5, y:10)
            }
        }
    }
}
