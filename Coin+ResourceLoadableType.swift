//
//  Coin+ResourceLoadableType.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/15/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit


extension Coin: ResourceLoadableType{
    
    static let textureAtlasManager = TextureAtlasManager.sharedManager
    
    static var resourcesNeedLoading: Bool{
        return !Coin.TextureAtlasNames.isEmpty
    }
    
    static func loadResources(withCompletionHandler completionHandler: @escaping () -> ()){
        
        SKTextureAtlas.preloadTextureAtlasesNamed(TextureAtlasNames, withCompletionHandler: {
            
            error, coinTextureAtlases in
            
            if error != nil{
                fatalError("Error: one or more texture atlases couldn't be loaded for the player entity")
            }
            
            textureAtlasManager.coinTextureAtlas = coinTextureAtlases[0]
            
            completionHandler()
            
        })
    }
    
    static func purgeResoures(){
        textureAtlasManager.coinTextureAtlas = nil
    }
    
    static func loadMiscellaneousAssets(){
        
    }
    
    
    static let TextureAtlasNames: [String] = [
        "Coin"
        
    ]

    
}
