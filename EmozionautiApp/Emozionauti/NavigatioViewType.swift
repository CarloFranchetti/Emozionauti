//serve a gestire in modo centralizzato e chiaro la navigazione tra le schermate della tua app SwiftUI, senza usare NavigationLink
import Foundation

enum NavigationViewType {
    case splash
    case home
    case parentalControl //Sfondo richiesta password
    case animazioneRabbia
    case animazioneFelicita
    case animazionePaura
    case animazioneNoia
    case animazioneTristezza
    case minigiocoRabbia
    case minigiocoFelicita2
    case minigiocoPaura
    case minigiocoNoia
    case minigiocoTristezza
    case diario //Stats
    case parentDashboard
    case canvas(text: String, emozione: String)
    case gestoreAnimazioni
    case gallery
    case notificationSettings
    case saltaAnimazioneRabbia
    case saltaAnimazioneFelicita
    case saltaAnimazioneTristezza
    case saltaAnimazioneNoia
    case saltaAnimazionePaura   
}
