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
    
    
    static func getPlaneAnimationsDict(forPlaneColor planeColor: PlaneColor) -> [String: SKAction]{
        
        switch planeColor{
            case .Blue:
                return AnimationsDictYellow
            case .Green:
                return AnimationsDictGreen
            case .Red:
                return AnimationsDictRed
            case .Yellow:
                return AnimationsDictYellow
        }
    }
    
    static let AnimationsDictYellow: [String: SKAction] = [
        
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
        
        "lowVelocity" : SKAction.animate(with: [
            SKTexture(image: #imageLiteral(resourceName: "planeYellow1")),
            SKTexture(image: #imageLiteral(resourceName: "planeYellow2")),
            SKTexture(image: #imageLiteral(resourceName: "planeYellow3"))
            ], timePerFrame: 0.70),
        
        "mediumVelocity" : SKAction.animate(with: [
            SKTexture(image: #imageLiteral(resourceName: "planeYellow1")),
            SKTexture(image: #imageLiteral(resourceName: "planeYellow2")),
            SKTexture(image: #imageLiteral(resourceName: "planeYellow3"))
            ], timePerFrame: 0.50),
        
        "highVelocity" : SKAction.animate(with: [
            SKTexture(image: #imageLiteral(resourceName: "planeYellow1")),
            SKTexture(image: #imageLiteral(resourceName: "planeYellow2")),
            SKTexture(image: #imageLiteral(resourceName: "planeYellow3"))
            ], timePerFrame: 0.10)
        

    ]
    
    static let AnimationsDictGreen: [String: SKAction] = [
        
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
        
        "lowVelocity" : SKAction.animate(with: [
            SKTexture(image: #imageLiteral(resourceName: "planeGreen1")),
            SKTexture(image: #imageLiteral(resourceName: "planeGreen2")),
            SKTexture(image: #imageLiteral(resourceName: "planeGreen3"))
            ], timePerFrame: 0.70),
        
        "mediumVelocity" : SKAction.animate(with: [
            SKTexture(image: #imageLiteral(resourceName: "planeGreen1")),
            SKTexture(image: #imageLiteral(resourceName: "planeGreen2")),
            SKTexture(image: #imageLiteral(resourceName: "planeGreen3"))
            ], timePerFrame: 0.50),
        
        "highVelocity" : SKAction.animate(with: [
            SKTexture(image: #imageLiteral(resourceName: "planeGreen1")),
            SKTexture(image: #imageLiteral(resourceName: "planeGreen2")),
            SKTexture(image: #imageLiteral(resourceName: "planeGreen3"))
            ], timePerFrame: 0.10)
        

        
    ]
    
    static let AnimationsDictBlue: [String: SKAction] = [
        
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
        
        "lowVelocity" : SKAction.animate(with: [
            SKTexture(image: #imageLiteral(resourceName: "planeBlue1")),
            SKTexture(image: #imageLiteral(resourceName: "planeBlue2")),
            SKTexture(image: #imageLiteral(resourceName: "planeBlue3"))
            ], timePerFrame: 0.70),
        
        "mediumVelocity" : SKAction.animate(with: [
            SKTexture(image: #imageLiteral(resourceName: "planeBlue1")),
            SKTexture(image: #imageLiteral(resourceName: "planeBlue2")),
            SKTexture(image: #imageLiteral(resourceName: "planeBlue3"))
            ], timePerFrame: 0.50),
        
        "highVelocity" : SKAction.animate(with: [
            SKTexture(image: #imageLiteral(resourceName: "planeBlue1")),
            SKTexture(image: #imageLiteral(resourceName: "planeBlue2")),
            SKTexture(image: #imageLiteral(resourceName: "planeBlue3"))
            ], timePerFrame: 0.10)
        

    ]
    
    static let AnimationsDictRed: [String: SKAction] = [
        
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
        
        "lowVelocity" : SKAction.animate(with: [
            SKTexture(image: #imageLiteral(resourceName: "planeRed1")),
            SKTexture(image: #imageLiteral(resourceName: "planeRed2")),
            SKTexture(image: #imageLiteral(resourceName: "planeRed3"))
            ], timePerFrame: 0.70),
        
        "mediumVelocity" : SKAction.animate(with: [
            SKTexture(image: #imageLiteral(resourceName: "planeRed1")),
            SKTexture(image: #imageLiteral(resourceName: "planeRed2")),
            SKTexture(image: #imageLiteral(resourceName: "planeRed3"))
            ], timePerFrame: 0.50),
        
        "highVelocity" : SKAction.animate(with: [
            SKTexture(image: #imageLiteral(resourceName: "planeRed1")),
            SKTexture(image: #imageLiteral(resourceName: "planeRed2")),
            SKTexture(image: #imageLiteral(resourceName: "planeRed3"))
            ], timePerFrame: 0.10)
        
        
    ]
    
    
    static func getPlaneTexture(forPlaneColor planeColor: PlaneColor) -> SKTexture?{
        
        switch planeColor{
        case .Blue:
            return SKTexture(image: #imageLiteral(resourceName: "planeBlue1"))
        case .Red:
            return SKTexture(image: #imageLiteral(resourceName: "planeRed1"))
        case .Yellow:
            return SKTexture(image: #imageLiteral(resourceName: "planeYellow1"))
        case .Green:
            return SKTexture(image: #imageLiteral(resourceName: "planeGreen1"))
        default:
            break
        }
        
        return nil
    }
    
}


