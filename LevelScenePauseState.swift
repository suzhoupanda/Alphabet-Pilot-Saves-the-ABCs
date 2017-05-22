//
//  LevelScenePauseState.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/1/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class LevelScenePauseState: GKState{
    
    unowned let levelScene: BaseScene
    
    
    init(levelScene: BaseScene){
        self.levelScene = levelScene
    }
    
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        
      
    
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        super.isValidNextState(stateClass)
        
        switch stateClass{
            case is LevelSceneActiveState.Type:
                return true
            default:
                return false
        }
    }
}
