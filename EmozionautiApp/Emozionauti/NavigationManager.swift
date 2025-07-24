import SwiftUI

class NavigationManager: ObservableObject {
    @Published var currentView: NavigationViewType = .splash
    @Published var dettaglioAperto: Bool = false

    func goBack() {
        switch currentView {
        case .animazioneRabbia, .animazioneFelicita, .animazionePaura, .animazioneNoia, .animazioneTristezza:
            currentView = .home
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
        case .notificationSettings:
            NotificationSettingsView()
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
