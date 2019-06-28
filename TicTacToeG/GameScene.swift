//
//  GameScene.swift
//  TicTacToeG
//
//  Created by Mike Dix on 3/22/19.
//  Copyright © 2019 Mike Dix. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var xos:[SKSpriteNode] = []
    var player = 0
    var cross:SKTexture?
    var naught:SKTexture?
    var restart:SKSpriteNode?
    var label:SKLabelNode?
    var turnCount = 0
    var gameOver = false
    var marked:[Int] = [0,0,0,0,0,0,0,0,0]
    var winningIndexes:[[Int]] = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    override func didMove(to view: SKView) {
        xos.append(self.childNode(withName: "1") as! SKSpriteNode)
        xos.append(self.childNode(withName: "2") as! SKSpriteNode)
        xos.append(self.childNode(withName: "3") as! SKSpriteNode)
        xos.append(self.childNode(withName: "4") as! SKSpriteNode)
        xos.append(self.childNode(withName: "5") as! SKSpriteNode)
        xos.append(self.childNode(withName: "6") as! SKSpriteNode)
        xos.append(self.childNode(withName: "7") as! SKSpriteNode)
        xos.append(self.childNode(withName: "8") as! SKSpriteNode)
        xos.append(self.childNode(withName: "9") as! SKSpriteNode)
        cross = SKTexture(imageNamed: "playX")
        naught = SKTexture(imageNamed: "playO")
        restart = self.childNode(withName: "restart") as? SKSpriteNode
        restart?.alpha  = 0  //restart button is not visible
        label = self.childNode(withName: "Label") as? SKLabelNode
        label?.text = ""
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            for i in 0 ... xos.count-1 {
                let location = touch.location(in: self)
                if(xos[i].contains(location) && gameOver == false) {
                    if (marked[i] == 0) {  // if it has not been marked
                    if(player == 0) {
                        xos[i].texture = cross  //display cross image in spot of touch
                        player = 1
                        marked[i] = 1  //not allowed to mark again
        
                    } else {  // if it has been marked 
                        xos[i].texture = naught  //display naught image in spot of touch
                        player = 0
                        marked[i] = 1  // not allowed to mark again
                    }
                        for tempArr in winningIndexes {
                            if(xos[tempArr[0]].texture == cross && xos[tempArr[1]].texture == cross && xos[tempArr[2]].texture == cross) {
                                label?.text = "Player X is the winner"
                                gameOver = true
                            }
                            if(xos[tempArr[0]].texture == naught && xos[tempArr[1]].texture == naught && xos[tempArr[2]].texture == naught) {
                                label?.text = "Player 0 is the winner"
                                gameOver = true
                            }
                        
                            if(marked[i] == 8 && gameOver == true) {  // if there is a draw
                            label?.text = "Draw"
                            gameOver = true
                        }
                }
                    }
            }
                if (gameOver) {
                    restart?.alpha = 1
                    if(restart?.contains(location))! {
                        gameOver = false
                        restart?.alpha = 0
                        marked = [0,0,0,0,0,0,0,0,0]
                        for node in xos {
                            node.texture = nil
                            node.color = UIColor.white
                            label?.text = ""
                        }

                    }
                }
        }
        }
    }
        
    override func update(_ currentTime: TimeInterval) {
        //Called before each frame is renderd
    }
}
