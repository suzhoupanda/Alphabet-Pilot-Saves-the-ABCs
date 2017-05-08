//
//  WormNormalState.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/8/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class WormNormalState: GKState{
    
    let worm: Worm
    
    var previousOrientation: Orientation = .Left
    
    var frameCount: TimeInterval = 0.00
    var jumpInterval: TimeInterval = 5.00
    
    init(worm: Worm) {
        self.worm = worm
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        
        
        frameCount = 0.00
        
        guard let updatedOrientation = worm.component(ofType: OrientationComponent.self)?.currentOrientation else {
            print("Error: failed to load the orientation component while performing update on spikeman normal state")
            return
        }
        
        guard let animationComponent = worm.component(ofType: BasicAnimationComponent.self), let animationNode = animationComponent.animationNode else {
            print("Error: failed to load the animation component while performing update on spikeman normal state")
            return
        }
        
        /**
        
        if previousState != nil && previousState is WormJumpState{
            animationNode.removeAction(forKey: "jumpAnimation")
            
        }
        **/
        
        
        if previousOrientation != updatedOrientation{
            
            let animationName = updatedOrientation == .Left ? "crawlLeft" : "crawlRight"
            
            if animationNode.action(forKey: "crawlAnimation") != nil{
                animationNode.removeAction(forKey: "crawlAnimation")
            }
            
            animationComponent.runAnimation(withAnimationNameOf: animationName, andWithAnimationKeyOf: "crawlAnimation", repeatForever: true)
            
            previousOrientation = updatedOrientation
        }
        
        
        
        
    }
    
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        guard let physicsBody = worm.component(ofType: PhysicsComponent.self)?.physicsBody else {
            print("Error: failed to load the physics body while performing update on spikeman normal state")
            return
        }
        
        guard let updatedOrientation = worm.component(ofType: OrientationComponent.self)?.currentOrientation else {
            print("Error: failed to load the orientation component while performing update on spikeman normal state")
            return
        }
        
        guard let animationComponent = worm.component(ofType: BasicAnimationComponent.self), let animationNode = animationComponent.animationNode else {
            print("Error: failed to load the animation component while performing update on spikeman normal state")
            return
        }
        
        
        if previousOrientation != updatedOrientation{
            
            let animationName = updatedOrientation == .Left ? "crawlLeft" : "crawlRight"
            
            if animationNode.action(forKey: "crawlAnimation") != nil{
                animationNode.removeAction(forKey: "crawlAnimation")
            }
            
            animationComponent.runAnimation(withAnimationNameOf: animationName, andWithAnimationKeyOf: "crawlAnimation", repeatForever: true)
            
            previousOrientation = updatedOrientation
        }
        
        guard let normalVelocity = worm.horizontalVelocity else {
            print("Error: failed to load the normal velocity for spikeman")
            return
        }
        
        //Update veloctiy to constant value, either the default value or that specified duriing initialization
        
        let absoluteVelocity = abs(normalVelocity)
        
        let updatedHorizontalVelocity = previousOrientation == .Left ? -absoluteVelocity : absoluteVelocity
        
        physicsBody.velocity = CGVector(dx: updatedHorizontalVelocity, dy: 0.00)
        
        //Update the jump interval timer; if jump interval has elapsed, enter the jump state
        
        
        frameCount += seconds
        
        
        if frameCount > jumpInterval{
            
            
            frameCount = 0.00
        }
        
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        super.isValidNextState(stateClass)
        
        switch stateClass{
            default:
                return false
        }
    }
}
