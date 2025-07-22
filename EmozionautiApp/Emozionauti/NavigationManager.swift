import SwiftUI

class NavigationManager: ObservableObject {
    @Published var currentView: NavigationViewType = .splash
    @Published var dettaglioAperto: Bool = false

    func goBack() {
        switch currentView {
        case .animazioneRabbia:
            currentView = .saltaAnimazioneRabbia
        case .animazioneFelicita:
            currentView = .saltaAnimazioneFelicita
        case .animazionePaura:
            currentView = .saltaAnimazionePaura
        case .animazioneNoia:
            currentView = .saltaAnimazioneNoia
        case .animazioneTristezza:
            currentView = .saltaAnimazioneTristezza
        case .minigiocoRabbia:
            currentView = .animazioneRabbia
        case .minigiocoFelicita2:
            currentView = .animazioneFelicita
        case .minigiocoPaura:
            currentView = .animazionePaura
        case .minigiocoNoia:
            currentView = .animazioneNoia
        case .minigiocoTristezza:
            currentView = .animazioneTristezza
        case .canvas:
            currentView = .home
        case .diario:
            currentView = .parentDashboard
        case .parentalControl:
                currentView = .home
        case .gallery:
            currentView = .parentDashboard
        case .saltaAnimazioneRabbia:
            currentView = .home
        case .saltaAnimazioneNoia:
            currentView = .home
        case .saltaAnimazioneTristezza:
            currentView = .home
        case .saltaAnimazioneFelicita:
            currentView = .home
        case .saltaAnimazionePaura:
            currentView = .home
        default:
            break
        }
    }

    var showBackButton: Bool {
        if dettaglioAperto{
            return false
        }
        switch currentView {
        case .home, .splash, .canvas, .parentDashboard:
            return false
        default:
            return true
        }
    }
}
