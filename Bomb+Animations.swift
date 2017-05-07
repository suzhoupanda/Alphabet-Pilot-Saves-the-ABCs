//
//  Bomb+Animations.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/7/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit


extension Bomb{
    
    static let AnimationsDict: [String: SKAction] = [
    
        "explode" : SKAction.animate(with: [
            SKTexture(image: #imageLiteral(resourceName: "regularExplosion01")),
            SKTexture(image: #imageLiteral(resourceName: "regularExplosion02")),
            SKTexture(image: #imageLiteral(resourceName: "regularExplosion03")),
            SKTexture(image: #imageLiteral(resourceName: "regularExplosion04")),
            SKTexture(image: #imageLiteral(resourceName: "regularExplosion05")),
            SKTexture(image: #imageLiteral(resourceName: "regularExplosion06")),
            SKTexture(image: #imageLiteral(resourceName: "regularExplosion07")),
            SKTexture(image: #imageLiteral(resourceName: "regularExplosion08"))
            ], timePerFrame: 0.10)
    
    ]
}
