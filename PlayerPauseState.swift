//
//  PlayerPauseState.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/3/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class PlayerPauseState: GKState{
    
    let playerEntity: Player
    
    
    init(playerEntity: Player){
        self.playerEntity = playerEntity
        super.init()
    }
    
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        
        print("Player has entered the success state...")
        
        if let playerPhysicsBody = playerEntity.component(ofType: PhysicsComponent.self)?.physicsBody{
            
            playerPhysicsBody.velocity = .zero
        }
        
        
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        super.isValidNextState(stateClass)
        
        switch stateClass{
            case is PlayerActiveState.Type, is PlayerDamagedState.Type:
                return true
            default:
                return false
        }
    }
}
