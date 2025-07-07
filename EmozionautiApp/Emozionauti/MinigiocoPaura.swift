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
                NavigationLink(destination:ContentView1()){
                        Text("Prosegui")
                        .font(.custom("Mitr-Regular",size:30))
                        .foregroundColor(.white)
                        .frame(width: 200, height: 200)
                        .background(.black)
                        .position(x:400,y:550)
                }
            }

            ZStack {
                ForEach(Array(numbers.enumerated()), id: \.element) { index, number in
                    if !selectedNumbers.contains(number) {
                        let angle = Double(index) / Double(numbers.count) * 2 * .pi
                        let radius: CGFloat = 220 // distanza dal centro
                        
                        
                        
                        Button(action: {
                            handleTap(number)
                        }) {
                            Text("\(number)")
                                .font(Font.custom("Mitr-Regular", size: 100))
                                .frame(width: 100, height: 100)
                                .background(.white)
                                .foregroundColor((Color(red: 117/255, green: 48/255, blue: 212/255)))
                                .clipShape(Circle())
                                //.shadow(radius: 4)
                        }
                        .offset(x: cos(angle) * radius, y: sin(angle) * radius)
                    }
                }
            }
            .frame(height: 650)
            
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
                //DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                   // presentationMode.wrappedValue.dismiss()
               // }
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
