import SpriteKit
import AVFoundation
import SwiftUI

class GameScene: SKScene {
    var vaiAvanti: Binding<Bool>?
    
    struct ElementoStruct {
        let nome: String
        let id: Int
        
        init(id: Int, nome: String){
            self.id = id
            self.nome = nome
        }
    }
    
    let alieni: [ElementoStruct] = [ElementoStruct(id: 0, nome: "AlienoController"), ElementoStruct(id: 1, nome: "AlienoLibro"), ElementoStruct(id: 2, nome: "AlienoGelato")]
    let oggetti: [ElementoStruct] = [ElementoStruct(id: 0, nome: "Controller"), ElementoStruct(id: 1, nome: "Libro"), ElementoStruct(id: 2, nome: "Gelato")]
    var posizioniOriginaliA: [SKSpriteNode: CGPoint] = [:]
    
    
    var alieniGioco: [SKSpriteNode] = []
    var oggettiGioco: [SKSpriteNode] = []
    var matches: [String: String] = [:]
    var descrizione: SKLabelNode!
    var nodoTrascinato: SKSpriteNode?
    var touchOffset: CGPoint = .zero
    
    override func didMove(to view: SKView) {
        descrizione = SKLabelNode(text: "Collega ogni alieno a ciò che lo rende felice!")
        descrizione.fontName = "Mitr-Regular"
        descrizione.fontSize = 30
        descrizione.fontColor = .black
        descrizione.position = CGPoint(x: size.width/2, y: size.height - 200)
        descrizione.horizontalAlignmentMode = .center
        addChild(descrizione)
        
        backgroundColor = .white
        inserisciAlieniEOggetti()
    }
    
    func inserisciAlieniEOggetti() {
        let alieniMischiati = alieni.shuffled()
        let oggettiMischiati = oggetti.shuffled()
        
        let spaziatura: CGFloat = 180
        let posVerticale = size.height - 400
        for (index, el) in alieniMischiati.enumerated() {
            let alieno = SKSpriteNode(imageNamed: el.nome)
            alieno.size = CGSize(width: 150, height: 150)
            alieno.position = CGPoint(x: size.width * 0.25 , y: posVerticale - (CGFloat(index) * spaziatura))
            alieno.name = el.nome
            addChild(alieno)
            alieniGioco.append(alieno)
            posizioniOriginaliA[alieno] = CGPoint(x: size.width*0.25, y:posVerticale - (CGFloat(index) * spaziatura))
        }
        for (index, el) in oggettiMischiati.enumerated() {
            let oggetto = SKSpriteNode(imageNamed: el.nome)
            oggetto.size = CGSize(width: 130, height: 130)
            oggetto.position = CGPoint(x: size.width * 0.75, y: posVerticale - (CGFloat(index) * spaziatura))
            oggetto.name = el.nome
            addChild(oggetto)
            oggettiGioco.append(oggetto)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        for alieno in alieniGioco{
            if alieno.contains(location) {
                nodoTrascinato = alieno
                touchOffset = CGPoint(x: alieno.position.x - location.x, y: alieno.position.y - location.y)
                break
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first,
              let nodo = nodoTrascinato else { return }
        let posizione = touch.location(in: self)
        nodo.position = CGPoint(x: posizione.x + touchOffset.x, y: posizione.y + touchOffset.y)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, let alieno = nodoTrascinato else { return }
        let posizione = touch.location(in: self)
        
        for oggetto in oggettiGioco {
            if oggetto.contains(posizione) {
                verifica(alienoSel: alieno, ogg: oggetto)
                break
            }
        }
        
        nodoTrascinato = nil
    }
    
    func verifica(alienoSel: SKSpriteNode, ogg: SKSpriteNode) {
        guard let alieno = alieni.first(where: { $0.nome == alienoSel.name }),
            let oggetto = oggetti.first(where: {$0.nome == ogg.name})
        else { return }
        
        if alieno.id == oggetto.id {
            matches[alieno.nome] = oggetto.nome
            alienoSel.removeFromParent()
            ogg.removeFromParent()
            alieniGioco.removeAll { $0 == alienoSel }
            oggettiGioco.removeAll { $0 == ogg }
            playSound(success: true)
            verificaFine(selezionatoA: alienoSel, selezionatoO: ogg )
        } else {

            resetPosizione(alienoSel)
            playSound(success: false)
        }
    }
    
    func verificaFine(selezionatoA: SKSpriteNode, selezionatoO: SKSpriteNode) {
        if matches.count == alieni.count {
            alieniGioco.removeAll()
            oggettiGioco.removeAll()
            fineGioco()
            
        }
    }
    
    func fineGioco() {
        vaiAvanti?.wrappedValue = true
        let fineMessaggio = SKLabelNode(text: "BEN FATTO!")
        fineMessaggio.fontName = "Modak"
        fineMessaggio.fontSize = 48
        fineMessaggio.fontColor = .gray
        fineMessaggio.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(fineMessaggio)
        
    }
    
    func playSound(success: Bool) {
        let soundID: SystemSoundID = success ? 1104 : 1023
        AudioServicesPlaySystemSound(soundID)
    }
    
    func resetPosizione(_ alieno: SKSpriteNode) {
           if let posOriginale = posizioniOriginaliA[alieno] {
               alieno.run(SKAction.move(to: posOriginale, duration: 0.2))
           }
       }
}
