//
//  Spikeman+Animations.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/7/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

extension Spikeman{
    
    static let AnimationsDict: [String: SKAction] = [
    
        "walkLeft" : SKAction.animate(with: [
            SKTexture(image: #imageLiteral(resourceName: "spikeMan_walk2_left")),
            SKTexture(image: #imageLiteral(resourceName: "spikeMan_walk1_left"))
            ], timePerFrame: 0.20),
        
        "walkRight" : SKAction.animate(with: [
            SKTexture(image: #imageLiteral(resourceName: "spikeMan_walk2")),
            SKTexture(image: #imageLiteral(resourceName: "spikeMan_walk1"))
            ], timePerFrame: 0.20),
        
        "stand" : SKAction.setTexture(SKTexture(image: #imageLiteral(resourceName: "spikeMan_stand"))),
        
        "jump" : SKAction.setTexture(SKTexture(image: #imageLiteral(resourceName: "spikeMan_jump")))
    
    
    ]
}
