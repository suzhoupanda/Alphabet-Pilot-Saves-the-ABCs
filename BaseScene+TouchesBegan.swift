//
//  BaseScene+TouchesBegan.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/3/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit
import ReplayKit

/** Implementation of handlers for user touch input **/

extension BaseScene{
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first! as UITouch
        
        let generalTouchLocation = touch.location(in: self)
        let touchLocation = touch.location(in: worldNode)
        let touchLocationUI = touch.location(in: overlayNode)
        
        
        if overlayNode.contains(generalTouchLocation){
            
            /** User is not allowed to pause the scene upon achieving the success state.  If the game is currently in record mode, then the recording must stop
             
            **/
            
            if player.hasAttainedLetter {
                //TODO: Execute code to end any currently on-going gameplay recording
                return }
            
            
    
            
            for button in overlayNode.children{
                
                
                    
                if button.name == "GameFailGroup" && button.contains(touchLocationUI){
                        
                    let touchLocationInGameFailGroup = touch.location(in: button)
                        
                    if let restartButton = button.childNode(withName: "RestartButton") as? SKSpriteNode, restartButton.contains(touchLocationInGameFailGroup){
                            print("Restarting level...")
                            
                            NotificationCenter.default.post(name: Notification.Name.ReloadCurrentGameNotification, object: nil)
                        }
                        
                        if let mainMenuButton = button.childNode(withName: "MainMenu") as? SKSpriteNode, mainMenuButton.contains(touchLocationInGameFailGroup){
                            
                            
                            NotificationCenter.default.post(name: Notification.Name.ExitGameToLevelViewControllerNotification, object: nil)
                        }
                        
                }
                    
                    
                
                
                
                
                
                if button.name == "PauseGroup" && button.contains(touchLocationUI){
                    
        
                    
                    if let pauseButton = button.childNode(withName: "PauseButton") as? SKSpriteNode, let pauseButtonLabel = pauseButton.childNode(withName: "PauseButton") as? SKLabelNode{
                        
                        let touchLocationPauseGroup = touch.location(in: button)
                        
                        if pauseButton.contains(touchLocationPauseGroup){
                            
                            if(stateMachine.currentState is LevelSceneActiveState){
                                
                                
                                if let optionsGroup = SKScene(fileNamed: "OverlayButtons")?.childNode(withName: "OptionsGroup"){
                                    optionsGroup.move(toParent: overlayNode)
                                    optionsGroup.position = CGPoint(x: 0.00, y: ScreenSizeConstants.HalfScreenHeight*0.20)
                                }
                                
                                pauseButtonLabel.text = "Resume"
                                worldNode.isPaused = true
                                self.isPaused = true
                                stateMachine.enter(LevelScenePauseState.self)
                                
                            } else {
                                
                                if let optionsGroup = overlayNode.childNode(withName: "OptionsGroup"){
                                    optionsGroup.removeFromParent()
                                }
                                
                                if let recordButtonGroup = overlayNode.childNode(withName: "RecordGroup"){
                                    recordButtonGroup.removeFromParent()
                                }
                                
                                pauseButtonLabel.text = "Pause"
                                worldNode.isPaused = false
                                self.isPaused = false
                                stateMachine.enter(LevelSceneActiveState.self)
                            }
                            
                          
                            
                        }
                        
        
                        
                    }
    
                    
                }
                
                
                if button.name == "OptionsGroup" && button.contains(touchLocationUI){
                    
                    let touchLocationInOptionGroup = touch.location(in: button)
                    
                    if let restartButton = button.childNode(withName: "Restart") as? SKSpriteNode, restartButton.contains(touchLocationInOptionGroup){
                        print("Restarting level...")
                        
                        NotificationCenter.default.post(name: Notification.Name.ReloadCurrentGameNotification, object: nil)
                    }
                    
                    
                    if let mainMenuButton = button.childNode(withName: "MainMenu") as? SKSpriteNode, mainMenuButton.contains(touchLocationInOptionGroup){
                        
                        
                        NotificationCenter.default.post(name: Notification.Name.ExitGameToLevelViewControllerNotification, object: nil)
                    }
                    
                    if let saveGameButton = button.childNode(withName: "SaveGame") as? SKSpriteNode, saveGameButton.contains(touchLocationInOptionGroup){
                        
                        saveCurrentGameSession()
                    }
                    
                    if let coinMeterButton = button.childNode(withName: "CoinCount") as? SKSpriteNode, coinMeterButton.contains(touchLocationInOptionGroup){
                        
                        button.removeFromParent()
                        
                        if let coinMeter = SKScene(fileNamed: "OverlayButtons")?.childNode(withName: "CoinMeter"){
                            coinMeter.move(toParent: overlayNode)
                            coinMeter.position = .zero
                        }
                        
                        guard let coinComponent = player.component(ofType: CollectibleStorageComponent.self) else {
                            print("Error: could not retrieve coin component for player after loading the coin meter from .sks file")
                            return
                        }
                        
                        hudManager.updateCoinMeter(numberOfGoldCoins: coinComponent.goldCoinCount, numberOfSilverCoins: coinComponent.silverCoinCount, numberOfBronzeCoins: coinComponent.bronzeCoinCount)
                        
                    }
                    
                    
                    if let recordButtonGroup = button.childNode(withName: "RecordGameplay") as? SKSpriteNode, recordButtonGroup.contains(touchLocationInOptionGroup){
                        
                        print("Showing restart buttons...")

                        button.removeFromParent()
                        
                            if let recordGroup = SKScene(fileNamed: "OverlayButtons")?.childNode(withName: "RecordGroup"){
                                recordGroup.move(toParent: overlayNode)
                                recordGroup.position = .zero
                            }
                        
                        
                        
                    }
                    
                    
                }
                
                
                if button.name ==  "CoinMeter" && button.contains(touchLocationUI){
                    
                    let touchLocationInCoinMeter = touch.location(in: button)

                    if let backButton = button.childNode(withName: "BackButton"), backButton.contains(touchLocationInCoinMeter){
                        button.removeFromParent()
                        
                        if let optionsGroup = SKScene(fileNamed: "OverlayButtons")?.childNode(withName: "OptionsGroup"){
                            optionsGroup.move(toParent: overlayNode)
                            optionsGroup.position = CGPoint(x: 0.00, y: ScreenSizeConstants.HalfScreenHeight*0.20)
                            
                            
                        }
                        
                    }
                    
                }
                
                if button.name == "RecordGroup" && button.contains(touchLocationUI){
                    
                    let touchLocationRecordGroup = touch.location(in: button)

                    if let recordButton = button.childNode(withName: "RecordButton") as? SKSpriteNode, recordButton.contains(touchLocationRecordGroup){
                        
                        print("Posting start record notification...")
                        
                        
                        screenRecorderHelper.startScreenRecording()
                        
                        
                    
                        
                    }
                    
                    if let stopRecordButton = button.childNode(withName: "StopRecordButton") as? SKSpriteNode,stopRecordButton.contains(touchLocationRecordGroup){
                        
                        print("Posting stop record notification...")
                       
                        
                        screenRecorderHelper.stopScreenRecording(withHandler: {
                        
                            print("Stopping recording due to user-initiated termination")
                        })
            
                     
                    }
                    
                
                    
                    if let backButton = button.childNode(withName: "BackButton"), backButton.contains(touchLocationRecordGroup){
                        button.removeFromParent()
                        
                        if let optionsGroup = SKScene(fileNamed: "OverlayButtons")?.childNode(withName: "OptionsGroup"){
                            optionsGroup.move(toParent: overlayNode)
                            optionsGroup.position = CGPoint(x: 0.00, y: ScreenSizeConstants.HalfScreenHeight*0.20)
                        }
                        
                    }
                    
                }
                
            }
            
            return
        }
        
        /** When the user touch is to the right of the player, velocity is increased; when it is to the left, velocity is decreased
         
         **/
        if let playerNode = player.component(ofType: RenderComponent.self)?.node{
            
            let velocityUpdateNotification: Notification.Name = touchLocation.x > playerNode.position.x ? Notification.Name.DidIncreasePlayerVelocityNotification :Notification.Name.DidDecreasePlayerVelocityNotification
            
            NotificationCenter.default.post(Notification(name: velocityUpdateNotification, object: nil, userInfo: nil))
            
        }
        
    }

}
