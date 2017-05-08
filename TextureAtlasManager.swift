//
//  TextureAtlasManager.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/8/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit


class TextureAtlasManager{
    
    static let sharedManager = TextureAtlasManager()
    
    var planeTextureAtlas: SKTextureAtlas?
    var regularExplosionTextureAtlas: SKTextureAtlas?
    
    private init(){
        
    }
    
}
