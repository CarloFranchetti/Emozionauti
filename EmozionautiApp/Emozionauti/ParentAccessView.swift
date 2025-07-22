import SwiftUI
import LocalAuthentication

struct ParentAccessView: View {
    @State private var accessGranted: Bool = false
    @State private var showError: Bool = false
    @State private var authenticationAttempted = false
    @EnvironmentObject var navManager: NavigationManager

    var body: some View {
        VStack(spacing: 20) {
            Text("Area Genitori")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)

            if showError {
                Text("Autenticazione fallita. Riprova.")
                    .foregroundColor(.red)
            }

            Button("Riprova") {
                authenticate()
            }
            .buttonStyle(.borderedProminent)

            Spacer()
        }
        .padding()
        .navigationBarBackButtonHidden(true) //Nasconde il pulsante back
        .onAppear {
            if !authenticationAttempted {
                authenticationAttempted = true
                authenticate()
            }
        }
        .onChange(of: accessGranted) { granted in
            if granted {
                navManager.currentView = .parentDashboard
            }
        }
    }

    func authenticate() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reason = "Autenticati per accedere all'Area Genitori"
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, _ in
                DispatchQueue.main.async {
                    if success {
                        accessGranted = true
                    } else {
                        showError = true
                    }
                }
            }
        } else {
            showError = true
        }
    }
}
