//
//  LaserGun+ResourceLoadableType.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/25/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit

extension LaserGun: ResourceLoadableType{
    
    
    static let textureAtlasManager = TextureAtlasManager.sharedManager
    
    static var resourcesNeedLoading: Bool{
        return !LaserGun.TextureAtlasNames.isEmpty
    }
    
    static func loadResources(withCompletionHandler completionHandler: @escaping () -> ()){
        
        SKTextureAtlas.preloadTextureAtlasesNamed(TextureAtlasNames, withCompletionHandler: {
            
            error, beamsTextureAtlases in
            
            if error != nil{
                fatalError("Error: one or more texture atlases couldn't be loaded for the player entity")
            }
            
            textureAtlasManager.beamsTextureAtlas = beamsTextureAtlases[0]
            
            completionHandler()
            
        })
    }
    
    static func purgeResoures(){
        textureAtlasManager.beamsTextureAtlas = nil
    }
    
    static func loadMiscellaneousAssets(){
        
    }
    
    static let TextureAtlasNames : [String] = [
        "Beams"
    ]

}
