//
//  GestioneAnimazioni.swift
//  Emozionauti
//
//  Created by Studente on 22/07/25.
//

import SwiftUI


class GestioneAnimazioniModel: ObservableObject{
    @Published var impostazioneSel: String = "Mai"
}

struct GestioneAnimazioniView: View{
    @EnvironmentObject private var impostazioni: GestioneAnimazioniModel
    @EnvironmentObject var navigationManager: NavigationManager

    private let frequenza = [
        "Mai",
        "Una volta per ogni emozione",
        "Sempre"
    ]
    
    var body: some View{
        ZStack{
            VStack{
                List{
                    Section(header: Text("Gestione Animazioni")){
                        HStack{
                            Text("Quante volte al giorno vuoi che sia possibile saltare le animazioni?")
                                .fontWeight(.bold)
                            DropDownMenu(title: "Frequenza", options: frequenza, selezionatoE: $impostazioni.impostazioneSel)
                            
                        }
                        .padding(20)
                        .fixedSize(horizontal: false, vertical: false)
                    }
                }
                    
                Spacer()
            }
        }
        }
}
