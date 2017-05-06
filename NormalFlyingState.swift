//
//  NormalFlyingState.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/6/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class NormalFlyingState: GKState{
    
    var enemyEntity: Enemy
    
    var previousOrientation: Orientation = .Left
    
    init(enemyEntity: Enemy){
        self.enemyEntity = enemyEntity
    }
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        guard let updatedOrientation = enemyEntity.component(ofType: OrientationComponent.self)?.currentOrientation else {
                print("Error: failed to load orientation component")
                return
            }
        
        guard let animationComponent = enemyEntity.component(ofType: BasicAnimationComponent.self),let animationNode = animationComponent.animationNode
                else {
                print("Error: failed to load animation component")
                return
            }
        
        
        if updatedOrientation != previousOrientation{
            
            if animationNode.action(forKey: "flappingAnimation") != nil{
                animationNode.removeAction(forKey: "flappingAnimation")
            }
            
            
            let animationName = updatedOrientation == .Left ? "flappingLeft" : "flappingRight"
            
            animationComponent.runAnimation(withAnimationNameOf: animationName, andWithAnimationKeyOf: "flappingAnimation", repeatForever: true)
            
            previousOrientation = updatedOrientation
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
