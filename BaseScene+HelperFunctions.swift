//
//  LevelScene.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/9/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import SceneKit

extension BaseScene{
    
    
    func addWorldNode(forSKView view: SKView){
        
        worldNode = SKSpriteNode()
        worldNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        worldNode.position = .zero
        worldNode.scale(to: view.bounds.size)
        addChild(worldNode)
    }
    
    func addOverlayNode(forSKView view: SKView){
        overlayNode = SKSpriteNode()
        overlayNode.zPosition = 15
        overlayNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        overlayNode.position = .zero
        overlayNode.scale(to: view.bounds.size)
        addChild(overlayNode)
    }
    
    func setupHUD(){
        guard let heartDisplay = hudManager.getMainHealthMeter() else {
            print("Error: failed to load the main health meter")
            return
        }
        
        heartDisplay.move(toParent: overlayNode)
        hudManager.setHUDPosition(position: nil)
        hudManager.resetHUD()
        
        /** TODO: consider adding a coin meter, or providing the user with the option of viewing the coin meter, or with checking the coin count in another display
         coinMeter.move(toParent: overlayNode)
         hudManager.setCoinMeterPosition(position: nil)
         hudManager.resetCoinMeter()
         **/
        
        
        guard let coinMeter = hudManager.getCoinMeter() else {
            print("Error: failed to load the coin meter")
            return
        }
    }
    
    func setupPauseButton(){
        
        let pauseGroup = SKScene(fileNamed: "OverlayButtons")?.childNode(withName: "PauseGroup")
        
        let paddingLeft = ScreenSizeConstants.HalfScreenWidth*0.20
        let paddingBottom = ScreenSizeConstants.HalfScreenHeight*0.15
        let xPos = ScreenPoints.BottomLeftCorner.x + paddingLeft
        let yPos = ScreenPoints.BottomLeftCorner.y + paddingBottom
        
        pauseGroup?.position = CGPoint(x: xPos, y: yPos)
        pauseGroup!.move(toParent: overlayNode)
        

    }
    
    
    func addPlayer(){
        player = Player(planeColor: .Red)
        if let playerNode = player.component(ofType: RenderComponent.self)?.node{
            playerNode.xScale *= 0.50
            playerNode.yScale *= 0.50
        }
        
        entityManager.addToWorld(player)
        
        
    }
}
