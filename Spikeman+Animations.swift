//
//  Spikeman+Animations.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/7/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

extension Spikeman{
    
    static let AnimationsDict: [String: SKAction] = [
    
        "walkLeft" : SKAction.animate(with: [
        TextureAtlasManager.sharedManager.spikemanTextureAtlas!.textureNamed("spikeMan_walk2_left"),
        TextureAtlasManager.sharedManager.spikemanTextureAtlas!.textureNamed("spikeMan_walk1_left"),
    
            ], timePerFrame: 0.20),
        
        "walkRight" : SKAction.animate(with: [
            
        TextureAtlasManager.sharedManager.spikemanTextureAtlas!.textureNamed("spikeMan_walk2"),
        TextureAtlasManager.sharedManager.spikemanTextureAtlas!.textureNamed("spikeMan_walk1"),
           
            ], timePerFrame: 0.20),
        
        "stand" :
            SKAction.setTexture(TextureAtlasManager.sharedManager.spikemanTextureAtlas!.textureNamed("spikeMan_stand")),
        
        "jump" : SKAction.setTexture(TextureAtlasManager.sharedManager.spikemanTextureAtlas!.textureNamed("spikeMan_jump"))
    
    
    ]
}
