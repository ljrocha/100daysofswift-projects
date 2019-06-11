//
//  GameViewController.swift
//  Project29
//
//  Created by Leandro Rocha on 6/8/19.
//  Copyright © 2019 Leandro Rocha. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    @IBOutlet var angleSlider: UISlider!
    @IBOutlet var angleLabel: UILabel!
    @IBOutlet var velocitySlider: UISlider!
    @IBOutlet var velocityLabel: UILabel!
    @IBOutlet var launchButton: UIButton!
    @IBOutlet var playerNumber: UILabel!
    @IBOutlet var playerOne: UILabel!
    @IBOutlet var playerTwo: UILabel!
    @IBOutlet var windSpeed: UILabel!
    
    var currentGame: GameScene!
    
    var playerOneScore = 0 {
        didSet {
            playerOne.text = "Player One Score: \(playerOneScore)"
        }
    }
    
    var playerTwoScore = 0 {
        didSet {
            playerTwo.text = "Player Two Score: \(playerTwoScore)"
        }
    }
    
    var gameOver = false

    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        angleChanged(angleSlider)
        velocityChanged(velocitySlider)
        
        playerOneScore = 0
        playerTwoScore = 0
        updateWindSpeed(to: 0.0)
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
                
                currentGame = scene as? GameScene
                currentGame.viewController = self
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func angleChanged(_ sender: UISlider) {
        angleLabel.text = "Angle: \(Int(angleSlider.value))°"
    }
    
    @IBAction func velocityChanged(_ sender: UISlider) {
        velocityLabel.text = "Velocity: \(Int(velocitySlider.value))"
    }
    
    @IBAction func launch(_ sender: UIButton) {
        angleSlider.isHidden = true
        angleLabel.isHidden = true
        
        velocitySlider.isHidden = true
        velocityLabel.isHidden = true
        
        launchButton.isHidden = true
        
        currentGame.launch(angle: Int(angleSlider.value), velocity: Int(velocitySlider.value))
    }
    
    func activatePlayer(number: Int) {
        if number == 1 {
            playerNumber.text = "<<< PLAYER ONE"
        } else {
            playerNumber.text = "PLAYER TWO >>>"
        }
        
        angleSlider.isHidden = false
        angleLabel.isHidden = false
        
        velocitySlider.isHidden = false
        velocityLabel.isHidden = false
        
        launchButton.isHidden = false
    }
    
    func updateScore(by amount: Int, forPlayer player: Int) {
        if player == 1 {
            playerOneScore += amount
        } else {
            playerTwoScore += amount
        }
        
        if playerOneScore >= 3 || playerTwoScore >= 3 {
            gameOver = true
            
            angleSlider.isEnabled = false
            angleLabel.isEnabled = false
            
            velocitySlider.isEnabled = false
            velocityLabel.isEnabled = false
            
            launchButton.isEnabled = false
            
            playerNumber.isHidden = true
        }
    }
    
    func updateWindSpeed(to speed: CGFloat) {
        switch speed {
        case ..<0:
            let currentSpeed = numberFormatter.string(from: abs(speed) as NSNumber)
            windSpeed.text = "Westward wind speed\nof \(currentSpeed!)m/s squared)"
        case 0:
            windSpeed.text = "There is currently no wind"
        default:
            let currentSpeed = numberFormatter.string(from: speed as NSNumber)
            windSpeed.text = "Eastward wind speed\nof \(currentSpeed!)m/s squared"
        }
    }
}
