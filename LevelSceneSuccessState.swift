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
import ReplayKit


class LevelSceneSuccessState: GKState{
    
    unowned let levelScene: BaseScene
    
    let screenRecorderHelper = ScreenRecorderHelper.sharedHelper
    
    init(levelScene: BaseScene){
        self.levelScene = levelScene
    }
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        
        levelScene.worldNode.isPaused = true
        
        if let optionsGroup = SKScene(fileNamed: "OverlayButtons")?.childNode(withName: "GameSuccessGroup") {
            optionsGroup.move(toParent: levelScene.overlayNode)
            optionsGroup.position = .zero
            
          
            
            optionsGroup.run(SKAction.wait(forDuration: 3.00), completion: {
                
                
                self.screenRecorderHelper.stopRecordingAndSavePreviewViewController()
                
                
                self.postLevelCompletedNotifications()
                
            })
        }
        
        
        
        
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        super.isValidNextState(stateClass)
        
            switch stateClass{
                default:
                    return false
            }
        }
    
    func postLevelCompletedNotifications(){
        
        print("Saving game data...")
        

        
        guard let playerCollectibleComponent = levelScene.player.component(ofType: CollectibleStorageComponent.self) else {
            
            print("Error: Unable to load player collectible component while saving game")
            return
        }
       
        
        let goldCoinCount = Int16(playerCollectibleComponent.goldCoinCount)
        let silverCoinCount = Int16(playerCollectibleComponent.silverCoinCount)
        let bronzeCoinCount = Int16(playerCollectibleComponent.bronzeCoinCount)
        
        let letterSceneName = levelScene.letterScene.rawValue
        let currentDate = Date()
        
        let userInfo: [String: Any] = [
            "goldCoinCount": goldCoinCount,
            "silverCoinCount" : silverCoinCount,
            "bronzeCoinCount" : bronzeCoinCount,
            "letterSceneName" : letterSceneName,
            "dateSaved" : currentDate
        ]
        
      
        NotificationCenter.default.post(name: Notification.Name.LevelCompletedNotification, object: BaseScene.self, userInfo: userInfo)
        
        NotificationCenter.default.post(name: Notification.Name.ExitGameToLevelViewControllerNotification, object: nil)
        
        
        
    }

}
