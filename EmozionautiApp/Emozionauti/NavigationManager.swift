import SwiftUI

class NavigationManager: ObservableObject {
    @Published var currentView: NavigationViewType = .splash

    func goBack() {
        switch currentView {
        case .animazioneRabbia, .animazioneFelicita, .animazionePaura, .animazioneNoia, .animazioneTristezza:
            currentView = .home
        case .minigiocoRabbia:
            currentView = .animazioneRabbia
        case .minigiocoFelicita:
            currentView = .animazioneFelicita
        case .minigiocoPaura:
            currentView = .animazionePaura
        case .minigiocoNoia:
            currentView = .animazioneNoia
        case .minigiocoTristezza:
            currentView = .animazioneTristezza
        case .canvas:
            currentView = .home // oppure da quale minigioco è arrivato
        case .diario:
            currentView = .home
        default:
            break
        }
    }

    var showBackButton: Bool {
        switch currentView {
        case .home, .splash, .canvas:
            return false
        default:
            return true
        }
    }
}
