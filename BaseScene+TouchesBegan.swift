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
                
                if button.name == "PauseGroup" && button.contains(touchLocationUI){
                    
        
                    
                    if let pauseButton = button.childNode(withName: "PauseButton") as? SKSpriteNode, let pauseButtonLabel = pauseButton.childNode(withName: "PauseButton") as? SKLabelNode{
                        
                        let touchLocationPauseGroup = touch.location(in: button)
                        
                        if pauseButton.contains(touchLocationPauseGroup){
                            
                            if(stateMachine.currentState is LevelSceneActiveState){
                                
                                
                                if let optionsGroup = SKScene(fileNamed: "OverlayButtons")?.childNode(withName: "OptionsGroup"){
                                    optionsGroup.move(toParent: overlayNode)
                                    optionsGroup.position = .zero
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
                        print("Returning to main menu...")
                        
                        
                        NotificationCenter.default.post(name: Notification.Name.ExitGameToLevelViewControllerNotification, object: nil)
                    }
                    
                    if let saveGameButton = button.childNode(withName: "SaveGame") as? SKSpriteNode, saveGameButton.contains(touchLocationInOptionGroup){
                        print("Saving Game...")
                        
                        saveCurrentGameSession()
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
                
                if button.name == "RecordGroup" && button.contains(touchLocationUI){
                    
                    if let recordButton = button.childNode(withName: "RecordButton"){
                        
                    }
                    
                    if let stopRecordButton = button.childNode(withName: "StopRecordButton"){
                        
                    }
                    
                    if let replayButton = button.childNode(withName: "ReplayButton"){
                        
                        
                    }
                    
                    if let backButton = button.childNode(withName: "BackButton"){
                        button.removeFromParent()
                        
                        if let optionsGroup = SKScene(fileNamed: "OverlayButtons")?.childNode(withName: "OptionsGroup"){
                            optionsGroup.move(toParent: overlayNode)
                            optionsGroup.position = .zero
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
