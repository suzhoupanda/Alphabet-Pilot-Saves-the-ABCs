//
//  LevelSceneActiveState.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/1/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class LevelSceneActiveState: GKState{
    
    let levelScene: BaseScene
    
    init(levelScene: BaseScene){
        self.levelScene = levelScene
        
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        if let playerState = levelScene.player.component(ofType: IntelligenceComponent.self)?.stateMachine?.currentState{
            
            switch(playerState){
                case is PlayerDeadState.Type:
                    break
                case is PlayerSuccessState.Type:
                    break
                default:
                    break
                
            }
        }
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        super.isValidNextState(stateClass)
        
        switch stateClass{
            case is LevelSceneSuccessState.Type, is LevelScenePauseState.Type, is LevelSceneFailState.Type:
                return true
            default:
                return false
        }
    }
    
  
    
 
}
