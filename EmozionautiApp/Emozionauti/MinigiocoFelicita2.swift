//
//  MinigiocoFelicita2.swift
//  Emozionauti
//
//  Created by Studente on 17/07/25.
//

import SpriteKit
import SwiftUI

class MinigiocoFelicitaViewModel: ObservableObject {
    @Published var giocoFinito = false
    var colorefelicita: UIColor
    var coloreSfondo: UIColor
    
    init(colore: UIColor, coloreSfondo: UIColor){
        self.colorefelicita = colore
        self.coloreSfondo = coloreSfondo
    }
}



class MinigiocoFelicita2: SKScene {
    let astronautiNomi = ["astronauta1", "astronauta2", "astronauta3", "astronauta4", "astronauta5", "astronauta6"]
    let pianetiNomi = ["pianeta1", "pianeta2", "pianeta3", "pianeta4","pianeta5","pianeta6"]
    var astronautaCurr: SKSpriteNode?
    var tempoRimasto = 30
    var nomeTimer: SKLabelNode!
    var descrizioneGioco: SKLabelNode!
    var messaggioFine: SKLabelNode!
    var timerGioco: Timer?
    var punteggio = 0
    var fineGiocoScritta: SKLabelNode!
    var punteggioScritta: SKLabelNode!
    var viewModel: MinigiocoFelicitaViewModel?
    var sfondo: SKSpriteNode!
    var stelle: [SKShapeNode] = []
    var pianeti: [SKSpriteNode] = []

    
    override func didMove(to view: SKView){
        if let coloreSfondo = viewModel?.coloreSfondo{
            sfondo = SKSpriteNode(color: coloreSfondo, size:size)
            sfondo.position = CGPoint(x: size.width/2, y: size.height/2)
            sfondo.zPosition = -1
            addChild(sfondo)
        }
        for _ in 0..<50 {
            let stella = SKShapeNode(circleOfRadius: CGFloat.random(in: 1...3))
            stella.fillColor = .yellow
            stella.strokeColor = .clear
            stella.position = CGPoint(x: CGFloat.random(in: 0...size.width),
                                    y: CGFloat.random(in: 0...size.height))
            stella.alpha = 0
            
            addChild(stella)
            stelle.append(stella)
            
            let fadeIn = SKAction.fadeAlpha(to: 1, duration: Double.random(in: 0.5...1.5))
            let fadeOut = SKAction.fadeAlpha(to: 0, duration: Double.random(in: 0.5...1.5))
            let attesa = SKAction.wait(forDuration: Double.random(in: 0...2))
            let sequenzaBlink = SKAction.sequence([attesa, fadeIn, fadeOut])
            let blinkLoop = SKAction.repeatForever(sequenzaBlink)
            
            stella.run(blinkLoop)
        }
        let margine = 100.0
        for _ in 0..<7{
            let nomeRandom = pianetiNomi.randomElement()!
            let pianeta = SKSpriteNode(imageNamed: nomeRandom)
            pianeta.position = CGPoint(x: CGFloat.random(in: margine...size.width - margine), y: CGFloat.random(in: margine...size.height - margine))
            pianeta.setScale(0.2)
            pianeta.alpha = 0.5
            addChild(pianeta)
            pianeti.append(pianeta)
            
            let fadeIn = SKAction.fadeAlpha(to: 0.5, duration: Double.random(in: 0.5...1.5))
            let fadeOut = SKAction.fadeAlpha(to: 0, duration: Double.random(in: 0.5...1.5))
            let attesa = SKAction.wait(forDuration: Double.random(in: 0...2))
            let sequenzaBlink = SKAction.sequence([attesa, fadeIn, fadeOut])
            let blinkLoop = SKAction.repeatForever(sequenzaBlink)
            
            pianeta.run(blinkLoop)
        }
        nomeTimer = SKLabelNode(text: "Tempo: 30")
        nomeTimer.position = CGPoint(x: size.width - 100, y: size.height - 50)
        nomeTimer.fontSize = 24
        nomeTimer.fontName = "Mitr-Regular"
        nomeTimer.horizontalAlignmentMode = .right
        addChild(nomeTimer)
        descrizioneGioco = SKLabelNode(text: "Premi sugli astronauti!")
        descrizioneGioco.position = CGPoint(x: size.width/2, y: size.height - 100)
        descrizioneGioco.fontSize = 50
        descrizioneGioco.fontName = "Mitr-Regular"
        descrizioneGioco.horizontalAlignmentMode = .center
        addChild(descrizioneGioco)
        
        timerGioco = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.tempoRimasto -= 1
            self.nomeTimer.text = "Tempo: \(self.tempoRimasto)"
            
            if self.tempoRimasto <= 0 {
                self.timerGioco?.invalidate()
                self.astronautaCurr?.removeFromParent()
                self.fineGioco()
            }
        }
        spawnAstronauta()

    }
    
    func spawnAstronauta(){
        astronautaCurr?.removeFromParent()
        let nomeRandom = astronautiNomi.randomElement()!
        let astronauta = SKSpriteNode(imageNamed: nomeRandom)
        astronauta.name = "astronauta"
        let randomX = CGFloat.random(in: 100...(size.width - 100))
        let randomY = CGFloat.random(in: 100...(size.height - 200))
        astronauta.position = CGPoint(x: randomX, y: randomY)
        
        astronauta.setScale(0.5)
        
        addChild(astronauta)
        astronautaCurr = astronauta
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let tocco = touches.first else { return }

                let posizione = tocco.location(in: self)
                
                if let toccato = atPoint(posizione) as? SKSpriteNode, toccato.name == "astronauta" {
                    punteggio+=1
                    toccato.run(SKAction.sequence([
                        SKAction.scale(to: 0.0, duration: 0.1),
                        SKAction.removeFromParent()
                    ])) {
                        self.spawnAstronauta()
                    }
                }
    }
    
    func fineGioco() {
        viewModel?.giocoFinito = true

        sfondo.color = .white
        
        for stella in stelle {
            stella.removeAllActions()
            stella.alpha = 0
        }
        
        descrizioneGioco.removeFromParent()
        nomeTimer.fontColor = .black
        
        fineGiocoScritta = SKLabelNode(text: "TEMPO SCADUTO!")
        messaggioFine = SKLabelNode(text: "Sei stato fenomenale!")
        punteggioScritta = SKLabelNode(text: "Punteggio: \(punteggio)")
        fineGiocoScritta.fontColor = viewModel?.colorefelicita
        fineGiocoScritta.fontSize = 40
        fineGiocoScritta.fontName = "Modak"
        fineGiocoScritta.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(fineGiocoScritta)
        punteggioScritta.fontSize = 20
        punteggioScritta.fontName = "Mitr-Regular"
        punteggioScritta.fontColor = .black
        punteggioScritta.position = CGPoint(x: size.width/2 , y: size.height/2 - 30)
        addChild(punteggioScritta)
        messaggioFine.fontSize = 30
        messaggioFine.fontName = "Mitr-Regular"
        messaggioFine.fontColor = .black
        messaggioFine.position = CGPoint(x: size.width/2, y: size.height/2 - 70)
        addChild(messaggioFine)

    }
    
}

