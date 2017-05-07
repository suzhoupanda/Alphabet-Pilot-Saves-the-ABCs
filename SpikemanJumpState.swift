//
//  SpikemanJumpState.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/7/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit


class SpikemanJumpState: GKState{
    
    let spikemanEntity: Spikeman
    
    var jumpStarted: Bool = false
    
    init(spikeManEntity: Spikeman) {
        self.spikemanEntity = spikeManEntity
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        
        jumpStarted = false
        

        guard let physicsBody = spikemanEntity.component(ofType: PhysicsComponent.self)?.physicsBody else {
            print("Error: failed to load the physics body while performing update on spikeman normal state")
            return
        }
        
       
        
        guard let animationComponent = spikemanEntity.component(ofType: BasicAnimationComponent.self), let animationNode = animationComponent.animationNode, let jumpAction = Spikeman.AnimationsDict["jump"] else {
            print("Error: failed to load the animation component while performing update on spikeman normal state")
            return
        }
        
        if animationNode.action(forKey: "walkAnimation") != nil{
            animationNode.removeAction(forKey: "walkAnimation")
        }
        
        
        
        
        
        animationNode.run(jumpAction, completion: {
            
            
            let jumpImpulse = CGVector(dx: 0.00, dy: 200.00)
            
            physicsBody.applyImpulse(jumpImpulse)
            self.jumpStarted = true
            

        })
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        if !jumpStarted { return }
        
        guard let physicsBody = spikemanEntity.component(ofType: PhysicsComponent.self)?.physicsBody else {
            print("Error: failed to load the physics body while performing update on spikeman normal state")
            return
        }
        
        if physicsBody.velocity.dy == 0.00 {
            stateMachine?.enter(SpikemanNormalState.self)
        }
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        super.isValidNextState(stateClass)
        
            switch stateClass{
                case is SpikemanNormalState.Type:
                    return true
                default:
                    return false
                
            }
    }
    
    
}
