//
//  HUD.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/3/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

/** HUD singleton manages the HUD, which consists of a collection of full and half-full hearts representing the player's health level
 
 **/

class HUDManager{
    
    static let sharedHUDManager = HUDManager()
    
    private var heartDisplay: SKSpriteNode?
    private var coinMeter: SKSpriteNode?
    
    private var heart1: SKSpriteNode?{
        get{
            return heartDisplay?.childNode(withName: "Heart1") as? SKSpriteNode
        }
    }
    
    private var heart2: SKSpriteNode?{
        get{
            return heartDisplay?.childNode(withName: "Heart2") as? SKSpriteNode
        }
    }
    
    private var heart3: SKSpriteNode?{
        get{
            return heartDisplay?.childNode(withName: "Heart3") as? SKSpriteNode
        }
    }
    
    
    
    init(){
        
        if let sksHeartDisplay = SKScene(fileNamed: "OverlayButtons")?.childNode(withName: "HeartDisplay") as? SKSpriteNode {
        
            heartDisplay = sksHeartDisplay
        }
        
        if let sksCoinMeter = SKScene(fileNamed: "OverlayButtons")?.childNode(withName: "CoinMeter") as? SKSpriteNode{
            coinMeter = sksCoinMeter
        }
        
    }
    
    func getMainHealthMeter() -> SKSpriteNode?{
        return heartDisplay
    }
    
    func getCoinMeter() -> SKSpriteNode?{
        return coinMeter
    }
    
    
    func setHUDPosition(position: CGPoint?){
        guard let heartDisplay = heartDisplay else {
            print("Error: failed to load the main health meter while setting the HUD position")
            return
        }
        
        heartDisplay.anchorPoint = CGPoint(x: 0.0, y: 1.0)
        
        let xPos = -ScreenSizeConstants.HalfScreenWidth*0.80
        let yPos = ScreenSizeConstants.HalfScreenHeight*0.90
        
        let adjustedHUDposition = position ?? CGPoint(x: xPos, y: yPos)
        
        heartDisplay.position = adjustedHUDposition
    }
    
    
    func setCoinMeterPosition(position: CGPoint?){
        
        guard let coinMeter = coinMeter else {
            print("Error: failed to load the main coin meter while setting the coin meter position")
                return
            }
        
        coinMeter.anchorPoint = CGPoint(x: 0.00, y: 1.00)
        
        let xPos = ScreenSizeConstants.HalfScreenWidth*0.50
        let yPos = -ScreenSizeConstants.HalfScreenHeight*0.85
        
        let adjustedCoinMeterPosition = position ?? CGPoint(x: xPos, y: yPos)
        coinMeter.position = adjustedCoinMeterPosition
    }
    
    func resetHUD(){
        
        guard let hudUpdateAction = getHUDAdjustmentAction(forHealthLevel: 8) else {
            print("Error: failed to load the texture for HUD update action")
            return
        }
        
        if let mainHealthMeter = heartDisplay{
            mainHealthMeter.run(hudUpdateAction)
        }
    }
    
    func updateHUD(forHealthLevel healthLevel: Int){
        
        guard let hudUpdateAction = getHUDAdjustmentAction(forHealthLevel: healthLevel) else {
            print("Error: failed to load the texture for HUD update action")
            return
        }
        
        if let mainHealthMeter = heartDisplay{
            mainHealthMeter.run(hudUpdateAction)
        }
        
        
    }
    
    func resetCoinMeter(){
        updateCoinMeter(numberOfGoldCoins: 0, numberOfSilverCoins: 0, numberOfBronzeCoins: 0)
    }
    
    func updateCoinMeter(numberOfGoldCoins: Int?, numberOfSilverCoins: Int?, numberOfBronzeCoins: Int?){
        
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumIntegerDigits = 3
        numberFormatter.minimumFractionDigits = 0
        
        
        if let numberOfGoldCoins = numberOfGoldCoins{
            let numberGoldCoins = NSNumber(value: numberOfGoldCoins)
            let numberString = numberFormatter.string(from: numberGoldCoins)

            
            if let coinMeter = coinMeter,let goldCoinLabel = coinMeter.childNode(withName: "GoldCoinLabel") as? SKLabelNode{
                
                    goldCoinLabel.text = numberString
            }
        }
        
        
        if let numberOfSilverCoins = numberOfSilverCoins{
            let numberSilverCoins = NSNumber(value: numberOfSilverCoins)
            let numberString = numberFormatter.string(from: numberSilverCoins)

            if let coinMeter = coinMeter,let silverCoinLabel = coinMeter.childNode(withName: "SilverCoinLabel") as? SKLabelNode{
                
                silverCoinLabel.text = numberString
            }
            
        }
        
        if let numberOfBronzeCoins = numberOfBronzeCoins{
            let numberBronzeCoins = NSNumber(value: numberOfBronzeCoins)
            let numberString = numberFormatter.string(from: numberBronzeCoins)

            if let coinMeter = coinMeter,let bronzeCoinLabel = coinMeter.childNode(withName: "BronzeCoinLabel") as? SKLabelNode{
                
                bronzeCoinLabel.text = numberString
            }
            
        }
        
        
    }
    
