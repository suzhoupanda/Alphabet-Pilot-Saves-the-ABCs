//
//  SpikemanNormalState.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/7/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class SpikemanNormalState: GKState{
    
    let spikemanEntity: Spikeman
    
    var previousOrientation: Orientation = .Left
    
    init(spikeManEntity: Spikeman) {
        self.spikemanEntity = spikeManEntity
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        
        
        guard let updatedOrientation = spikemanEntity.component(ofType: OrientationComponent.self)?.currentOrientation else {
            print("Error: failed to load the orientation component while performing update on spikeman normal state")
            return
        }
        
        guard let animationComponent = spikemanEntity.component(ofType: BasicAnimationComponent.self), let animationNode = animationComponent.animationNode else {
            print("Error: failed to load the animation component while performing update on spikeman normal state")
            return
        }
        
        
        if previousOrientation != updatedOrientation{
            
            let animationName = updatedOrientation == .Left ? "walkLeft" : "walkRight"
            
            if animationNode.action(forKey: "walkAnimation") != nil{
                animationNode.removeAction(forKey: "walkAnimation")
            }
            
            animationComponent.runAnimation(withAnimationNameOf: animationName, andWithAnimationKeyOf: "walkAnimation", repeatForever: true)
            
            previousOrientation = updatedOrientation
        }

        
    }
    
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        guard let physicsBody = spikemanEntity.component(ofType: PhysicsComponent.self)?.physicsBody else {
            print("Error: failed to load the physics body while performing update on spikeman normal state")
            return
        }
        
        guard let updatedOrientation = spikemanEntity.component(ofType: OrientationComponent.self)?.currentOrientation else {
            print("Error: failed to load the orientation component while performing update on spikeman normal state")
            return
        }
        
        guard let animationComponent = spikemanEntity.component(ofType: BasicAnimationComponent.self), let animationNode = animationComponent.animationNode else {
            print("Error: failed to load the animation component while performing update on spikeman normal state")
            return
        }
        
        
        if previousOrientation != updatedOrientation{
            
            let animationName = updatedOrientation == .Left ? "walkLeft" : "walkRight"
            
            if animationNode.action(forKey: "walkAnimation") != nil{
                animationNode.removeAction(forKey: "walkAnimation")
            }
            
            animationComponent.runAnimation(withAnimationNameOf: animationName, andWithAnimationKeyOf: "walkAnimation", repeatForever: true)
            
            previousOrientation = updatedOrientation
        }
        
        guard let normalVelocity = spikemanEntity.horizontalVelocity else {
            print("Error: failed to load the normal velocity for spikeman")
            return
        }
        
        let absoluteVelocity = abs(normalVelocity)
        
        let updatedHorizontalVelocity = previousOrientation == .Left ? -absoluteVelocity : absoluteVelocity
        
        physicsBody.velocity = CGVector(dx: updatedHorizontalVelocity, dy: 0.00)
        

        
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        super.isValidNextState(stateClass)
        
        switch stateClass{
            default:
                return false
        }
    }
}
