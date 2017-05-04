//
//  BeeAttackState.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/4/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class BeeAttackState: EnemyAttackState{
    
    var previousOrientation: Orientation = .Left
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        
        guard let animationComponent = enemyEntity.component(ofType: BasicAnimationComponent.self) else {
            print("Error: failed to load the animation component while entering \(stateMachine?.currentState) from the \(previousState)")
            return
        }
        
        guard let orientationComponent = enemyEntity.component(ofType: OrientationComponent.self) else {
            print("Error: failed to load the animation component while entering \(stateMachine?.currentState) from the \(previousState)")
            return
        }
        
        
        //Remove any active animations
        if animationComponent.animationNode?.action(forKey: "activeAnimation") != nil{
            animationComponent.animationNode?.removeAction(forKey: "activeAnimation")
        }
        
        //Remove any attack animations
        if animationComponent.animationNode?.action(forKey: "inactiveAnimation") != nil{
            animationComponent.animationNode?.removeAction(forKey: "inactiveAnimation")
        }
        
        
        //Run any attack mode animations
        let currentOrientation = orientationComponent.currentOrientation
        previousOrientation = currentOrientation
        
        let attackAnimationName = Bee.getAttackAnimation(forOrientation: currentOrientation)
        animationComponent.runAnimation(withAnimationNameOf: attackAnimationName, andWithAnimationKeyOf: "attackAnimation", repeatForever: true)
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        guard let animationComponent = enemyEntity.component(ofType: BasicAnimationComponent.self) else {
            print("Error: failed to load the animation component while performing attack state updates")
            return
        }
        
        guard let orientationComponent = enemyEntity.component(ofType: OrientationComponent.self) else {
            print("Error: failed to load the animation component while performing attack state updates")
            return
        }
        
        let currentOrientation = orientationComponent.currentOrientation
        
        if(previousOrientation != currentOrientation){
            
            let attackAnimationName = Bee.getAttackAnimation(forOrientation: currentOrientation)
            
            //Remove the animation for the previous orientation
            animationComponent.removeAnimation(withAnimationKeyOf: "attackAnimation")
            
            //Run the animation for the updated orientation
            animationComponent.runAnimation(withAnimationNameOf: attackAnimationName, andWithAnimationKeyOf: "attackAnimation", repeatForever: true)
            
            previousOrientation = currentOrientation
        }
        

    }
    
}
