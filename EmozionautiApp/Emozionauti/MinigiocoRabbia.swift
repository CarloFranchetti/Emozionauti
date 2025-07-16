import SwiftUI

struct MinigiocoRabbia: View {
    @EnvironmentObject var navManager: NavigationManager
    @State var indicecorrente: Int =  0
    @State var conta: Int = 0
    @State var fineGioco: Bool = false
    var colore: Color
    var coloreOmbra: Color
    let rilevatore = RilevaSoffio()
    
    var body: some View {
        let animazioneImmagini = [Image("Vulcano1"), Image("Vulcano2")]
        let totaldur = 3.0
        VStack{
            Text("Soffia sul microfono per spegnere il vulcano!")
                .font(.custom("Mitr-Regular",size:50))
                .fontWeight(.bold)
                .padding(.top, 50)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
            
            if fineGioco {
                VStack {
                    Image("BenFattoVulcano")
                        .resizable()
                        .scaledToFit()
                        .padding(.bottom, 0)
                        .frame(width: 800, height: 800)
                        .position(x: 400, y: 200)
                        .keyframeAnimator(initialValue: AnimazioneProps(), repeating: true) { content, value in
                            content
                                .scaleEffect(y: value.verticalTrasl, anchor: .bottom)
                                .offset(y: value.yTrasl)
                        } keyframes: { _ in
                            KeyframeTrack(\.verticalTrasl) {
                                SpringKeyframe(0.9, duration: totaldur * 0.30)
                            }
                        }

                    Image("Vulcano3sf")
                        .resizable()
                        .position(x: 300, y: 260)
                        .scaledToFit()
                        .frame(width: 800, height: 800)
                    Button(action: {
                        navManager.currentView = .canvas(emozione: "Rabbia 😡")
                    }) {
                        Text("Avanti")
                            .font(.custom("Mitr-Regular", size: 30))
                            .foregroundColor(.white)
                            .frame(width: 200, height: 200)
                            .background(colore)
                            .cornerRadius(20)
                    }
                    .shadow(color: coloreOmbra, radius: 0, x: 5, y: 10)
                    .position(x: 400, y: 550)
                }
            } else {
                animazioneImmagini[indicecorrente]
                    .resizable()
                    .scaledToFit()
                    .padding(.bottom, 0)
                    .position(x: 400, y: 460)
                    .keyframeAnimator(initialValue: AnimazioneProps(), repeating: true) { content, value in
                        content
                            .scaleEffect(y: value.verticalTrasl, anchor: .bottom)
                            .offset(y: value.yTrasl)
                    } keyframes: { _ in
                        KeyframeTrack(\.verticalTrasl) {
                            SpringKeyframe(0.9, duration: totaldur * 0.30)
                        }
                    }
            }

            Spacer()
        }
        .onAppear {
            VulcanoAnimazione()
        }
    }

    func VulcanoAnimazione() {
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
            if (rilevatore.aggiornaVol() == true && indicecorrente == 0) || indicecorrente == 1 {
                indicecorrente = (indicecorrente + 1) % 2
                if indicecorrente == 0 {
                    conta += 1
                }
                if conta >= 3 {
                    timer.invalidate()
                    fineGioco = true
                }
            }
        }
    }
}

struct AnimazioneProps {
    var yTrasl = 0.0
    var verticalTrasl = 1.0
}
