//
//  Letter+ResourceLoadableType.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/15/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit

extension Letter: ResourceLoadableType{
    
    static let textureAtlasManager = TextureAtlasManager.sharedManager
    
    static var resourcesNeedLoading: Bool{
        return !Letter.TextureAtlasNames.isEmpty
    }
    
    static func loadResources(withCompletionHandler completionHandler: @escaping () -> ()){
        
        SKTextureAtlas.preloadTextureAtlasesNamed(TextureAtlasNames, withCompletionHandler: {
            
            error, letterTextureAtlases in
            
            if error != nil{
                fatalError("Error: one or more texture atlases couldn't be loaded for the player entity")
            }
            
            textureAtlasManager.letterTextureAtlas = letterTextureAtlases[0]
            
            completionHandler()
            
        })
    }
    
    static func purgeResoures(){
        textureAtlasManager.letterTextureAtlas = nil
    }
    
    static func loadMiscellaneousAssets(){
        
    }

    
    static let TextureAtlasNames: [String] = [
        "Letter"
    
    ]
}
