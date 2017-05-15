//
//  Alien+Animations.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/3/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

extension Alien{
    
    static let colorizeAction1 = SKAction.colorize(with: UIColor.red, colorBlendFactor: 0.50, duration: 1.0)
    
    static let colorizeAction2 = Alien.colorizeAction1.reversed()
    
    static let AnimationsDict: [String: SKAction] = [
        
        
        "unmannedPink" : getSetTextureAction(forTextureName: "shipPink"),
        "mannedPink" : getSetTextureAction(forTextureName: "shipPink_manned"),
        
        "unmannedBlue" : getSetTextureAction(forTextureName: "shipBlue"),
        "mannedBlue" : getSetTextureAction(forTextureName: "shipBlue_manned"),
        
        "unmannedYellow" : getSetTextureAction(forTextureName: "shipYellow"),
        "mannedYellow" : getSetTextureAction(forTextureName: "shipYellow_manned"),
        
        "unmannedBeige" : getSetTextureAction(forTextureName: "shipBeige"),
        "mannedBeige"  : getSetTextureAction(forTextureName: "shipBeige_manned"),
                                              
        
        "attack" : SKAction.sequence([
            Alien.colorizeAction1, Alien.colorizeAction2
            
            ])
        ]
    
    static func getActiveAnimationName(alienColor: AlienColor) -> String{
        
        
        var activeAnimationName = String()
        
        switch(alienColor){
        case .Beige:
            activeAnimationName = "mannedBeige"
            break
        case .Blue:
            activeAnimationName = "mannedBlue"
            break
        case .Pink:
            activeAnimationName = "mannedPink"
            break
        case .Yellow:
            activeAnimationName = "mannedYellow"
            break
        }
        
        return activeAnimationName
    }
    
    static func getInactiveAnimationName(alienColor: AlienColor) -> String{
        
        
        var inactiveAnimationName = String()
        
        switch(alienColor){
        case .Beige:
            inactiveAnimationName = "unmannedBeige"
            break
        case .Blue:
            inactiveAnimationName = "unmannedBlue"
            break
        case .Pink:
            inactiveAnimationName = "unmannedPink"
            break
        case .Yellow:
            inactiveAnimationName = "unmannedYellow"
            break
        }
        
        return inactiveAnimationName
    }
    
    
    static func getSetTextureAction(forTextureName textureName: String) -> SKAction{
        
        return SKAction.setTexture(AlienTextures[textureName]!)
        
    }

    static let AlienTextures: [String: SKTexture] = {
        
        //If the texture atlas manager fails to load, SKTexture objects are initialized directly with image arguments
        
        guard TextureAtlasManager.sharedManager.alienTextureAtlas != nil else {
            return [
                "shipBlue": SKTexture(image: #imageLiteral(resourceName: "shipBlue")),
                "shipPink": SKTexture(image: #imageLiteral(resourceName: "shipPink")),
                "shipBeige": SKTexture(image: #imageLiteral(resourceName: "shipBeige")),
                "shipYellow": SKTexture(image: #imageLiteral(resourceName: "shipYellow")),
                "shipBlue_unmanned": SKTexture(image: #imageLiteral(resourceName: "shipBlue_manned")),
                "shipPink_unmanned": SKTexture(image: #imageLiteral(resourceName: "shipPink_manned")),
                "shipBeige_unmanned": SKTexture(image: #imageLiteral(resourceName: "shipBeige_manned")),
                "shipYellow_unmanned": SKTexture(image: #imageLiteral(resourceName: "shipYellow_manned")),

                
            ]
        }
        
        return [
    
            "shipBlue": TextureAtlasManager.sharedManager.alienTextureAtlas!.textureNamed("shipBlue"),
            "shipPink": TextureAtlasManager.sharedManager.alienTextureAtlas!.textureNamed("shipPink"),
            "shipBeige": TextureAtlasManager.sharedManager.alienTextureAtlas!.textureNamed("shipBeige"),
            "shipYellow": TextureAtlasManager.sharedManager.alienTextureAtlas!.textureNamed("shipYellow"),
            "shipPink_unmanned": TextureAtlasManager.sharedManager.alienTextureAtlas!.textureNamed("shipPink_unmanned"),
            "shipBlue_unmanned": TextureAtlasManager.sharedManager.alienTextureAtlas!.textureNamed("shipBlue_unmanned"),
            "shipBeige_unmanned": TextureAtlasManager.sharedManager.alienTextureAtlas!.textureNamed("shipBeige_unmanned"),
            "shipYellow_unmanned": TextureAtlasManager.sharedManager.alienTextureAtlas!.textureNamed("shipYellow_unmanned")
        ]
    }()
}
