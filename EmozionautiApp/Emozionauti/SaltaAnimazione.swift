//
//  SaltaAnimazione.swift
//  Emozionauti
//
//  Created by Studente on 22/07/25.
//

import SwiftUI

struct SaltaAnimazione: View {
    var emozione : String
    var sfondo: Color
    var colore: Color
    var coloreOmbra: Color
    var disabilitaAnimazione : Bool = false
    var disabilitaMinigioco : Bool = false
    @State var nextViewAnimazione: NavigationViewType
    @State var nextViewMinigioco: NavigationViewType
    @EnvironmentObject var navManager: NavigationManager
    @EnvironmentObject var impostazioneAnimazione : GestioneAnimazioniModel
    @EnvironmentObject var diaryViewModel: DiaryViewModel
    
    func salta () -> (Bool){
        let oggi = Calendar.current.startOfDay(for: Date())
        print(diaryViewModel.emotionHistory)
        return diaryViewModel.emotionHistory.contains{ item in
            Calendar.current.isDate(item.date, inSameDayAs: oggi) && item.emotion == emozione
        }
    
    }
    
    func calcolaDisabilitazioni(sel: String) -> (disabilitaAnimazione: Bool, disabilitaMinigioco: Bool) {
        switch sel {
        case "Sempre":
            return (false, true)
        case "Mai":
            return (false, false)
        case "Una volta per ogni emozione":
            return (false, !salta())
        default:
            return (false, false)
        }
    }

    var body: some View {
        let impostazione = impostazioneAnimazione.impostazioneSel
        let stato = calcolaDisabilitazioni(sel: impostazione)
        ZStack{
            Color(sfondo)
                .ignoresSafeArea()
            VStack(alignment: .center, spacing: 30){
                Button (
                    action: {
                        diaryViewModel.recordEmotion(emozione)
                        navManager.currentView = nextViewAnimazione
                    }
                ){ Text("Vai all'animazione")
                        .font(.custom("Mitr-regular", size: 45))
                        .frame(width: 500, height: 100)
                        .background(colore)
                        .cornerRadius(20)
                        .foregroundColor(.white)
                        .padding()
                        
                }
                .shadow(color: coloreOmbra, radius: 0, x: 5, y: 10)
                .disabled(stato.disabilitaAnimazione)
                Button (
                    action:{
                        diaryViewModel.recordEmotion(emozione)
                        navManager.currentView = nextViewMinigioco
                    }
                ){ Text("Vai al minigioco")
                        .font(.custom("Mitr-regular", size: 45))
                        .frame(width: 500, height: 100)
                        .background(colore)
                        .cornerRadius(20)
                        .foregroundColor(.white)
                        .opacity(stato.disabilitaMinigioco ? 0.5 : 1)
                        .padding()
                }
                .shadow(color: coloreOmbra, radius: 0, x: 5, y:10)
                .opacity(stato.disabilitaMinigioco ? 0 : 1) //decidere se mettere 0.5 o lasciare 0
                .disabled(stato.disabilitaMinigioco)
            }
        }
    }
}
