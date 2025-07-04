import SwiftUI

struct SettingsView: View {
    @AppStorage("speechEnabled") private var speechEnabled: Bool = true
    @StateObject private var diaryVM = DiaryViewModel()
    
    @State private var showResetAlert = false
    @State private var currentPIN = ""
    @State private var newPIN = ""
    @State private var confirmPIN = ""
    @State private var pinChangeMessage = ""

    private let storedPINKey = "parentPIN"
    private let defaultPIN = "4321"

    var body: some View {
        Form {
            // Audio Toggle
            Section(header: Text("Audio")) {
                Toggle(isOn: $speechEnabled) {
                    Label("Sintesi vocale attiva", systemImage: "speaker.wave.2.fill")
                }
            }

            // Reset Emozioni
            Section(header: Text("Dati")) {
                Button(role: .destructive) {
                    showResetAlert = true
                } label: {
                    Label("Reset emozioni", systemImage: "trash.fill")
                        .foregroundColor(.red)
                }
            }

            // Cambio PIN
            Section(header: Text("Sicurezza")) {
                SecureField("PIN attuale", text: $currentPIN)
                SecureField("Nuovo PIN", text: $newPIN)
                SecureField("Conferma nuovo PIN", text: $confirmPIN)

                Button("Cambia PIN") {
                    let savedPIN = UserDefaults.standard.string(forKey: storedPINKey) ?? defaultPIN
                    if currentPIN != savedPIN {
                        pinChangeMessage = "Il PIN attuale è errato."
                    } else if newPIN.count != 4 || !newPIN.allSatisfy(\.isNumber) {
                        pinChangeMessage = "Il nuovo PIN deve avere 4 cifre."
                    } else if newPIN != confirmPIN {
                        pinChangeMessage = "I PIN non corrispondono."
                    } else {
                        UserDefaults.standard.set(newPIN, forKey: storedPINKey)
                        pinChangeMessage = "PIN aggiornato con successo!"
                        currentPIN = ""
                        newPIN = ""
                        confirmPIN = ""
                    }
                }
            }

            if !pinChangeMessage.isEmpty {
                Section {
                    Text(pinChangeMessage)
                        .foregroundColor(pinChangeMessage.contains("perfetto") ? .green : .red)
                }
            }
        }
        .navigationTitle("Impostazioni")
        .alert("Sei sicuro di voler cancellare tutte le emozioni?", isPresented: $showResetAlert) {
            Button("Annulla", role: .cancel) {}
            Button("Conferma", role: .destructive) {
                diaryVM.resetStats()
            }
        }
    }
}
