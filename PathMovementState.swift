//
//  PathMovementState.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/6/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class PathMovementState: GKState{
    
    var evilSunEntity: EvilSun
    
    var frameCount: TimeInterval = 0.00
    var stateDurationInterval = 10.00
    var stateIntervalDistribution = GKRandomDistribution(lowestValue: 5, highestValue: 10)
    
    
    init(evilSunEntity: EvilSun){
        self.evilSunEntity = evilSunEntity
    }
    
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        
        frameCount = 0.00
        stateDurationInterval = Double(stateIntervalDistribution.nextUniform())
        
        guard let animationComponent = evilSunEntity.component(ofType: BasicAnimationComponent.self), let animationNode = animationComponent.animationNode else {
            print("Error: failed to load the animation component after entering \(previousState) state")
            return
        }
        
        if animationNode.action(forKey: "verticalMoveAnimation") != nil{
            animationNode.removeAction(forKey: "verticalMoveAnimation")
        }
        
        animationComponent.runAnimation(withAnimationNameOf: "pathAnimation", andWithAnimationKeyOf: "pathAnimation", repeatForever: true)
        
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        if frameCount > stateDurationInterval{
            
            stateMachine?.enter(HorizontalMovementState.self)
            
            frameCount = 0.00
            
        }
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        super.isValidNextState(stateClass)
        
        switch stateClass{
            case is HorizontalMovementState.Type:
                return true
            default:
                return false
        }
    }
    
}
