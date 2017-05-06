//
//  VerticalMoveState.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/6/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class VerticalMoveState: GKState{
    
    let enemyEntity: Enemy
    
    var frameCount: TimeInterval = 0.00
    var stateDurationInterval = 10.00
    var stateIntervalDistribution = 7.00

    
    init(enemyEntity: Enemy){
        self.enemyEntity = enemyEntity
    }
    
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        
        print("Spikeball has entered vertical move state...")

        stateDurationInterval = Double(arc4random_uniform(UInt32(10))) + 5.00
        
        guard let animationComponent = enemyEntity.component(ofType: BasicAnimationComponent.self), let animationNode = animationComponent.animationNode else {
            print("Error: failed to load the animation component after entering \(previousState) state")
            return
        }
        
        if animationNode.action(forKey: "horizontalMoveAnimation") != nil{
            animationNode.removeAction(forKey: "horizontalMoveAnimation")
        }
        
        animationComponent.runAnimation(withAnimationNameOf: "verticalMoveAnimation", andWithAnimationKeyOf: "verticalMoveAnimation", repeatForever: true)
        
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        frameCount += seconds
        
        if frameCount > stateDurationInterval{
            stateMachine?.enter(PathMoveState.self)
            frameCount = 0.00
        }
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass{
            case is PathMoveState.Type:
                return true
            default:
                return false
        }
    }
    

}
