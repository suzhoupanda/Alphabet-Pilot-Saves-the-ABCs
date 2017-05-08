//
//  Barnacle+Animations.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/7/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit


extension Barnacle{
    
    static func getBarnacleTexture(orientation: BarnacleOrientation) -> SKTexture?{
        
        switch orientation{
            case .Up:
                return SKTexture(image: #imageLiteral(resourceName: "barnacle_bite"))
            case .Down:
                return SKTexture(image: #imageLiteral(resourceName: "barnacle_down"))
        }
    }
    
    static func getBarnacleAnimationsDict(orientation: BarnacleOrientation) -> [String: SKAction]{
        
        switch orientation{
            case .Up:
                return Barnacle.AnimationsDictUp
            case .Down:
                return Barnacle.AnimationsDictDown
            }
        
    }
    
    static let AnimationsDictDown: [String: SKAction] = [
        
        "closed" : SKAction.setTexture(SKTexture(image: #imageLiteral(resourceName: "barnacle_down"))),
        
        "open": SKAction.setTexture(SKTexture(image: #imageLiteral(resourceName: "barnacle_attack_down"))),
        
        "flashing" : SKAction.animate(with: [
            SKTexture(image: #imageLiteral(resourceName: "barnacle_attack_down")),
            SKTexture(image: #imageLiteral(resourceName: "barnacle_hit_down"))
            ], timePerFrame: 0.10)
        
    ]
    
    static let AnimationsDictUp: [String: SKAction] = [
        
        "closed" : SKAction.setTexture(SKTexture(image: #imageLiteral(resourceName: "barnacle_bite"))),
        
        "open": SKAction.setTexture(SKTexture(image: #imageLiteral(resourceName: "barnacle"))),
        
        "flashing" : SKAction.animate(with: [
                SKTexture(image: #imageLiteral(resourceName: "barnacle")),
                SKTexture(image: #imageLiteral(resourceName: "barnacle_hit"))
            ], timePerFrame: 0.10)
        
    ]
}
