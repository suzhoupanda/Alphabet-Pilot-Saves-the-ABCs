//
//  Alien+ResourceLoadableType.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/15/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit

extension Alien: ResourceLoadableType{

    static let textureAtlasManager = TextureAtlasManager.sharedManager


    static var resourcesNeedLoading: Bool{
        return !Alien.TextureAtlasNames.isEmpty
    }

    static func loadResources(withCompletionHandler completionHandler: @escaping () -> ()){
    
        SKTextureAtlas.preloadTextureAtlasesNamed(TextureAtlasNames, withCompletionHandler: {
        
        error, alienTextureAtlases in
        
        if error != nil{
            fatalError("Error: one or more texture atlases couldn't be loaded for the player entity")
        }
        
        textureAtlasManager.alienTextureAtlas = alienTextureAtlases[0]
        
        completionHandler()
        
        })
    }

    static func purgeResoures(){
        textureAtlasManager.alienTextureAtlas = nil
    }

    static func loadMiscellaneousAssets(){
    
    }

    static let TextureAtlasNames : [String] = [
        "Alien"
    ]

}

