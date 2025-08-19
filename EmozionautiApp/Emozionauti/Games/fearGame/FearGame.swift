//
//  FearGame.swift
//  Emozionauti
//
//  Created by Studente on 4/07/25.
//

import SwiftUI
import AudioToolbox

class FearGame: ObservableObject {

    @Published var numbers = Array(1...7).shuffled()
    @Published var nextNumber = 1
    @Published var selectedNumbers: Set<Int> = []
    @Published var error = false
    @Published var correct = false
    @Published var rotation = 0.0

    var timer: Timer?
    

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
                self.error = false
                self.resetGame()
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
    
    func startRotationTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { _ in
            self.rotation += 1
            if self.rotation >= 360 {
                self.rotation = 0
                
            }
        }
    }
    
    func stopRotationTimer(){
        timer?.invalidate()
        timer = nil
    }

}

