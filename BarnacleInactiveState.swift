//
//  BarnacleInactiveState.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/8/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class BarnacleInactiveState: GKState{
    
    unowned let barnacle: Barnacle
    
    init(barnacle: Barnacle){
        self.barnacle = barnacle
    }
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        
        print("Just entered the inactive state...")

        guard let animationComponent = barnacle.component(ofType: BasicAnimationComponent.self) else {
            print("Error: failed to load the animation component while performing update on the barnacle in the inactive state")
            return
        }
        
        if let animationNode = animationComponent.animationNode{
            
            if animationNode.action(forKey: "mainAnimation") != nil{
                animationNode.removeAction(forKey: "mainAnimation")
            }
            
            
        }
        
        animationComponent.runAnimation(withAnimationNameOf: "closed", andWithAnimationKeyOf: "mainAnimation", repeatForever: false)
        
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        guard let fieldEmittingComponent = barnacle.component(ofType: FieldEmittingComponent.self) else {
            print("Error: failed to load field emitting component while performing update on barnacle in the inactive state")
            return
        }
        
       
        
        if let fieldNode = fieldEmittingComponent.fieldNode, fieldNode.isEnabled{
            stateMachine?.enter(BarnacleEmittingState.self)
            
        }
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        super.isValidNextState(stateClass)
        
        switch stateClass {
            case is BarnacleEmittingState.Type:
                return true
            default:
                return false
        }
    }
}
