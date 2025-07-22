import SwiftUI
import AudioToolbox

struct MinigiocoPaura: View {
    @EnvironmentObject var navManager: NavigationManager

    @State private var numeri = Array(1...7).shuffled()
    @State private var proxNumero = 1
    @State private var numeriSelezionati: Set<Int> = []
    @State private var errore = false
    @State private var corretto = false
    @State var rotazione = 0.0
    var colorePaura: Color
    var colorePauraOmbra: Color
    @State private var timer: Timer?
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Metti in ordine i numeri!")
                .font(.custom("Mitr-Regular", size: 48))
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .padding(.top, 30)

            if errore {
                Text("Oops! Riprova!")
                    .foregroundColor(.red)
                    .bold()
                    .transition(.opacity)
            }

            if corretto {
                VStack(spacing: 20) {
                    Text("BEN FATTO!")
                        .foregroundColor(colorePaura)
                        .font(.custom("Modak", size: 50))
                    Spacer();
                    Button(action: {
                        navManager.currentView = .canvas(text: "Disegna cosa ti ha messo paura...",emozione: "Paura 😨")
                    }) {
                        Text("Avanti")
                            .font(.custom("Mitr-Regular", size: 36))
                            .foregroundColor(.white)
                            .frame(width: 300, height: 100)
                            .background(colorePaura)
                            .cornerRadius(25)
                            .shadow(color: colorePauraOmbra, radius: 0, x: 10, y: 10)
                    }
                }
            }

            ZStack {
                ForEach(Array(numeri.enumerated()), id: \.element) { index, numero in
                    if !numeriSelezionati.contains(numero) {
                        let angolo = (Double(index) / Double(numeri.count) * 360 + rotazione).truncatingRemainder(dividingBy: 360)
                        let raggio: CGFloat = 220
                        let rad = angolo * .pi / 180
                        
                        Button(action: {
                            handleTap(numero)
                        }) {
                            Text("\(numero)")
                                .font(Font.custom("Mitr-Regular", size: 100))
                                .frame(width: 100, height: 100)
                                .background(.white)
                                .foregroundColor(Color(red: 117/255, green: 48/255, blue: 212/255))
                                .clipShape(Circle())
                        }
                        .offset(x: cos(rad) * raggio, y: sin(rad) * raggio)
                        .rotationEffect(.degrees(-rotazione))
                    }
                }
            }
            .frame(height: 650)
            .rotationEffect(.degrees(rotazione), anchor: .center)
            .onAppear {
                timer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { _ in
                    rotazione += 1
                    if rotazione >= 360 {
                        rotazione = 0
                    }
                }
            }
            .onDisappear {
                timer?.invalidate()
            }
            

            Spacer()
        }
        .padding()
        .animation(.easeInOut, value: numeriSelezionati)
    }

    func handleTap(_ numero: Int) {
        if numero == proxNumero {
            playSuccessSound()
            numeriSelezionati.insert(numero)
            proxNumero += 1

            if proxNumero > 7 {
                corretto = true
            }
        } else {
            errore = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                errore = false
                resetGioco()
            }
        }
    }

    func resetGioco() {
        numeri = Array(1...7).shuffled()
        proxNumero = 1
        numeriSelezionati = []
    }

    func playSuccessSound() {
        AudioServicesPlaySystemSound(1104)
    }

}

