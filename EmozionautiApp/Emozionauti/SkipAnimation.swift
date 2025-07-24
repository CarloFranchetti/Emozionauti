//
//  SaltaAnimazione.swift
//  Emozionauti
//
//  Created by Studente on 22/07/25.
//

import SwiftUI

struct SkipAnimation: View {
    var emotion : String
    var background: Color
    var animationColor: Color
    var animationShadowColor: Color
    var disableAnimation : Bool = false
    var disableGame : Bool = false
    @State var nextViewAnimazione: NavigationViewType
    @State var nextViewMinigioco: NavigationViewType
    @EnvironmentObject var navManager: NavigationManager
    @EnvironmentObject var animationSetting : GestioneAnimazioniModel
    @EnvironmentObject var diaryViewModel: DiaryViewModel
    
    func skip () -> (Bool){
        let today = Calendar.current.startOfDay(for: Date())
        print(diaryViewModel.emotionHistory)
        return diaryViewModel.emotionHistory.contains{ item in
            Calendar.current.isDate(item.date, inSameDayAs: today) && item.emotion == emotion
        }
    
    }
    func disableButtons(sel: String) -> (disableAnimation: Bool, disableGame: Bool) {
        switch sel {
        case "Sempre":
            return (false, true)
        case "Mai":
            return (false, false)
        case "Una volta per ogni emozione":
            return (false, !skip())
        default:
            return (false, false)
        }
    }

    var body: some View {
        let setting = animationSetting.impostazioneSel
        let state = disableButtons(sel: setting)
        ZStack{
            Color(background)
                .ignoresSafeArea()
            VStack(alignment: .center, spacing: 30){
                Button (
                    action: {
                        diaryViewModel.recordEmotion(emotion)
                        navManager.currentView = nextViewAnimazione
                    }
                ){ Text("Vai all'animazione")
                        .font(.custom("Mitr-regular", size: 45))
                        .frame(width: 500, height: 100)
                        .background(animationColor)
                        .cornerRadius(20)
                        .foregroundColor(.white)
                        .padding()
                        
                }
                .shadow(color: animationShadowColor, radius: 0, x: 5, y: 10)
                .disabled(state.disableAnimation)
                Button (
                    action:{
                        diaryViewModel.recordEmotion(emotion)
                        navManager.currentView = nextViewMinigioco
                    }
                ){ Text("Vai al minigioco")
                        .font(.custom("Mitr-regular", size: 45))
                        .frame(width: 500, height: 100)
                        .background(animationColor)
                        .cornerRadius(20)
                        .foregroundColor(.white)
                        .opacity(state.disableGame ? 0.5 : 1)
                        .padding()
                }
                .shadow(color: animationShadowColor, radius: 0, x: 5, y:10)
                .opacity(state.disableGame ? 0 : 1) //decidere se mettere 0.5 o lasciare 0
                .disabled(state.disableGame)
            }
        }
    }
}
