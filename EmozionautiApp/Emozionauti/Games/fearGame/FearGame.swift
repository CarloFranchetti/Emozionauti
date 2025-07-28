//
//  FearGame.swift
//  Emozionauti
//
//  Created by Studente on 4/07/25.
//

import SwiftUI
import AudioToolbox

struct FearGame: View {
    @EnvironmentObject var navManager: NavigationManager
    @State private var numbers = Array(1...7).shuffled()
    @State private var nextNumber = 1
    @State private var selectedNumbers: Set<Int> = []
    @State private var error = false
    @State private var correct = false
    @State var rotation = 0.0
    var fearColor: Color
    var fearShadowColor: Color
    @State private var timer: Timer?
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Metti in ordine i numeri!")
                .font(.custom("Mitr-Regular", size: 48))
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .padding(.top, 30)

            if error {
                Text("Oops! Riprova!")
                    .foregroundColor(.red)
                    .bold()
                    .transition(.opacity)
            }

            if correct {
                VStack(spacing: 20) {
                    Text("BEN FATTO!")
                        .foregroundColor(fearColor)
                        .font(.custom("Modak", size: 50))
                    Spacer();
                    Button(action: {
                        navManager.currentView = .canvas(text: "Disegna cosa ti ha messo paura...",emotion: "Paura 😨")
                    }) {
                        Text("Avanti")
                            .font(.custom("Mitr-Regular", size: 36))
                            .foregroundColor(.white)
                            .frame(width: 200, height: 60)
                            .background(fearColor)
                            .cornerRadius(25)
                            .shadow(color: fearShadowColor, radius: 0, x: 10, y: 10)
                    }
                }
            }

            ZStack {
                ForEach(Array(numbers.enumerated()), id: \.element) { index, number in
                    if !selectedNumbers.contains(number) {
                        let angle = (Double(index) / Double(numbers.count) * 360 + rotation).truncatingRemainder(dividingBy: 360)
                        let radius: CGFloat = 220
                        let rad = angle * .pi / 180
                        
                        Button(action: {
                            handleTap(number)
                        }) {
                            Text("\(number)")
                                .font(Font.custom("Mitr-Regular", size: 100))
                                .frame(width: 100, height: 100)
                                .background(.white)
                                .foregroundColor(Color(red: 117/255, green: 48/255, blue: 212/255))
                                .clipShape(Circle())
                        }
                        .offset(x: cos(rad) * radius, y: sin(rad) * radius)
                        .rotationEffect(.degrees(-rotation))
                    }
                }
            }
            .frame(height: 650)
            .rotationEffect(.degrees(rotation), anchor: .center)
            .onAppear {
                timer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { _ in
                    rotation += 1
                    if rotation >= 360 {
                        rotation = 0
                    }
                }
            }
            .onDisappear {
                timer?.invalidate()
            }
            

            Spacer()
        }
        .padding()
        .animation(.easeInOut, value: selectedNumbers)
    }

    func handleTap(_ number: Int) {
        if number == nextNumber {
            correctSound()
            selectedNumbers.insert(number)
            nextNumber += 1

            if nextNumber > 7 {
                correct = true
            }
        } else {
            error = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                error = false
                resetGame()
            }
        }
    }

    func resetGame() {
        numbers = Array(1...7).shuffled()
        nextNumber = 1
        selectedNumbers = []
    }

    func correctSound() {
        AudioServicesPlaySystemSound(1104)
    }

}

