//
//  Player+AnimationsDict.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/2/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

extension Player{
    
    
    static let AnimationsDict: [String: SKAction] = [
        
        "dead" : SKAction.sequence([
            SKAction.animate(with: [
                SKTexture(image: #imageLiteral(resourceName: "regularExplosion00")),
                SKTexture(image: #imageLiteral(resourceName: "regularExplosion01")),
                SKTexture(image: #imageLiteral(resourceName: "regularExplosion02")),
                SKTexture(image: #imageLiteral(resourceName: "regularExplosion03")),
                SKTexture(image: #imageLiteral(resourceName: "regularExplosion04")),
                SKTexture(image: #imageLiteral(resourceName: "regularExplosion05")),
                SKTexture(image: #imageLiteral(resourceName: "regularExplosion06")),
                SKTexture(image: #imageLiteral(resourceName: "regularExplosion07"))
                ], timePerFrame: 0.10),
            SKAction.removeFromParent()
            
            ]),
        
        "damaged" : SKAction.sequence([
            SKAction.fadeAlpha(to: 0.60, duration: 0.50),
            SKAction.fadeAlpha(to: 0.80, duration: 0.50)
            ]),
        
        "lowVelocityRed" : SKAction.animate(with: [
            SKTexture(image: #imageLiteral(resourceName: "planeRed1")),
            SKTexture(image: #imageLiteral(resourceName: "planeRed2")),
            SKTexture(image: #imageLiteral(resourceName: "planeRed3"))
            ], timePerFrame: 0.70),
        
        "mediumVelocityRed" : SKAction.animate(with: [
            SKTexture(image: #imageLiteral(resourceName: "planeRed1")),
            SKTexture(image: #imageLiteral(resourceName: "planeRed2")),
            SKTexture(image: #imageLiteral(resourceName: "planeRed3"))
            ], timePerFrame: 0.50),
        
        "highVelocityRed" : SKAction.animate(with: [
            SKTexture(image: #imageLiteral(resourceName: "planeRed1")),
            SKTexture(image: #imageLiteral(resourceName: "planeRed2")),
            SKTexture(image: #imageLiteral(resourceName: "planeRed3"))
            ], timePerFrame: 0.10)
        
        
    ]
    
}


