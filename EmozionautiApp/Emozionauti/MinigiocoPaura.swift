import SwiftUI
import AudioToolbox

struct MinigiocoPaura: View {
    @Environment(\.dismiss) var dismiss // ← Per tornare indietro
    @State private var numbers = Array(1...7).shuffled()
    @State private var nextNumber = 1
    @State private var selectedNumbers: Set<Int> = []
    @State private var showError = false
    @State private var showSuccess = false

    var body: some View {
        VStack(spacing: 30) {
            Text("Metti in ordine i numeri!")
                .font(.custom("Mitr-Regular", size: 48))
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .padding(.top, 30)

            if showError {
                Text("Oops! Riprova!")
                    .foregroundColor(.red)
                    .bold()
                    .transition(.opacity)
            }

            if showSuccess {
                Text("🎉 Ben fatto! 🎉")
                    .foregroundColor(.green)
                    .font(.title)
                    .bold()
                    .transition(.opacity)
            }

            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 4), spacing: 20) {
                ForEach(numbers, id: \.self) { number in
                    if !selectedNumbers.contains(number) {
                        Button(action: {
                            handleTap(number)
                        }) {
                            Text("\(number)")
                                .font(.title)
                                .frame(width: 160, height: 160)
                                .background(Color.blue.opacity(0.9))
                                .foregroundColor(.white)
                                .clipShape(Circle())
                        }
                    }
                }
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding()
        .animation(.easeInOut, value: selectedNumbers)
    }

    @Environment(\.presentationMode) var presentationMode

    func handleTap(_ number: Int) {
        if number == nextNumber {
            playSuccessSound()
            selectedNumbers.insert(number)
            nextNumber += 1

            if nextNumber > 7 {
                showSuccess = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        } else {
            playErrorSound()
            showError = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                showError = false
                resetGame()
            }
        }
    }

    func resetGame() {
        numbers = Array(1...7).shuffled()
        nextNumber = 1
        selectedNumbers = []
    }
    
    func playSuccessSound() {
        AudioServicesPlaySystemSound(1104) // Suono "pop"
    }

    func playErrorSound() {
        AudioServicesPlaySystemSound(1023) // Suono errore
    }
}
