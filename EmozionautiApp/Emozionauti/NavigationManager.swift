import SwiftUI

class NavigationManager: ObservableObject {
    @Published var currentView: NavigationViewType = .splash
    @Published var dettaglioAperto: Bool = false

    func goBack() {
        switch currentView {
        case .angerAnimation:
            currentView = .skipAngerAnimation
        case .happinessAnimation:
            currentView = .skipHappinessAnimation
        case .fearAnimation:
            currentView = .skipFearAnimation
        case .boredomAnimation:
            currentView = .skipBoredomAnimation
        case .sadnessAnimation:
            currentView = .skipSadnessAnimation
        case .angerGame:
            currentView = .angerAnimation
        case .happinessGame:
            currentView = .happinessAnimation
        case .fearGame:
            currentView = .fearAnimation
        case .boredomGame:
            currentView = .boredomAnimation
        case .sadnessGame:
            currentView = .sadnessAnimation
        case .canvas:
            currentView = .home
        case .diary:
            currentView = .parentDashboard
        case .parentalControl:
                currentView = .home
        case .gallery:
            currentView = .parentDashboard
        case .skipAngerAnimation:
            currentView = .home
        case .skipBoredomAnimation:
            currentView = .home
        case .skipSadnessAnimation:
            currentView = .home
        case .skipHappinessAnimation:
            currentView = .home
        case .skipFearAnimation:
            currentView = .home
        case .animationManager:
            currentView = .parentDashboard
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
