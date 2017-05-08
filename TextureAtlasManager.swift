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
    
    
    //MARK: ********* Texture atlases below are pre-loaded at the start of the app because of recurring usage throughout different scene-levels (i.e. UI texture atlas)
    
    
    //MARK: ****** Texture atlases below are loaded dynamically per the resource-needs of the particular scene
    
    var planeTextureAtlas: SKTextureAtlas?
    var regularExplosionTextureAtlas: SKTextureAtlas?
    
    private init(){
        
    }
    
}
