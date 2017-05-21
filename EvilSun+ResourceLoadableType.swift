//
//  EvilSun+ResourceLoadableType.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/21/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit

extension EvilSun: ResourceLoadableType{
    
    static let textureAtlasManager = TextureAtlasManager.sharedManager
    
    static var resourcesNeedLoading: Bool{
        return !EvilSun.TextureAtlasNames.isEmpty
    }

    static func loadResources(withCompletionHandler completionHandler: @escaping () -> ()){
    
        SKTextureAtlas.preloadTextureAtlasesNamed(TextureAtlasNames, withCompletionHandler: {
        
            error, sunTextureAtlases in
        
            if error != nil{
                fatalError("Error: one or more texture atlases couldn't be loaded for the player entity")
            }
        
            textureAtlasManager.sunTextureAtlas = sunTextureAtlases[0]
        
            completionHandler()
        
        })
    }

    static func purgeResoures(){
        textureAtlasManager.sunTextureAtlas = nil
    }

    static func loadMiscellaneousAssets(){
    
    }

    static let TextureAtlasNames : [String] = [
        "Sun"
    ]

}
