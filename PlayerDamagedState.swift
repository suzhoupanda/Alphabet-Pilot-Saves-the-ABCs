//
//  PlayerDamagedState.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/2/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit


class PlayerDamagedState: GKState{
    
    let playerEntity: Player
    
    var frameCount: TimeInterval = 0.00
    var damageInterval: TimeInterval = 5.00
    
    init(playerEntity: Player){
        self.playerEntity = playerEntity
        super.init()
    }
    
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        
        guard let playerAnimationComponent = playerEntity.component(ofType: BasicAnimationComponent.self) else {
            print("Error: the player does not have an animation component")
            return
        }
        
        playerAnimationComponent.runAnimation(withAnimationNameOf: "damaged", andWithAnimationKeyOf: "damagedAnimation", repeatForever: true)
        
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        frameCount += seconds
        
        if frameCount > damageInterval{
            
            guard let playerAnimationComponent = playerEntity.component(ofType: BasicAnimationComponent.self) else {
                print("Error: the player does not have an animation component")
                return
            }
            
            playerAnimationComponent.removeAnimation(withAnimationKeyOf: "damagedAnimation")
            
            stateMachine?.enter(PlayerActiveState.self)
            
            frameCount = 0
        }
        
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        super.isValidNextState(stateClass)
        
        switch stateClass{
            case is PlayerActiveState.Type, is PlayerSuccessState.Type, is PlayerPauseState.Type:
                return true
            default:
                return false
        }
    }
    
}
