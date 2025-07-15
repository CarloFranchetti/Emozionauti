import SwiftUI

@main
struct EmozionautiApp: App {
    @StateObject var navManager = NavigationManager()
    @StateObject var diaryViewModel = DiaryViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView(diaryViewModel: diaryViewModel)
                .environmentObject(navManager)
                .environmentObject(diaryViewModel)
        }
    }
}
