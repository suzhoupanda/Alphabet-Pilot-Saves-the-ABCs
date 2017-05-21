//
//  EvilSun+Animations.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/4/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

extension EvilSun{
    
    static let AnimationsDict: [String: SKAction] = [
        "turnAnimation" : SKAction.animate(with: [
            TextureAtlasManager.sharedManager.sunTextureAtlas!.textureNamed("sun1"),
            TextureAtlasManager.sharedManager.sunTextureAtlas!.textureNamed("sun2"),

            ], timePerFrame: 0.20)
    ]

    
}
