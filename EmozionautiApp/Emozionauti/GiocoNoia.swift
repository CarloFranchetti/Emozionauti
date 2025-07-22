import SpriteKit
import AVFoundation
import SwiftUI
class GameScene: SKScene {
    var vaiAvanti: Binding<Bool>?
    struct AlienData {
        let alienName: String
        let happyItemName: String
    }
    
    let alienInfo: [AlienData] = [
        AlienData(alienName: "AlienoController", happyItemName: "Controller"),
        AlienData(alienName: "AlienoLibro", happyItemName: "Libro"),
        AlienData(alienName: "AlienoGelato", happyItemName: "Gelato")
    ]
    
    var aliens: [SKSpriteNode] = []
    var items: [SKSpriteNode] = []
    var matches: [String: String] = [:]
    
    var draggingNode: SKSpriteNode?
    var touchOffset: CGPoint = .zero
    
    override func didMove(to view: SKView) {
        backgroundColor = .white
        setupAliensAndItems()
    }
    
    func setupAliensAndItems() {
        for (index, info) in alienInfo.enumerated() {
            let alien = SKSpriteNode(imageNamed: info.alienName)
            alien.size = CGSize(width: 150, height: 150)
            alien.position = CGPoint(x: 250, y: 650 - index * 180)
            alien.name = info.alienName
            addChild(alien)
            aliens.append(alien)
            
            let item = SKSpriteNode(imageNamed: info.happyItemName)
            item.size = CGSize(width: 130, height: 130)
            item.position = CGPoint(x: 750, y: 650 - index * 180)
            item.name = info.happyItemName
            addChild(item)
            items.append(item)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        for alien in aliens {
            if alien.contains(location) {
                draggingNode = alien
                touchOffset = CGPoint(x: alien.position.x - location.x, y: alien.position.y - location.y)
                break
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, let node = draggingNode else { return }
        let location = touch.location(in: self)
        node.position = CGPoint(x: location.x + touchOffset.x, y: location.y + touchOffset.y)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, let alien = draggingNode else { return }
        let location = touch.location(in: self)
        
        for item in items {
            if item.contains(location) {
                validateMatch(alien: alien, item: item)
                break
            }
        }
        
        draggingNode = nil
    }
    
    func validateMatch(alien: SKSpriteNode, item: SKSpriteNode) {
        guard let alienData = alienInfo.first(where: { $0.alienName == alien.name }) else { return }
        
        if item.name == alienData.happyItemName {
            matches[alien.name ?? ""] = item.name
            alien.removeFromParent()
            item.removeFromParent()
            playSound(success: true)
            checkGameCompletion()
        } else {
            // Reset position (simple feedback)
            alien.run(SKAction.move(to: CGPoint(x: 150, y: alien.position.y), duration: 0.2))
            playSound(success: false)
        }
    }
    
    func checkGameCompletion() {
        if matches.count == alienInfo.count {
            showSuccessLabel()
        }
    }
    
    func showSuccessLabel() {
        vaiAvanti?.wrappedValue = true
        let label = SKLabelNode(text: "Ben fatto!")
        label.fontName = "Helvetica-Bold"
        label.fontSize = 48
        label.fontColor = .green
        label.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(label)
        
        label.run(SKAction.sequence([
            SKAction.wait(forDuration: 3),
            SKAction.fadeOut(withDuration: 1),
            ]))
    }
    
    func playSound(success: Bool) {
        let soundID: SystemSoundID = success ? 1104 : 1023
        AudioServicesPlaySystemSound(soundID)
    }
}
