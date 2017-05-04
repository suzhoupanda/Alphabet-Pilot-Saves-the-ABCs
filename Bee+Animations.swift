//
//  Bee+Animations.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/4/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

extension Bee{
    
    static func getFlyAnimation(forOrientation orientation: Orientation) -> String{
        
        switch orientation{
            case .Left:
                return "beeFlyLeft"
            case .Right:
                return "beeFlyRight"
            case .None:
                return "beeFlyLeft"
        }
        
        
    }
    
    static func getDeadAnimation(forOrientation orientation: Orientation) -> String{
        switch orientation{
        case .Left:
            return "beeDeadLeft"
        case .Right:
            return "beeDeadRight"
        case .None:
            return "beeDeadLeft"
        }
    }
    
    static func getAttackAnimation(forOrientation orientation: Orientation) -> String{
        switch orientation{
        case .Left:
            return "beeAttackLeft"
        case .Right:
            return "beeAttackRight"
        case .None:
            return "beeAttackLeft"
        }
    }
    
    static let AnimationsDict: [String: SKAction] = [
        
        "beeFlyLeft": SKAction.animate(with: [
            SKTexture(image: #imageLiteral(resourceName: "bee_fly")),
            SKTexture(image: #imageLiteral(resourceName: "bee"))
            ], timePerFrame: 0.10),
        
        "beeFlyRight": SKAction.animate(with: [
            SKTexture(image: #imageLiteral(resourceName: "beeRight")),
            SKTexture(image: #imageLiteral(resourceName: "bee_flyRight"))
            ], timePerFrame: 0.10),
        
        "beeDeadLeft": SKAction.setTexture(SKTexture(image: #imageLiteral(resourceName: "bee_dead"))),
        
        "beeDeadRight": SKAction.setTexture(SKTexture(image: #imageLiteral(resourceName: "beeDeadRight"))),
        
        "beeAttackLeft": SKAction.animate(with: [
            SKTexture(image: #imageLiteral(resourceName: "bee_hit")),
            SKTexture(image: #imageLiteral(resourceName: "bee"))
            ], timePerFrame: 0.10),
        
        "beeAttackRight": SKAction.animate(with: [
            SKTexture(image: #imageLiteral(resourceName: "beeRight")),
            SKTexture(image: #imageLiteral(resourceName: "bee_hitRight"))
            ], timePerFrame: 0.10)
        
    ]
}
