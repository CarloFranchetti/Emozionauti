//serve a gestire in modo centralizzato e chiaro la navigazione tra le schermate della tua app SwiftUI, senza usare NavigationLink
import Foundation

enum NavigationViewType {
    case splash
    case home
    case parentalControl
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
    case canvas(emozione: String)
    case diario
    case parentDashboard
    case parentAccess
    case gallery
}
