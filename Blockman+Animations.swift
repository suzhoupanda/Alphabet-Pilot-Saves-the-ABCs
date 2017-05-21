//
//  Blockman+Animations.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/8/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

extension BlockMan{
    
    static func GetBlockmanTexture(blockType: BlockMan.BlockType) -> SKTexture?{
    
        switch blockType{
            case .Grass:
                return TextureAtlasManager.sharedManager.blockmanTextureAtlas!.textureNamed("grassBlock")
            
            case .Slime:
                return TextureAtlasManager.sharedManager.blockmanTextureAtlas!.textureNamed("slimeBlock")
            
        }
    }
    
    static func GetBlockmanAnimationsDict(blockType: BlockMan.BlockType) -> [String: SKAction]{
        
        switch blockType{
            case .Grass:
                return BlockMan.AnimationsDictGrass
            case .Slime:
                return BlockMan.AnimationsDictSlime
            
        }
    }
    
    static let AnimationsDictGrass: [String: SKAction] = [
        "flashing" : SKAction.animate(with: [
            TextureAtlasManager.sharedManager.blockmanTextureAtlas!.textureNamed("grassBlock"),
            TextureAtlasManager.sharedManager.blockmanTextureAtlas!.textureNamed("grassBlock_hit"),

            ], timePerFrame: 0.10),
        
        "normal" : SKAction.setTexture(TextureAtlasManager.sharedManager.blockmanTextureAtlas!.textureNamed("grassBlock"))
    ]
    
    static let AnimationsDictSlime: [String: SKAction] = [
    
        "flashing" : SKAction.animate(with: [
            TextureAtlasManager.sharedManager.blockmanTextureAtlas!.textureNamed("slimeBlock"),
            TextureAtlasManager.sharedManager.blockmanTextureAtlas!.textureNamed("slimeBlock_hit")
            ], timePerFrame: 0.10),
        
        "normal" : SKAction.setTexture(TextureAtlasManager.sharedManager.blockmanTextureAtlas!.textureNamed("slimeBlock"))
    ]

}
