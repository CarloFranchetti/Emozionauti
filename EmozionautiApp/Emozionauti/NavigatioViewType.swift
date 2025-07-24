//serve a gestire in modo centralizzato e chiaro la navigazione tra le schermate della tua app SwiftUI, senza usare NavigationLink
import Foundation

enum NavigationViewType {
    case splash
    case home
    case parentalControl //Sfondo richiesta password
    case angerAnimation
    case happinessAnimation
    case fearAnimation
    case boredomAnimation
    case sadnessAnimation
    case angerGame
    case happinessGame
    case fearGame
    case boredomGame
    case sadnessGame
    case diary //Stats
    case parentDashboard
    case canvas(text: String, emozione: String)
    case animationManager
    case gallery
    case skipAngerAnimation
    case skipHappinessAnimation
    case skipSadnessAnimation
    case skipBoredomAnimation
    case skipFearAnimation
}
