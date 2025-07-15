import SwiftUI
import LocalAuthentication

struct ParentAccessView: View {
    @State private var accessGranted: Bool = false
    @State private var showError: Bool = false
    @State private var authenticationAttempted = false
    
    var body: some View {
        Group {
            if accessGranted {
                ParentDashboardView()
            } else {
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
                .onAppear {
                    // Avvia l'autenticazione solo una volta
                    if !authenticationAttempted {
                        authenticationAttempted = true
                        authenticate()
                    }
                }
            }
        }
    }

    func authenticate() {
        let context = LAContext()
        var error: NSError?

        // `.deviceOwnerAuthentication` = biometria + codice dispositivo
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
            // Biometria o codice non disponibili
            showError = true
        }
    }
}
