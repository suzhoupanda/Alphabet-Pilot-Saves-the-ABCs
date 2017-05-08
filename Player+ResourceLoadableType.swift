//
//  Player+ResourceLoadableType.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/8/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

/** Conformance to ResoruceLoadableType protocol: allows for textures, sounds, and other assets relevant to the player to be loaded and purged dynamically based on the resource-needs of specific scenes 
 **/

extension Player: ResourceLoadableType{
    
    
    static let textureAtlasManager = TextureAtlasManager.sharedManager
    
    
    static var resourcesNeedLoading: Bool{
        return !Player.TextureAtlasNames.isEmpty
    }
    
    static func loadResources(withCompletionHandler completionHandler: @escaping () -> ()){
        
        SKTextureAtlas.preloadTextureAtlasesNamed(TextureAtlasNames, withCompletionHandler: {
            
            error, playerTextureAtlases in
            
            if error != nil{
                fatalError("Error: one or more texture atlases couldn't be loaded for the player entity")
            }
            
            textureAtlasManager.planeTextureAtlas = playerTextureAtlases[0]
            textureAtlasManager.regularExplosionTextureAtlas = playerTextureAtlases[1]
            
            completionHandler()
            
        })
    }
    
    static func purgeResoures(){
        textureAtlasManager.planeTextureAtlas = nil
        textureAtlasManager.regularExplosionTextureAtlas = nil
    }
    
    static func loadMiscellaneousAssets(){
        
    }
    
    static let TextureAtlasNames : [String] = [
        "Planes",
        "RegularExplosion"
    ]
}
