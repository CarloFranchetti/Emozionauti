import SwiftUI

struct ParentAccessView: View {
    @State private var enteredPIN: String = ""
    @State private var accessGranted: Bool = false
    @State private var showError: Bool = false
    
    private let storedPINKey = "parentPIN"
    private let defaultPIN = "4321"
    
    var body: some View {
        if accessGranted {
            ParentDashboardView()
        } else {
            VStack(spacing: 20) {
                Text("Area Genitori")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)

                SecureField("Inserisci PIN (4 cifre)", text: $enteredPIN)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .frame(width: 200)
                
                Button("Accedi") {
                    let savedPIN = UserDefaults.standard.string(forKey: storedPINKey) ?? defaultPIN
                    if enteredPIN == savedPIN {
                        accessGranted = true
                        showError = false
                    } else {
                        showError = true
                        enteredPIN = ""
                    }
                }
                .buttonStyle(.borderedProminent)

                if showError {
                    Text("PIN errato. Riprova.")
                        .foregroundColor(.red)
                        .font(.subheadline)
                }

                Spacer()
            }
            .padding()
        }
    }
}
