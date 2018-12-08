//
//  GameScene.swift
//  Snake
//
//  Created by Luke Dreyer on 12/7/18.
//  Copyright © 2018 LukeDreyer. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var game: GameManager!
    
    

    var gameLogo: SKLabelNode!
    var bestScore: SKLabelNode!
    var playButton: SKShapeNode!
    
    
    override func didMove(to view: SKView){

        initializeMenu()
        print("init")
        game = GameManager()
    }
    

    private func initializeMenu(){

        gameLogo = SKLabelNode(fontNamed: "ArielRoundedMTBold")
        gameLogo.zPosition = 1
        gameLogo.position = CGPoint(x: 0, y: (frame.size.height / 2) - 200)
        gameLogo.fontSize = 60
        gameLogo.text = "SNAKE"
        gameLogo.fontColor = SKColor.red
        self.addChild(gameLogo)

        bestScore = SKLabelNode(fontNamed: "ArialRoundedMTBolded")
        bestScore.zPosition = 1
        bestScore.position = CGPoint(x: 0, y: gameLogo.position.y - 50)
        bestScore.fontSize = 40
        bestScore.text = "Best Score: 0"
        bestScore.fontColor = SKColor.white
        self.addChild(bestScore)
        

        self.playButton = SKShapeNode()
        playButton.name = "play_button"
        playButton.zPosition = 1
        playButton.position = CGPoint(x: 0, y: (frame.size.height / -2) + 200)
        playButton.fillColor = SKColor.cyan
        

        let topCorner = CGPoint(x: -50, y: 50)
        let bottomCorner = CGPoint(x: -50, y:-50)
        let middle = CGPoint(x: 50, y:0)
        let path = CGMutablePath()
        path.addLine(to: topCorner)
        path.addLines(between: [topCorner, bottomCorner, middle])

        playButton.path = path
        self.addChild(playButton)
        
    }
    
    override func update(_ currentTime: TimeInterval){
        // called before each frame is rendered
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = self.nodes(at: location)
            for node in touchedNode {
                if node.name == "play_button" {
                    startGame()
                }
            }
        }
    }
    
    private func startGame(){
        print("start game")
        gameLogo.run(SKAction.move(by: CGVector(dx: -50, dy: 600), duration: 0.5)){
            self.gameLogo.isHidden = true
        }
        playButton.run(SKAction.scale(to: 0, duration: 0.3)){
            self.playButton.isHidden = true
        }
        let bottomCorner = CGPoint(x: 0, y: (frame.size.height / -2) + 20)
        bestScore.run(SKAction.move(to: bottomCorner, duration: 0.4))
    }
}
