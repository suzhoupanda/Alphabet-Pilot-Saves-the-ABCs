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
            TextureAtlasManager.sharedManager.beamsTextureAtlas!.textureNamed("laserGunLeft2"),
            TextureAtlasManager.sharedManager.beamsTextureAtlas!.textureNamed("laserGunLeft1")
            ], timePerFrame: 0.20)
    ]
    
    static let AnimationsDictTop : [String: SKAction] = [
        "fireAnimation" : SKAction.animate(with: [
            TextureAtlasManager.sharedManager.beamsTextureAtlas!.textureNamed("laserGunTop2"),
            TextureAtlasManager.sharedManager.beamsTextureAtlas!.textureNamed("laserGunTop1")
            ], timePerFrame: 0.20)
    ]
    
    static let AnimationsDictBottom : [String: SKAction] = [
        "fireAnimation" : SKAction.animate(with: [
        TextureAtlasManager.sharedManager.beamsTextureAtlas!.textureNamed("laserGunBottom2"),
        TextureAtlasManager.sharedManager.beamsTextureAtlas!.textureNamed("laserGunBottom1")
            ], timePerFrame: 0.20)
    ]
    
   
}
