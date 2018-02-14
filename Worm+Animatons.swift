//
//  Worm+Animatinos.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/8/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//


import Foundation
import SpriteKit
import GameplayKit

extension Worm{
    
    
    static func GetWormTexture(wormColor: Worm.WormColor) -> SKTexture?{
        switch wormColor{
        case .Green:
            return TextureAtlasManager.sharedManager.wormTextureAtlas?.textureNamed("wormGreen")
        case .Pink:
            return TextureAtlasManager.sharedManager.wormTextureAtlas?.textureNamed("wormPink")
        }
    }
    
    
 
}
