import SpriteKit
import AVFoundation
import SwiftUI

class GameScene: SKScene {
    var ahead: Binding<Bool>?
    
    struct ElementStruct {
        let name: String
        let id: Int
        
        init(id: Int, name: String){
            self.id = id
            self.name = name
        }
    }
    
    let aliens: [ElementStruct] = [ElementStruct(id: 0, name: "AlienoController"), ElementStruct(id: 1, name: "AlienoLibro"), ElementStruct(id: 2, name: "AlienoGelato")]
    let objects: [ElementStruct] = [ElementStruct(id: 0, name: "Controller"), ElementStruct(id: 1, name: "Libro"), ElementStruct(id: 2, name: "Gelato")]
    var aliensOriginalPositions: [SKSpriteNode: CGPoint] = [:]
    
    
    var aliensGame: [SKSpriteNode] = []
    var objectsGame: [SKSpriteNode] = []
    var matches: [String: String] = [:]
    var gameDetail: SKLabelNode!
    var draggedNode: SKSpriteNode?
    var touchOffset: CGPoint = .zero
    
    override func didMove(to view: SKView) {
        gameDetail = SKLabelNode(text: "Collega ogni alieno a ciò che lo rende felice!")
        gameDetail.fontName = "Mitr-Regular"
        gameDetail.fontSize = 30
        gameDetail.fontColor = .black
        gameDetail.position = CGPoint(x: size.width/2, y: size.height - 200)
        gameDetail.horizontalAlignmentMode = .center
        addChild(gameDetail)
        
        backgroundColor = .white
        addAliensObjects()
    }
    
    func addAliensObjects() {
        let shuffledAliens = aliens.shuffled()
        let shuffledObjects = objects.shuffled()
        
        let spacing: CGFloat = 180
        let verticalPosition = size.height - 400
        for (index, el) in shuffledAliens.enumerated() {
            let alien = SKSpriteNode(imageNamed: el.name)
            alien.size = CGSize(width: 150, height: 150)
            alien.position = CGPoint(x: size.width * 0.25 , y: verticalPosition - (CGFloat(index) * spacing))
            alien.name = el.name
            addChild(alien)
            aliensGame.append(alien)
            aliensOriginalPositions[alien] = CGPoint(x: size.width*0.25, y:verticalPosition - (CGFloat(index) * spacing))
        }
        for (index, el) in shuffledObjects.enumerated() {
            let object = SKSpriteNode(imageNamed: el.name)
            object.size = CGSize(width: 130, height: 130)
            object.position = CGPoint(x: size.width * 0.75, y: verticalPosition - (CGFloat(index) * spacing))
            object.name = el.name
            addChild(object)
            objectsGame.append(object)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        for alien in aliensGame{
            if alien.contains(location) {
                draggedNode = alien
                touchOffset = CGPoint(x: alien.position.x - location.x, y: alien.position.y - location.y)
                break
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first,
              let node = draggedNode else { return }
        let position = touch.location(in: self)
        node.position = CGPoint(x: position.x + touchOffset.x, y: position.y + touchOffset.y)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, let alien = draggedNode else { return }
        let posizione = touch.location(in: self)
        
        for object in objectsGame {
            if object.contains(position) {
                verify(selectedAlien: alien, obj: object)
                break
            }
        }
        
        draggedNode = nil
    }
    
    func verify(selectedAlien: SKSpriteNode, obj: SKSpriteNode) {
        guard let alien = aliens.first(where: { $0.name == selectedAlien.name }),
            let object = objects.first(where: {$0.name == obj.name})
        else { return }
        
        if alien.id == object.id {
            matches[alien.name] = object.name
            selectedAlien.removeFromParent()
            obj.removeFromParent()
            aliensGame.removeAll { $0 == selectedAlien }
            objectsGame.removeAll { $0 == obj }
            playSound(success: true)
            verifyEnd(selectedAlien: selectedAlien, selectedObj: obj )
        } else {

            resetPosition(selectedAlien)
            playSound(success: false)
        }
    }
    
    func verifyEnd(selectedAlien: SKSpriteNode, selectedObj: SKSpriteNode) {
        if matches.count == aliens.count {
            aliensGame.removeAll()
            objectsGame.removeAll()
            endGame()
            
        }
    }
    
    func endGame() {
        ahead?.wrappedValue = true
        let endText = SKLabelNode(text: "BEN FATTO!")
        endText.fontName = "Modak"
        endText.fontSize = 48
        endText.fontColor = .gray
        endText.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(endText)
        
    }
    
    func playSound(success: Bool) {
        let soundID: SystemSoundID = 1104
        AudioServicesPlaySystemSound(soundID)
    }
    
    func resetPosition(_ alien: SKSpriteNode) {
           if let originalPos = aliensOriginalPositions[alien] {
               alien.run(SKAction.move(to: originalPos, duration: 0.2))
           }
       }
}
