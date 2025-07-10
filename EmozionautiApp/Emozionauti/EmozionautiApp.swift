import SwiftUI

@main
struct EmozionautiApp: App {
    @StateObject var navManager = NavigationManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(navManager) // 
        }
    }
}
