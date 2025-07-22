import SwiftUI

@main
struct EmozionautiApp: App {
    @StateObject var navManager = NavigationManager()
    @StateObject var diaryViewModel = DiaryViewModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView(diaryViewModel: diaryViewModel)
                .environmentObject(navManager)
                .environmentObject(diaryViewModel)
                .onAppear {
                    UIApplication.shared.applicationIconBadgeNumber = 0
                }
        }
        
    }
}
