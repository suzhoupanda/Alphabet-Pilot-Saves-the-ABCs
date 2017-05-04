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
        
        if levelScene.player.hasAttainedLetter{
            stateMachine?.enter(LevelSceneSuccessState.self)
        }
        
        if let playerState = levelScene.player.component(ofType: IntelligenceComponent.self)?.stateMachine?.currentState{
            
            switch(playerState){
                case is PlayerDeadState:
                    stateMachine?.enter(LevelSceneFailState.self)
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
    
  
    
    func configurePauseButton(){
        /**
        let pauseButtonLabel = SKLabelNode(fontNamed: "AppleColorEmoji")
        pauseButtonLabel.text = "Pause"
        pauseButtonLabel.name = "pauseGame"
        pauseButtonLabel.color = UIColor.white
        
        let pauseButtonWidth = ScreenSizeConstants.HalfScreenWidth*0.35
        let pauseButtonHeight = ScreenSizeConstants.HalfScreenHeight*0.20
        
        pauseButtonLabel.horizontalAlignmentMode = .left
        pauseButtonLabel.position = CGPoint(x: pauseButtonWidth*0.10, y: pauseButtonHeight*0.20)
        pauseButton.name = "Pause"
        pauseButton.color = UIColor.cyan
        
        
        pauseButton.size = CGSize(width: pauseButtonWidth, height: pauseButtonHeight)
        
        pauseButton.addChild(pauseButtonLabel)
        
        pauseButton.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        
        let paddingLeft = ScreenSizeConstants.HalfScreenWidth*0.02
        let paddingBottom = ScreenSizeConstants.HalfScreenHeight*0.02
        
        let xPos = ScreenPoints.BottomLeftCorner.x + paddingLeft
        let yPos = ScreenPoints.BottomLeftCorner.y + paddingBottom
        
        pauseButton.position = CGPoint(x: xPos, y: yPos)
        
        levelScene.overlayNode.addChild(pauseButton)
        **/
    }
}
