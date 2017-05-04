//
//  BeeActiveState.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/4/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class BeeActiveState: EnemyActiveState{
    
    var previousOrientation: Orientation = .Left
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        
        
        guard let animationComponent = enemyEntity.component(ofType: BasicAnimationComponent.self) else {
            print("Error: failed to load the animation component for \(enemyEntity) upon entering the \(stateMachine?.currentState) state from \(previousState)")
            return
        }
        
        guard let orientationComponent = enemyEntity.component(ofType: OrientationComponent.self) else {
            print("Error: failed to load the animation component for \(enemyEntity) upon entering the \(stateMachine?.currentState) state from \(previousState)")
            return
        }
        
        let currentOrientation = orientationComponent.currentOrientation
        previousOrientation = currentOrientation
        
        switch(previousState){
            
            case is EnemyInactiveState:
                if animationComponent.animationNode?.action(forKey: "inactiveAnimation") != nil{
                    animationComponent.animationNode?.removeAction(forKey: "inactiveAnimation")
                }
            
                break
            case is EnemyAttackState:
                //Remove attack mode animation
                if animationComponent.animationNode?.action(forKey: "attackAnimation") != nil{
                    animationComponent.animationNode?.removeAction(forKey: "attackAnimation")
                }
                break
            default:
                break
            }
        
        let activeAnimationName = Bee.getFlyAnimation(forOrientation: currentOrientation)
        animationComponent.runAnimation(withAnimationNameOf: activeAnimationName, andWithAnimationKeyOf: "activeAnimation", repeatForever: false)
        
        
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        guard let animationComponent = enemyEntity.component(ofType: BasicAnimationComponent.self) else {
            print("Error: failed to load the animation component while performing active state updates")
            return
        }
        
        guard let orientationComponent = enemyEntity.component(ofType: OrientationComponent.self) else {
            print("Error: failed to load the orientation component while performing active state updates")
            return
        }
        
            let currentOrientation = orientationComponent.currentOrientation
        
            if(previousOrientation != currentOrientation){
                
                let activeAnimationName = Bee.getFlyAnimation(forOrientation: currentOrientation)
                
                //Remove the animation for the previous orientation
                animationComponent.removeAnimation(withAnimationKeyOf: "activeAnimation")
                
                //Run the animation for the current orientation
                animationComponent.runAnimation(withAnimationNameOf: activeAnimationName, andWithAnimationKeyOf: "activeAnimation", repeatForever: true)
            }
        
    }
    
}
