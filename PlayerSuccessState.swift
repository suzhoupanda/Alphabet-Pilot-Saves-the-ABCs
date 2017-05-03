//
//  PlayerSuccessState.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/3/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class PlayerSuccessState: GKState{
    
    let playerEntity: Player
    
    
    init(playerEntity: Player){
        self.playerEntity = playerEntity
        super.init()
    }
    
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
    
        print("Player has entered the success state...")
       
        
        guard let playerAnimationComponent = playerEntity.component(ofType: BasicAnimationComponent.self) else {
            print("Error: player must have an animation component in order to run die animation")
            return
        }
        
        playerAnimationComponent.animationNode?.run(SKAction.wait(forDuration: 2.00), completion: {
            
            //Run any success animations
        })
        
        
        
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        super.isValidNextState(stateClass)
        
        switch stateClass{
        default:
            return false
        }
    }
}
