//
//  MinigiocoFelicita2.swift
//  Emozionauti
//
//  Created by Studente on 17/07/25.
//

import SpriteKit
import SwiftUI

class HappinessGameViewModel: ObservableObject {
    @Published var endGame = false
    var happinessColor: UIColor
    var backgroundColor: UIColor
    
    init(happinessColor: UIColor, backgroundColor: UIColor){
        self.happinessColor = happinessColor
        self.backgroundColor = backgroundColor
    }
}



class HappinessGame: SKScene {
    let astronautsNames = ["astronaut1", "astronaut2", "astronaut3", "astronaut4", "astronaut5", "astronaut6"]
    let planetNames = ["planet1", "planet2", "planet3", "planet4","planet5","planet6"]
    var currAstronaut: SKSpriteNode?
    var timeLeft = 30
    var timerName: SKLabelNode!
    var detailGame: SKLabelNode!
    var endMessage: SKLabelNode!
    var gameTimer: Timer?
    var score = 0
    var endGameText: SKLabelNode!
    var scoreText: SKLabelNode!
    var viewModel: HappinessGameViewModel?
    var background: SKSpriteNode!
    var stars: [SKShapeNode] = []
    var planets: [SKSpriteNode] = []

    
    override func didMove(to view: SKView){
        if let backgroundColor = viewModel?.backgroundColor{
            background = SKSpriteNode(color: backgroundColor, size:size)
            background.position = CGPoint(x: size.width/2, y: size.height/2)
            background.zPosition = -1
            addChild(background)
        }
        for _ in 0..<50 {
            let star = SKShapeNode(circleOfRadius: CGFloat.random(in: 1...3))
            star.fillColor = .yellow
            star.strokeColor = .clear
            star.position = CGPoint(x: CGFloat.random(in: 0...size.width),
                                    y: CGFloat.random(in: 0...size.height))
            star.alpha = 0
            
            addChild(star)
            stars.append(star)
            
            let fadeIn = SKAction.fadeAlpha(to: 1, duration: Double.random(in: 0.5...1.5))
            let fadeOut = SKAction.fadeAlpha(to: 0, duration: Double.random(in: 0.5...1.5))
            let wait = SKAction.wait(forDuration: Double.random(in: 0...2))
            let blink = SKAction.sequence([wait, fadeIn, fadeOut])
            let blinkLoop = SKAction.repeatForever(blink)
            
            star.run(blinkLoop)
        }
        let border = 100.0
        for _ in 0..<7{
            let randomName = planetNames.randomElement()!
            let planet = SKSpriteNode(imageNamed: randomName)
            planet.position = CGPoint(x: CGFloat.random(in: border...size.width - border), y: CGFloat.random(in: border...size.height - border))
            planet.setScale(0.2)
            planet.alpha = 0.5
            addChild(planet)
            planets.append(planet)
            
            let fadeIn = SKAction.fadeAlpha(to: 0.5, duration: Double.random(in: 0.5...1.5))
            let fadeOut = SKAction.fadeAlpha(to: 0, duration: Double.random(in: 0.5...1.5))
            let wait = SKAction.wait(forDuration: Double.random(in: 0...2))
            let blink = SKAction.sequence([wait, fadeIn, fadeOut])
            let blinkLoop = SKAction.repeatForever(blink)
            
            planet.run(blinkLoop)
        }
        timerName = SKLabelNode(text: "Tempo: 30")
        timerName.position = CGPoint(x: size.width - 100, y: size.height - 50)
        timerName.fontSize = 24
        timerName.fontName = "Mitr-Regular"
        timerName.horizontalAlignmentMode = .right
        addChild(timerName)
        detailGame = SKLabelNode(text: "Premi sugli astronauti!")
        detailGame.position = CGPoint(x: size.width/2, y: size.height - 100)
        detailGame.fontSize = 50
        detailGame.fontName = "Mitr-Regular"
        detailGame.horizontalAlignmentMode = .center
        addChild(detailGame)
        
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.timeLeft -= 1
            self.timerName.text = "Tempo: \(self.timeLeft)"
            
            if self.timeLeft <= 0 {
                self.gameTimer?.invalidate()
                self.currAstronaut?.removeFromParent()
                self.endGame()
            }
        }
        spawnAstronaut()

    }
    
    func spawnAstronaut(){
        currAstronaut?.removeFromParent()
        let randomName = astronautsNames.randomElement()!
        let astronaut = SKSpriteNode(imageNamed: randomName)
        astronaut.name = "astronauta"
        let randomX = CGFloat.random(in: 100...(size.width - 100))
        let randomY = CGFloat.random(in: 100...(size.height - 200))
        astronaut.position = CGPoint(x: randomX, y: randomY)
        
        astronaut.setScale(0.5)
        
        addChild(astronaut)
        currAstronaut = astronaut
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }

                let position = touch.location(in: self)
                
                if let touched = atPoint(position) as? SKSpriteNode, touched.name == "astronauta" {
                    score+=1
                    touched.run(SKAction.sequence([
                        SKAction.scale(to: 0.0, duration: 0.1),
                        SKAction.removeFromParent()
                    ])) {
                        self.spawnAstronaut()
                    }
                }
    }
    
    func endGame() {
        viewModel?.endGame = true

        background.color = .white
        
        for star in stars {
            star.removeAllActions()
            star.alpha = 0
        }
        
        detailGame.removeFromParent()
        timerName.fontColor = .black
        
        endGameText = SKLabelNode(text: "TEMPO SCADUTO!")
        endMessage = SKLabelNode(text: "Sei stato fenomenale!")
        scoreText = SKLabelNode(text: "Punteggio: \(score)")
        endGameText.fontColor = viewModel?.happinessColor
        endGameText.fontSize = 40
        endGameText.fontName = "Modak"
        endGameText.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(endGameText)
        scoreText.fontSize = 20
        scoreText.fontName = "Mitr-Regular"
        scoreText.fontColor = .black
        scoreText.position = CGPoint(x: size.width/2 , y: size.height/2 - 30)
        addChild(scoreText)
        endMessage.fontSize = 30
        endMessage.fontName = "Mitr-Regular"
        endMessage.fontColor = .black
        endMessage.position = CGPoint(x: size.width/2, y: size.height/2 - 70)
        addChild(endMessage)

    }
    
}

