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
        
        return SKAction.setTexture(getAlienTexture(forTextureName: textureName))
        
    }

    static func getAlienTexture(forTextureName textureName: String) -> SKTexture{
        
        guard let alienTextureAtlas = TextureAtlasManager.sharedManager.alienTextureAtlas else {    print("Error: alien texture atlas failed to load")
                return SKTexture(imageNamed: textureName)
            }
        
        return alienTextureAtlas.textureNamed(textureName)
    }
}
