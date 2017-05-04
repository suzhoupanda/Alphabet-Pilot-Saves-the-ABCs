//
//  BeeInactiveState.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/4/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//


import Foundation
import GameplayKit
import SpriteKit

class BeeInactiveState: GKState{
    
    
    var previousOrientation: Orientation = .Left
    
    let enemyEntity: Enemy
    
    var frameCount: TimeInterval = 0.00
    var inactiveInterval : TimeInterval = 2.00
    
    init(enemyEntity: Enemy){
        self.enemyEntity = enemyEntity
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        
        guard let renderComponent = enemyEntity.component(ofType: RenderComponent.self) else {
            print("Error: failed to load the render component for \(enemyEntity) upon entering the \(stateMachine?.currentState)")
            return
        }
        
        /** While in the inactive state, if the enemy is not in its original position, then it will gradually lerp back towards that position. This occurs when the enemy enters the inactive state while chasing the player in attack mode.
         **/
        
        let originalPosition = renderComponent.originalPosition
        
        if !renderComponent.node.position.equalTo(originalPosition){
            renderComponent.node.lerpToPoint(targetPoint: originalPosition, withLerpFactor: 0.05)
        }
        
        frameCount = 0.00
        
        
        guard let animationComponent = enemyEntity.component(ofType: BasicAnimationComponent.self) else {
                print("Error: state machine failed to enter \(stateMachine?.currentState) from \(previousState)")
                return
            }
        
        guard let orientationComponent = enemyEntity.component(ofType: OrientationComponent.self) else {
                print("Error: state machine failed to enter \(stateMachine?.currentState) from \(previousState)")
                return
            }
        
        //Remove any active animations
        if animationComponent.animationNode?.action(forKey: "activeAnimation") != nil{
            animationComponent.animationNode?.removeAction(forKey: "activeAnimation")
        }
        
        //Remove any attack animations
        if animationComponent.animationNode?.action(forKey: "attackAnimation") != nil{
            animationComponent.animationNode?.removeAction(forKey: "attackAnimation")
        }
        
        //Run any inactive animations
        let currentOrientation = orientationComponent.currentOrientation
        previousOrientation = currentOrientation
        
        let inactiveAnimationName = Bee.getFlyAnimation(forOrientation: currentOrientation)
        
        animationComponent.runAnimation(withAnimationNameOf: inactiveAnimationName, andWithAnimationKeyOf: "inactiveAnimation", repeatForever: false)
        
    }
    
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        
        frameCount += seconds
        
        if frameCount > inactiveInterval{
            
            stateMachine?.enter(BeeActiveState.self)
            frameCount = 0.00
        }
        
        guard let animationComponent = enemyEntity.component(ofType: BasicAnimationComponent.self) else {
            print("Error: state machine failed to load animation component while performing inactive state update")
            return
        }
        
        guard let orientationComponent = enemyEntity.component(ofType: OrientationComponent.self) else {
            print("Error: state machine failed to load orientation component while performing inactive state update")
            return
        }
        
        
        //Run any inactive animations
        let currentOrientation = orientationComponent.currentOrientation
        
        if(currentOrientation != previousOrientation){
            let inactiveAnimationName = Bee.getFlyAnimation(forOrientation: currentOrientation)
        
            
            //Remove animation for the previous orientation
            animationComponent.removeAnimation(withAnimationKeyOf: "inactiveAnimation")
            
            //Run animation for the new orientation
            animationComponent.runAnimation(withAnimationNameOf: inactiveAnimationName, andWithAnimationKeyOf: "inactiveAnimation", repeatForever: false)
            
            previousOrientation = currentOrientation
        }
        

        
}
    
    
  
}
