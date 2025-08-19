//
//  FearGameView.swift
//  Emozionauti
//
//  Created by Studente on 19/08/25.
//
import SwiftUI

struct FearGameView: View{
    @EnvironmentObject var navManager: NavigationManager
    @StateObject var viewModel = FearGame()
    var fearColor: Color
    var fearShadowColor: Color
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Metti in ordine i numeri!")
                .font(.custom("Mitr-Regular", size: 48))
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .padding(.top, 30)

            if viewModel.error {
                Text("Oops! Riprova!")
                    .foregroundColor(.red)
                    .bold()
                    .transition(.opacity)
            }

            if viewModel.correct {
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
                ForEach(Array(viewModel.numbers.enumerated()), id: \.element) { index, number in
                    if !viewModel.selectedNumbers.contains(number) {
                        let angle = (Double(index) / Double(viewModel.numbers.count) * 360 + viewModel.rotation).truncatingRemainder(dividingBy: 360)
                        let radius: CGFloat = 220
                        let rad = angle * .pi / 180
                        
                        Button(action: {
                            viewModel.handleTap(number)
                        }) {
                            Text("\(number)")
                                .font(Font.custom("Mitr-Regular", size: 100))
                                .frame(width: 100, height: 100)
                                .background(.white)
                                .foregroundColor(Color(red: 117/255, green: 48/255, blue: 212/255))
                                .clipShape(Circle())
                        }
                        .offset(x: cos(rad) * radius, y: sin(rad) * radius)
                        .rotationEffect(.degrees(-viewModel.rotation))
                    }
                }
            }
            .frame(height: 650)
            .rotationEffect(.degrees(viewModel.rotation), anchor: .center)
            .onAppear { viewModel.startRotationTimer()}
            .onDisappear { viewModel.stopRotationTimer()}           

            Spacer()
        }
        .padding()
        .animation(.easeInOut, value: viewModel.selectedNumbers)
    }

}

