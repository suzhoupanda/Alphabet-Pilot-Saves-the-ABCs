//
//  EnemyInactiveState.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/3/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

/**  Enemy States (i.e. EnemyInactiveState, EnemyAttackState, EnemyActiveState) all implemented common state management functionality that can be subclassed for different enemies; each enemy can subclass and override the didEnter(from previousState:) function to customize the animations that are activated and removed for different states
 

 **/

import Foundation
import GameplayKit
import SpriteKit

class EnemyInactiveState: GKState{
    
    let enemyEntity: Enemy
    
    var frameCount: TimeInterval = 0.00
    var inactiveInterval : TimeInterval = 2.00
    
    init(enemyEntity: Enemy){
        self.enemyEntity = enemyEntity
        super.init()
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        frameCount += seconds
        
        if frameCount > inactiveInterval{
            
            print("Alien about to enter the active state...")
            stateMachine?.enter(EnemyActiveState.self)
            frameCount = 0.00
        }
    }
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        print("Alien has entered the inactive state. Setting inactive framecount to zero...")
        
        guard let renderComponent = enemyEntity.component(ofType: RenderComponent.self) else {
            print("Error: failed to load the render component for \(enemyEntity) upon entering the \(stateMachine?.currentState)")
            return
        }
        
        /** While in the inactive state, if the alien is not in its original position, then it will gradually lerp back towards that position. This occurs when the alien enters the inactive state while chasing the player in attack mode.
         **/
        
        let originalPosition = renderComponent.originalPosition
        
        if !renderComponent.node.position.equalTo(originalPosition){
            renderComponent.node.lerpToPoint(targetPoint: originalPosition, withLerpFactor: 0.05)
        }
        
        guard let animationComponent = enemyEntity.component(ofType: BasicAnimationComponent.self) else {
            print("Error: state machine failed to enter \(stateMachine?.currentState) from \(previousState)")
            return }
        
        frameCount = 0.00
        
        
        //Remove any active animations
        if animationComponent.animationNode?.action(forKey: "activeAnimation") != nil{
            animationComponent.animationNode?.removeAction(forKey: "activeAnimation")
        }
        
        //Run any inactive animations
        animationComponent.runAnimation(withAnimationNameOf: "unmannedPink", andWithAnimationKeyOf: "inactiveAnimation", repeatForever: false)
        
        
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        super.isValidNextState(stateClass)
        
        switch(stateClass){
        case is EnemyActiveState.Type:
            return true
        default:
            return false
        }
        
    }
}
