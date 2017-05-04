//
//  LevelSceneSuccessState.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/1/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class LevelSceneSuccessState: GKState{
    
    let levelScene: BaseScene
    
    init(levelScene: BaseScene){
        self.levelScene = levelScene
    }
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        
        if let optionsGroup = SKScene(fileNamed: "OverlayButtons")?.childNode(withName: "GameSuccessGroup"){
            optionsGroup.move(toParent: levelScene.overlayNode)
            optionsGroup.position = .zero
        }
        
        levelScene.isPaused = true
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        super.isValidNextState(stateClass)
        
            switch stateClass{
                default:
                    return false
            }
        }
    
}
