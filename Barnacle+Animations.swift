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
                return TextureAtlasManager.sharedManager.barnacleTextureAtlas!.textureNamed("barnacle_bite")
            case .Down:
                return TextureAtlasManager.sharedManager.barnacleTextureAtlas!.textureNamed("barnacle_down")
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
        
        "closed" : SKAction.setTexture(TextureAtlasManager.sharedManager.barnacleTextureAtlas!.textureNamed("barnacle_down")),
        
        "open": SKAction.setTexture(TextureAtlasManager.sharedManager.barnacleTextureAtlas!.textureNamed("barnacle_attack_down")),
        
        "flashing" : SKAction.animate(with: [
        TextureAtlasManager.sharedManager.barnacleTextureAtlas!.textureNamed("barnacle_attack_down"),
        TextureAtlasManager.sharedManager.barnacleTextureAtlas!.textureNamed("barnacle_hit_down"),
            ], timePerFrame: 0.10)
        
    ]
    
    static let AnimationsDictUp: [String: SKAction] = [
        
        "closed" : SKAction.setTexture(TextureAtlasManager.sharedManager.barnacleTextureAtlas!.textureNamed("barnacle_bite")),
        
        "open": SKAction.setTexture(TextureAtlasManager.sharedManager.barnacleTextureAtlas!.textureNamed("barnacle")),
        
        "flashing" : SKAction.animate(with: [
            TextureAtlasManager.sharedManager.barnacleTextureAtlas!.textureNamed("barnacle"),
        TextureAtlasManager.sharedManager.barnacleTextureAtlas!.textureNamed("barnacle_hit")
            ], timePerFrame: 0.10)
        
    ]
}
