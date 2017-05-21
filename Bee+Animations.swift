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
            TextureAtlasManager.sharedManager.beeTextureAtlas!.textureNamed("bee_fly"),
            TextureAtlasManager.sharedManager.beeTextureAtlas!.textureNamed("bee"),
            ], timePerFrame: 0.10),
        
        "beeFlyRight": SKAction.animate(with: [
            TextureAtlasManager.sharedManager.beeTextureAtlas!.textureNamed("beeRight"),
            TextureAtlasManager.sharedManager.beeTextureAtlas!.textureNamed("bee_flyRight")

            ], timePerFrame: 0.10),
        
        "beeDeadLeft": SKAction.setTexture(TextureAtlasManager.sharedManager.beeTextureAtlas!.textureNamed("bee_dead")),
        
        "beeDeadRight": SKAction.setTexture(TextureAtlasManager.sharedManager.beeTextureAtlas!.textureNamed("beeDeadRight")),
        
        "beeAttackLeft": SKAction.animate(with: [
            TextureAtlasManager.sharedManager.beeTextureAtlas!.textureNamed("bee_hit"),
            TextureAtlasManager.sharedManager.beeTextureAtlas!.textureNamed("bee"),

            ], timePerFrame: 0.10),
        
        "beeAttackRight": SKAction.animate(with: [
            TextureAtlasManager.sharedManager.beeTextureAtlas!.textureNamed("beeRight"),
            TextureAtlasManager.sharedManager.beeTextureAtlas!.textureNamed("bee_hitRight")
            ], timePerFrame: 0.10)
        
    ]
}
