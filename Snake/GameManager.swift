//
//  GameManager.swift
//  Snake
//
//  Created by Luke Dreyer on 12/7/18.
//  Copyright © 2018 LukeDreyer. All rights reserved.
//

import SpriteKit

class GameManager {
    
    var scene: GameScene!
    
    var nextTime: Double?
    var timeExtension: Double = 1
    var playerDirection: Int = 4 // 1 == left, 2 == up, 3 == right, 4 == down
    
    init(scene: GameScene){
        self.scene = scene
    }

    func initGame(){
        //starting position of player
        scene.playerPositions.append((10,10))
        scene.playerPositions.append((10,11))
        scene.playerPositions.append((10,12))
        renderChange()
    }
    
    func renderChange(){
        for(node, x, y) in scene.gameArray{
            if contains(a: scene.playerPositions, v:(x,y)){
                node.fillColor = SKColor.cyan
            } else {
                node.fillColor = SKColor.clear
            }
        }
    }
    func contains(a: [(Int, Int)], v:(Int,Int)) -> Bool{
        let (c1, c2) = v
        for (v1, v2) in a {if v1 == c1 && v2 == c2 {return true }}
        return false
    }
    
    func update(time: Double) {
        if nextTime == nil {
            nextTime = time + timeExtension
        } else {
            if time >= nextTime! {
                nextTime = time + timeExtension
                updatePlayerPosition()
            }
        }
    }
    private func updatePlayerPosition(){
        var xChange = -1
        var yChange = 0
        switch playerDirection {
        case 1:
            // left
            xChange = -1
            yChange = 0
            break
        case 2:
            // up
            xChange = 0
            yChange = -1
            break
        case 3:
            // right
            xChange = 1
            yChange = 0
            break
        case 4:
            // down
            xChange = 0
            yChange = 1
            break
        default:
            break
        }
        if scene.playerPositions.count > 0 {
            var start = scene.playerPositions.count - 1
            while start > 0 {
                scene.playerPositions[start] = scene.playerPositions[start - 1]
                start -= 1
            }
            scene.playerPositions[0] = (scene.playerPositions[0].0 + yChange, scene.playerPositions[0].1 + xChange)
        }
        renderChange()
    }
}
