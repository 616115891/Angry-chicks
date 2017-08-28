//
//  GameScene.swift
//  Angry Duck - 2
//
//  Created by jy on 2017/8/28.
//  Copyright © 2017年 jy. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    var duck:SKSpriteNode!
    var originakDucjPos:CGPoint!
    var hasGone = false
    
    var boxes = [SKSpriteNode]()
    var boxOriginalPositions = [CGPoint]()
    
    override func didMove(to view: SKView) {
        duck = childNode(withName: "duck") as! SKSpriteNode
        
        duck.physicsBody?.affectedByGravity = false
        originakDucjPos = duck.position
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        // 2: get all boxes and its positions
        
        for i in 1...8 {
            if let box = childNode(withName: "box\(i)") as? SKSpriteNode {
                boxes.append(box)
                boxOriginalPositions.append(box.position)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !hasGone {
            if let touch = touches.first {
                let touchLocation = touch.location(in: self)
                let touchedWhere = nodes(at: touchLocation)
                
                if !touchedWhere.isEmpty {
                    for node in touchedWhere {
                        if let sprite = node as? SKSpriteNode {
                            if sprite == duck {
                                duck.position = touchLocation
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !hasGone {
            if let touch = touches.first {
                let touchLocation = touch.location(in: self)
                let touchedWhere = nodes(at: touchLocation)
                
                if !touchedWhere.isEmpty {
                    for node in touchedWhere {
                        if let sprite = node as? SKSpriteNode {
                            if sprite == duck {
                                duck.position = touchLocation
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !hasGone {
            if let touch = touches.first {
                let touchLocation = touch.location(in: self)
                let touchedWhere = nodes(at: touchLocation)
                
                if !touchedWhere.isEmpty {
                    for node in touchedWhere {
                        if let sprite = node as? SKSpriteNode {
                            if sprite == duck {
                                let dx = -(touchLocation.x - originakDucjPos.x)
                                let dy = -(touchLocation.y - originakDucjPos.y )
                                let impulse = CGVector(dx: dx, dy: dy)
                                
                                print(impulse)
                                
                                duck.physicsBody?.applyImpulse(impulse)
                                duck.physicsBody?.applyAngularImpulse(-0.01)
                                duck.physicsBody?.affectedByGravity = true
                                
                                hasGone = true
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if let duckPhysicsBody = duck.physicsBody {
            if duckPhysicsBody.velocity.dx <= 0.1 && duckPhysicsBody.velocity.dy <= 0.1 && duckPhysicsBody.angularVelocity <= 0.1 && hasGone {
                duck.physicsBody?.affectedByGravity = false
                duck.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                duck.physicsBody?.angularVelocity = 0
                duck.zRotation = 0
                duck.position = originakDucjPos
                
                hasGone = false
                
                // 3: When you reset, loop through the boxes and set them to its original position, rotation and velocity
                
                for i in 0...7 { // Remember: Array indexes start from 0
                    let originalPos = boxOriginalPositions[i]
                    let box = boxes[i]
                    
                    box.position = originalPos
                    box.zRotation = 0.0
                    box.physicsBody?.velocity = CGVector.zero
                    box.physicsBody?.angularVelocity = 0.0
                }
            }
        }
    }
    
}
