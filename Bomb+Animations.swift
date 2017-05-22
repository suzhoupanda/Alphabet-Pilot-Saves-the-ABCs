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
            
        TextureAtlasManager.sharedManager.regularExplosionTextureAtlas!.textureNamed("regularExplosion01"),
        TextureAtlasManager.sharedManager.regularExplosionTextureAtlas!.textureNamed("regularExplosion02"),
        TextureAtlasManager.sharedManager.regularExplosionTextureAtlas!.textureNamed("regularExplosion03"),
        TextureAtlasManager.sharedManager.regularExplosionTextureAtlas!.textureNamed("regularExplosion04"),
        TextureAtlasManager.sharedManager.regularExplosionTextureAtlas!.textureNamed("regularExplosion05"),
        TextureAtlasManager.sharedManager.regularExplosionTextureAtlas!.textureNamed("regularExplosion06"),
            
        TextureAtlasManager.sharedManager.regularExplosionTextureAtlas!.textureNamed("regularExplosion07"),
            
        TextureAtlasManager.sharedManager.regularExplosionTextureAtlas!.textureNamed("regularExplosion08")
            
            ], timePerFrame: 0.10)
    
    ]
}
