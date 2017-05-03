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
            
            for button in overlayNode.children{
                
                if button.name == "PauseGroup" && button.contains(touchLocationUI){
                    
                    print("Pause Group has been touched...")
                    
                    
                    
                    if let pauseButton = button.childNode(withName: "PauseButton") as? SKSpriteNode, let resumeButton = button.childNode(withName: "ResumeButton") as? SKSpriteNode{
                        
                        let touchLocationPauseGroup = touch.location(in: button)
                        
                        if pauseButton.contains(touchLocationPauseGroup){
                            
                            if(gameIsPaused) { return }
                            
                            gameIsPaused = true
                            
                            print("Pause Button has been touched...")
                            
                            
                            pauseButton.isHidden = true
                            resumeButton.isHidden = false
                            
                            
                            if let optionsGroup = SKScene(fileNamed: "OverlayButtons")?.childNode(withName: "OptionsGroup"){
                                optionsGroup.move(toParent: overlayNode)
                            }
                            
                        }
                        
                        if  resumeButton.contains(touchLocationPauseGroup){
                            
                            if(!gameIsPaused) { return }
                            
                            gameIsPaused = false
                            
                            print("Resume Button has been touched...")
                            
                            resumeButton.isHidden = true
                            pauseButton.isHidden = false
                            
                            
                            
                            
                            if let optionsGroup = overlayNode.childNode(withName: "OptionsGroup"){
                                optionsGroup.removeFromParent()
                            }
                        }
                        
                    }
                    
                    
                    
                    
                }
                
                
                if button.name == "OptionGroup" && button.contains(touchLocationUI){
                    
                    if let restartButton = button.childNode(withName: "Restart"){
                        
                    }
                    
                    
                    if let mainMenuButton = button.childNode(withName: "MainMenu"){
                        
                    }
                    
                    if let recordButtonGroup = button.childNode(withName: "RecordGameplay"){
                        
                        
                        
                    }
                    
                    
                }
                
                if button.name == "RecordGroup" && button.contains(touchLocationUI){
                    
                    if let recordButton = button.childNode(withName: "RecordButton"){
                        
                    }
                    
                    if let stopRecordButton = button.childNode(withName: "StopRecordButton"){
                        
                    }
                    
                    if let replayButton = button.childNode(withName: "ReplayButton"){
                        
                        
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
