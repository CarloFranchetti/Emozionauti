//
//  AnimatedBackground.swift
//  Emozionauti
//
//  Created by Studente on 22/07/25.
//

import SpriteKit
import SwiftUI

class SfondoAnimatoViewModel: ObservableObject {
    var coloreSfondo: UIColor
    
    init(coloreSfondo: UIColor){
        self.coloreSfondo = coloreSfondo
    }
}



class SfondoAnimato: SKScene {
    var sfondo: SKSpriteNode!
    var stelle: [SKShapeNode] = []
    var pianeta: SKSpriteNode!
    var domanda: SKLabelNode!
    var viewModel: SfondoAnimatoViewModel?

    
    override func didMove(to view: SKView){
        if let coloreSfondo = viewModel?.coloreSfondo{
            sfondo = SKSpriteNode(color: coloreSfondo, size:size)
            sfondo.position = CGPoint(x: size.width/2, y: size.height/2)
            sfondo.zPosition = -1
            addChild(sfondo)
        }
        for _ in 0..<100 {
            let stella = SKShapeNode(circleOfRadius: CGFloat.random(in: 1...3))
            stella.fillColor = .yellow
            stella.strokeColor = .clear
            stella.position = CGPoint(x: CGFloat.random(in: 0...size.width),y: CGFloat.random(in: 0...size.height))
            stella.alpha = 0
            
            addChild(stella)
            stelle.append(stella)
            
            let fadeIn = SKAction.fadeAlpha(to: 1, duration: Double.random(in: 0.5...2))
            let fadeOut = SKAction.fadeAlpha(to: 0, duration: Double.random(in: 0.5...2))
            let attesa = SKAction.wait(forDuration: Double.random(in: 0...2))
            let sequenzaBlink = SKAction.sequence([attesa, fadeIn, fadeOut])
            let blinkLoop = SKAction.repeatForever(sequenzaBlink)
            
            stella.run(blinkLoop)
        }
        
        
        pianeta = SKSpriteNode(imageNamed: "pianeta")
        pianeta.position = CGPoint(x: size.width/2 , y: size.height - pianeta.size.height * 2.7 )
        pianeta.size = CGSize(width: size.width * 1.1, height: size.width * 1.1)
        addChild(pianeta)
        let rotazione = SKAction.rotate(byAngle: CGFloat.pi, duration: 20)
        let rotazioneLoop = SKAction.repeatForever(rotazione)
        pianeta.run(rotazioneLoop)
        
        domanda = SKLabelNode(text: "COME TI SENTI?")
        domanda.fontName = "Modak"
        domanda.fontSize = 70
        domanda.position = CGPoint(x: size.width/2, y: size.height/2 + 350)
        addChild(domanda)
        
       
        }

    
  

}

