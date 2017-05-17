//
//  PlayerDeadState.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/2/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class PlayerDeadState: GKState{
    
    let playerEntity: Player
    
    
    init(playerEntity: Player){
        self.playerEntity = playerEntity
        super.init()
    }
    
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        
        guard let playerPhysicsBody = playerEntity.component(ofType: PhysicsComponent.self)?.physicsBody else {
            print("Error: player must have a physics body in order to run the die animation")
            return
        }
        
        playerPhysicsBody.velocity = CGVector.zero
        playerPhysicsBody.affectedByGravity = true
        
        guard let playerNode = playerEntity.component(ofType: RenderComponent.self)?.node,  let animationsDict = Player.getPlaneAnimationsDict(forPlaneColor: self.playerEntity.planeColor) as? [String: SKAction],  let deadAnimation = animationsDict["dead"] else {
            print("Error: player must have a render component in order to run die animation; alternatively, check that the plane animations dictionary and the die animation are properly configured")
            return
        }
        
        playerNode.run(SKAction.wait(forDuration: 2.00), completion: {
            
            playerNode.run(deadAnimation, completion: {
            
                playerNode.removeFromParent()
            })
        })
        
        
        
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        super.isValidNextState(stateClass)
        
        switch stateClass{
            default:
                return false
        }
    }
}