    private func getHUDAdjustmentAction(forHealthLevel healthLevel: Int) -> SKAction?{
        
        var actionGroup: SKAction?
        
        let setHalfHeartAction = SKAction.setTexture(SKTexture(image: #imageLiteral(resourceName: "hud_heartHalf")))
        let setFullHeartAction = SKAction.setTexture(SKTexture(image: #imageLiteral(resourceName: "hud_heartFull")))
        let setEmptyHeartAction = SKAction.setTexture(SKTexture(image: #imageLiteral(resourceName: "hud_heartEmpty")))
        
        switch(healthLevel){
            case 8:
                actionGroup = SKAction.group([
                    SKAction.run(setFullHeartAction, onChildWithName: "Heart4"),
                    SKAction.run(setFullHeartAction, onChildWithName: "Heart3"),
                    SKAction.run(setFullHeartAction, onChildWithName: "Heart2"),
                    SKAction.run(setFullHeartAction, onChildWithName: "Heart1")
                    ])
                break
            case 7:
                actionGroup = SKAction.group([
                    SKAction.run(setHalfHeartAction, onChildWithName: "Heart4"),
                    SKAction.run(setFullHeartAction, onChildWithName: "Heart3"),
                    SKAction.run(setFullHeartAction, onChildWithName: "Heart2"),
                    SKAction.run(setFullHeartAction, onChildWithName: "Heart1")
                    ])
                break
            case 6:
                actionGroup = SKAction.group([
                    SKAction.run(setEmptyHeartAction, onChildWithName: "Heart4"),
                    SKAction.run(setFullHeartAction, onChildWithName: "Heart3"),
                    SKAction.run(setFullHeartAction, onChildWithName: "Heart2"),
                    SKAction.run(setFullHeartAction, onChildWithName: "Heart1")
                    ])
                break
            case 5:
                actionGroup = SKAction.group([
                    SKAction.run(setEmptyHeartAction, onChildWithName: "Heart4"),
                    SKAction.run(setHalfHeartAction, onChildWithName: "Heart3"),
                    SKAction.run(setFullHeartAction, onChildWithName: "Heart2"),
                    SKAction.run(setFullHeartAction, onChildWithName: "Heart1")
                    ])
                break
            case 4:
                actionGroup = SKAction.group([
                    SKAction.run(setEmptyHeartAction, onChildWithName: "Heart4"),
                    SKAction.run(setEmptyHeartAction, onChildWithName: "Heart3"),
                    SKAction.run(setFullHeartAction, onChildWithName: "Heart2"),
                    SKAction.run(setFullHeartAction, onChildWithName: "Heart1")
                    ])
                break
            case 3:
                actionGroup = SKAction.group([
                    SKAction.run(setEmptyHeartAction, onChildWithName: "Heart4"),
                    SKAction.run(setEmptyHeartAction, onChildWithName: "Heart3"),
                    SKAction.run(setHalfHeartAction, onChildWithName: "Heart2"),
                    SKAction.run(setFullHeartAction, onChildWithName: "Heart1")
                    ])
                break
            case 2:
                actionGroup = SKAction.group([
                    SKAction.run(setEmptyHeartAction, onChildWithName: "Heart4"),
                    SKAction.run(setEmptyHeartAction, onChildWithName: "Heart3"),
                    SKAction.run(setEmptyHeartAction, onChildWithName: "Heart2"),
                    SKAction.run(setFullHeartAction, onChildWithName: "Heart1")
                    ])
                break
            case 1:
                actionGroup = SKAction.group([
                    SKAction.run(setEmptyHeartAction, onChildWithName: "Heart4"),
                    SKAction.run(setEmptyHeartAction, onChildWithName: "Heart3"),
                    SKAction.run(setEmptyHeartAction, onChildWithName: "Heart2"),
                    SKAction.run(setHalfHeartAction, onChildWithName: "Heart1")
                    ])
                break
            case 0:
                actionGroup = SKAction.group([
                    SKAction.run(setEmptyHeartAction, onChildWithName: "Heart4"),
                    SKAction.run(setEmptyHeartAction, onChildWithName: "Heart3"),
                    SKAction.run(setEmptyHeartAction, onChildWithName: "Heart2"),
                    SKAction.run(setEmptyHeartAction, onChildWithName: "Heart1")
                    ])
                break
            default:
                break
            
        }
        
        return actionGroup
    }
    
}
