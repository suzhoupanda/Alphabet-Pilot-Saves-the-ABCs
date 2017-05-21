//
//  Fly+Animations.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/6/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

extension Fly{
    
    static let AnimationsDict: [String: SKAction] = [
        "flappingLeft" : SKAction.animate(with: [
            TextureAtlasManager.sharedManager.flyTextureAtlas!.textureNamed("fly"),
            TextureAtlasManager.sharedManager.flyTextureAtlas!.textureNamed("fly_fly")
            ], timePerFrame: 0.20),
        
        "flappingRight" : SKAction.animate(with: [
            TextureAtlasManager.sharedManager.flyTextureAtlas!.textureNamed("flyRight1"),
            TextureAtlasManager.sharedManager.flyTextureAtlas!.textureNamed("flyRight2")
            ], timePerFrame: 0.20),
        
        
    ]
    
}
