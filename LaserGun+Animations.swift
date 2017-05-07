//
//  LaserGun+Animations.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/7/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

extension LaserGun{
    
    
    static func GetAnimationsDict(laserGunOrientation: LaserGunOrientation) -> [String: SKAction]{
        
        var animationsDict = [String: SKAction]()
        
        switch laserGunOrientation{
            case .Bottom:
                animationsDict = LaserGun.AnimationsDictBottom
                break
            case .Left:
                animationsDict = LaserGun.AnimationsDictLeft
                break
            case .Top:
                animationsDict = LaserGun.AnimationsDictTop
                break
        }
        
        return animationsDict
    }

    static let AnimationsDictLeft : [String: SKAction] = [
        "fireAnimation" : SKAction.animate(with: [
            SKTexture(image: #imageLiteral(resourceName: "laserGunLeft2")),
            SKTexture(image: #imageLiteral(resourceName: "laserGunLeft1")),
            ], timePerFrame: 0.20)
    ]
    
    static let AnimationsDictTop : [String: SKAction] = [
        "fireAnimation" : SKAction.animate(with: [
            SKTexture(image: #imageLiteral(resourceName: "laserGunTop2")),
            SKTexture(image: #imageLiteral(resourceName: "laserGunTop1")),
            ], timePerFrame: 0.20)
    ]
    
    static let AnimationsDictBottom : [String: SKAction] = [
        "fireAnimation" : SKAction.animate(with: [
            SKTexture(image: #imageLiteral(resourceName: "laserGunBottom2")),
            SKTexture(image: #imageLiteral(resourceName: "laserGunBottom1")),
            ], timePerFrame: 0.20)
    ]
    
   
}
