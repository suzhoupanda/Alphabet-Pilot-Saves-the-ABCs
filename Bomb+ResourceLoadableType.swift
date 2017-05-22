//
//  Bomb+ResourceLoadableType.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/22/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit

extension Bomb: ResourceLoadableType{
    
    static let textureAtlasManager = TextureAtlasManager.sharedManager
    
    static var resourcesNeedLoading: Bool{
        return !Bomb.TextureAtlasNames.isEmpty
    }
    
    static func loadResources(withCompletionHandler completionHandler: @escaping () -> ()){
        
        SKTextureAtlas.preloadTextureAtlasesNamed(TextureAtlasNames, withCompletionHandler: {
            
            error, bombTextureAtlases in
            
            if error != nil{
                fatalError("Error: one or more texture atlases couldn't be loaded for the player entity")
            }
            
            textureAtlasManager.bombTextureAtlas = bombTextureAtlases[0]
            
            completionHandler()
            
        })
    }
    
    static func purgeResoures(){
        textureAtlasManager.bombTextureAtlas = nil
    }
    
    static func loadMiscellaneousAssets(){
        
    }
    
    static let TextureAtlasNames : [String] = [
        "Bomb"
    ]
    
    

    
    
}
