//
//  LevelSceneFailState.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/1/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit
import ReplayKit

class LevelSceneFailState: GKState{
    
    let levelScene: BaseScene
    
    init(levelScene: BaseScene){
        self.levelScene = levelScene
    }
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        
        /** Since the player has just entered the dead state, the player needs time to run it's die animation.  Upon entering the level fail state, a short delay is allowed to elapse before pausing the scene and shwoing the GameFailGroup buttons
        **/
        
        levelScene.run(SKAction.wait(forDuration: 6.00), completion: {
            if let optionsGroup = SKScene(fileNamed: "OverlayButtons")?.childNode(withName: "GameFailGroup"){
                optionsGroup.move(toParent: self.levelScene.overlayNode)
                optionsGroup.position = .zero
                
                NotificationCenter.default.post(name: Notification.Name.StopRecordingGameplayNotification, object: BaseScene.self)
                
            }
            
            self.levelScene.isPaused = true
        
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
