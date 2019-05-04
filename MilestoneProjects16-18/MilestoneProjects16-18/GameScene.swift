//
//  GameScene.swift
//  MilestoneProjects16-18
//
//  Created by Leandro Rocha on 5/3/19.
//  Copyright © 2019 Leandro Rocha. All rights reserved.
//

import SpriteKit

enum enemyPlacementType: CaseIterable {
    case top
    case middle
    case bottom
    
    var location: CGPoint {
        switch self {
        case .top:
            return CGPoint(x: -100, y: 600)
        case .middle:
            return CGPoint(x: 1200, y: 400)
        case .bottom:
            return CGPoint(x: -100, y: 200)
        }
    }
    
    var movement: CGPoint {
        switch self {
        case .top, .bottom:
            return CGPoint(x: 1200, y: 0)
        case .middle:
            return CGPoint(x: -1400, y: 0)
        }
    }
}

class GameScene: SKScene {
    
    let possibleEnemies = ["target0", "target1", "target2", "target3"]
    
    var gameTimer: SKLabelNode!
    var secondsRemaining = 60
    var timer: Timer?
    
    var gameScore: SKLabelNode!
    var score = 0 {
        didSet {
            gameScore.text = "Score: \(score)"
        }
    }
    
    var shotsLeft: SKSpriteNode!
    var shots = 3 {
        didSet {
            shotsLeft.texture = SKTexture(imageNamed: "shots\(shots)")
        }
    }
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        gameTimer = SKLabelNode(fontNamed: "Chalkduster")
        gameTimer.text = "Time left: \(secondsRemaining)s"
        gameTimer.position = CGPoint(x: 16, y: 700)
        gameTimer.horizontalAlignmentMode = .left
        gameTimer.fontSize = 34
        gameTimer.fontColor = UIColor.red
        addChild(gameTimer)
        
        gameScore = SKLabelNode(fontNamed: "Chalkduster")
        gameScore.position = CGPoint(x: 512, y: 16)
        gameScore.fontSize = 48
        addChild(gameScore)
        
        score = 0
        
        shotsLeft = SKSpriteNode(imageNamed: "shots\(shots)")
        shotsLeft.position = CGPoint(x: 950, y: 36)
        shotsLeft.name = "reload"
        addChild(shotsLeft)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateGameTimer), userInfo: nil, repeats: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.createTarget()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard secondsRemaining >= 0 else { return }
        guard let touch = touches.first else { return }
        
        let location = touch.location(in: self)
        let tappedNodes = nodes(at: location)
        
        for node in tappedNodes {
            if node.name == "goodTarget" && shots > 0 {
                shots -= 1
                node.removeAllActions()
                let fadeOut = SKAction.fadeOut(withDuration: 0.5)
                let remove = SKAction.removeFromParent()
                let sequence = SKAction.sequence([fadeOut, remove])
                
                node.run(sequence)
                
                score += 5
            } else if node.name == "badTarget" && shots > 0 {
                shots -= 1
                score -= 10
            } else if node.name == "reload" {
                shots = 3
            }
        }
        
    }
    
    @objc func createTarget() {
        guard secondsRemaining >= 0 else { return }
        
        let targetName = possibleEnemies.randomElement()!
        let target = SKSpriteNode(imageNamed: targetName)
        if targetName == "target0" || targetName == "target3" {
            target.name = "goodTarget"
        } else {
            target.name = "badTarget"
        }
        
        let placementType = enemyPlacementType.allCases.randomElement()!
        let position = placementType.location
        let movement = placementType.movement
        
        target.position = CGPoint(x: position.x, y: position.y)
        let move = SKAction.moveBy(x: movement.x, y: movement.y, duration: 3)
        let remove = SKAction.removeFromParent()
        let sequence = SKAction.sequence([move, remove])
        target.run(sequence)
        addChild(target)
        
        let delay = Double.random(in: 1.5...2)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            self?.createTarget()
        }
    }
    
    @objc func updateGameTimer() {
        secondsRemaining -= 1
        
        if secondsRemaining < 0 {
            timer?.invalidate()
            
            let gameOver = SKSpriteNode(imageNamed: "game-over")
            gameOver.position = CGPoint(x: 512, y: 384)
            gameOver.zPosition = 1
            addChild(gameOver)
            
            gameTimer.run(SKAction.moveBy(x: 0, y: 200, duration: 0.05))
        } else {
            gameTimer.text = "Time left: \(secondsRemaining)s"
        }
    }
    
}
