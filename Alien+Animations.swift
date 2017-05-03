//
//  Alien+Animations.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/3/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

extension Alien{
    
    static let colorizeAction1 = SKAction.colorize(with: UIColor.red, colorBlendFactor: 0.50, duration: 1.0)
    
    static let colorizeAction2 = Alien.colorizeAction1.reversed()
    
    static let AnimationsDict: [String: SKAction] = [
        
        
        "unmannedPink" : SKAction.setTexture(SKTexture(image: #imageLiteral(resourceName: "shipPink"))),
        "mannedPink" : SKAction.setTexture(SKTexture(image: #imageLiteral(resourceName: "shipPink_manned"))),
        "attack" : SKAction.sequence([
            Alien.colorizeAction1, Alien.colorizeAction2
            
            ])
        ]
}
