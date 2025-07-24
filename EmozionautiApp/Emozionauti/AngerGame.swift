import SwiftUI

struct AngerGame: View {
    @EnvironmentObject var navManager: NavigationManager
    @State var currentIndex: Int =  0
    @State var count: Int = 0
    @State var endGame: Bool = false
    var angerColor: Color
    var angerShadowColor: Color
    let blowDetector = BlowDetector()
    
    var body: some View {
        let animationImages = [Image("Vulcano1"), Image("Vulcano2")]
        let totalDuration = 3.0
        VStack{
            Text("Soffia sul microfono per spegnere il vulcano!")
                .font(.custom("Mitr-Regular",size:50))
                .fontWeight(.bold)
                .padding(.top, 50)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
            
            if endGame {
                VStack {
                    ZStack{
                        Image("BenFattoVulcano")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 400)
                            .offset(y: -100)
                            .keyframeAnimator(initialValue: AnimationProps(), repeating: true) { content, value in
                                content
                                    .scaleEffect(y: value.verticalTrasl, anchor: .bottom)
                                    .offset(y: value.yTrasl)
                            } keyframes: { _ in
                                KeyframeTrack(\.verticalTrasl) {
                                    SpringKeyframe(0.9, duration: totalDuration * 0.30)
                                }
                            }
                        
                        Image("Vulcano3sf")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 600)
                    }
                    .padding(.top, 30)
                    Button(action: {
                        navManager.currentView = .canvas(text: "Disegna cosa ti ha fatto arrabbiare...",emozione: "Rabbia 😡")
                    }) {
                        Text("Avanti")
                            .font(.custom("Mitr-Regular", size: 30))
                            .foregroundColor(.white)
                            .frame(width: 200, height: 60)
                            .background(angerColor)
                            .cornerRadius(20)
                    }
                    .shadow(color: angerShadowColor, radius: 0, x: 5, y: 10)
                    .padding([.bottom],20)
                }
            } else {
                animationImages[currentIndex]
                    .resizable()
                    .scaledToFit()
                    .padding(.bottom, 0)
                    .position(x: 400, y: 460)
                    .keyframeAnimator(initialValue: AnimationProps(), repeating: true) { content, value in
                        content
                            .scaleEffect(y: value.verticalTrasl, anchor: .bottom)
                            .offset(y: value.yTrasl)
                    } keyframes: { _ in
                        KeyframeTrack(\.verticalTrasl) {
                            SpringKeyframe(0.9, duration: totalDuration * 0.30)
                        }
                    }
            }

            Spacer()
        }
        .onAppear {
            VulcanoAnimation()
        }
    }

    func VulcanoAnimation() {
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
            if (blowDetector.updateMeasures() == true && currentIndex == 0) || currentIndex == 1 {
                currentIndex = (currentIndex + 1) % 2
                if currentIndex == 0 {
                    count += 1
                }
                if count >= 3 {
                    timer.invalidate()
                    endGame = true
                }
            }
        }
    }
}

struct AnimationProps {
    var yTrasl = 0.0
    var verticalTrasl = 1.0
}
