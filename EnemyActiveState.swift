//
//  EnemyActiveState.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/3/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class EnemyActiveState: GKState{
    
    var frameCount: TimeInterval = 0.00
    var activeInterval: TimeInterval = 7.00
    
    let enemyEntity: Enemy
    
    init(enemyEntity: Enemy) {
        self.enemyEntity = enemyEntity
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        
        frameCount = 0.0
        
        
        
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        if let targetDetectionComponent = enemyEntity.component(ofType: TargetDetectionComponent.self), targetDetectionComponent.playerHasEnteredProximity{
            
            print("Player has entered enemy vicinity...Now entering attack mode...")
            stateMachine?.enter(EnemyAttackState.self)
            
        }
        
        frameCount += seconds
        
        if frameCount > activeInterval{
            
            stateMachine?.enter(EnemyInactiveState.self)
            frameCount = 0.00
        }
        
        
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        super.isValidNextState(stateClass)
        
        switch(stateClass){
        case is EnemyAttackState.Type, is EnemyInactiveState.Type:
            return true
        default:
            return false
        }
    }
    
}
