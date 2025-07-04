import SwiftUI

struct ContentView: View {
    @State private var showSplash = true

    var body: some View {
        ZStack {
            if showSplash {
                SchermataIcona()
                    .transition(.opacity)
            } else {
                SchermataHome() // o ParentDashboardView()
                    .transition(.opacity)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                withAnimation {
                    showSplash = false
                }
            }
        }
    }
}
