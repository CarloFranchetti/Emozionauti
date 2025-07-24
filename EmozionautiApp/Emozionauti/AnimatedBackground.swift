//
//  SfondoAnimato.swift
//  Emozionauti
//
//  Created by Studente on 22/07/25.
//

//
//  MinigiocoFelicita2.swift
//  Emozionauti
//
//  Created by Studente on 17/07/25.
//

import SpriteKit
import SwiftUI

class AnimatedBackgroundViewModel: ObservableObject {
    var backgroundColor: UIColor
    
    init(backgroundColor: UIColor){
        self.backgroundColor = backgroundColor
    }
}



class AnimatedBackground: SKScene {
    var background: SKSpriteNode!
    var stars: [SKShapeNode] = []
    var planet: SKSpriteNode!
    var question: SKLabelNode!
    var viewModel: AnimatedBackgroundViewModel?

    
    override func didMove(to view: SKView){
        if let backgroundColor = viewModel?.backgroundColor{
            background = SKSpriteNode(color: backgroundColor, size:size)
            background.position = CGPoint(x: size.width/2, y: size.height/2)
            background.zPosition = -1
            addChild(background)
        }
        for _ in 0..<100 {
            let star = SKShapeNode(circleOfRadius: CGFloat.random(in: 1...3))
            star.fillColor = .yellow
            star.strokeColor = .clear
            star.position = CGPoint(x: CGFloat.random(in: 0...size.width),y: CGFloat.random(in: 0...size.height))
            star.alpha = 0
            
            addChild(star)
            stars.append(star)
            
            let fadeIn = SKAction.fadeAlpha(to: 1, duration: Double.random(in: 0.5...2))
            let fadeOut = SKAction.fadeAlpha(to: 0, duration: Double.random(in: 0.5...2))
            let wait = SKAction.wait(forDuration: Double.random(in: 0...2))
            let blinkSequence = SKAction.sequence([wait, fadeIn, fadeOut])
            let blinkLoop = SKAction.repeatForever(blinkSequence)
            
            star.run(blinkLoop)
        }
        
        
        planet = SKSpriteNode(imageNamed: "pianeta")
        planet.position = CGPoint(x: size.width/2 , y: size.height - planet.size.height * 2.7 )
        planet.size = CGSize(width: size.width * 1.1, height: size.width * 1.1)
        addChild(planet)
        let rotation = SKAction.rotate(byAngle: CGFloat.pi, duration: 20)
        let rotationLoop = SKAction.repeatForever(rotation)
        planet.run(rotationLoop)
        
        question = SKLabelNode(text: "COME TI SENTI?")
        question.fontName = "Modak"
        question.fontSize = 70
        question.position = CGPoint(x: size.width/2, y: size.height/2 + 350)
        addChild(question)
        
       
        }

    
  

}

