//
//  Coin+Animations.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/6/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

extension Coin{
    
    
    
    static let goldAnimationTurn: SKAction = {
        
        guard textureAtlasManager.coinTextureAtlas != nil else {
            
            return SKAction.animate(with: [
                SKTexture(image: #imageLiteral(resourceName: "gold_1")),
                SKTexture(image: #imageLiteral(resourceName: "gold_2")),
                SKTexture(image: #imageLiteral(resourceName: "gold_3")),
            ], timePerFrame: 0.10)
        }
        
        return SKAction.animate(with: [
            textureAtlasManager.coinTextureAtlas!.textureNamed("gold_1"),
            textureAtlasManager.coinTextureAtlas!.textureNamed("gold_2"),
            textureAtlasManager.coinTextureAtlas!.textureNamed("gold_3"),
            ], timePerFrame: 0.10)
        
    }()
    
    static let goldAnimationReverseTurn = goldAnimationTurn.reversed()
    
    static let silverAnimationTurn: SKAction = {
        
        guard textureAtlasManager.coinTextureAtlas != nil else {
            
            return SKAction.animate(with: [
                SKTexture(image: #imageLiteral(resourceName: "silver_1")),
                SKTexture(image: #imageLiteral(resourceName: "silver_2")),
                SKTexture(image: #imageLiteral(resourceName: "silver_3")),
                ], timePerFrame: 0.10)
        }
        
        return SKAction.animate(with: [
            textureAtlasManager.coinTextureAtlas!.textureNamed("silver_1"),
            textureAtlasManager.coinTextureAtlas!.textureNamed("silver_2"),
            textureAtlasManager.coinTextureAtlas!.textureNamed("silver_3"),
            ], timePerFrame: 0.10)
        
    }()
    
    static let silverAnimationReverseTurn = silverAnimationTurn.reversed()

    static let bronzeAnimationTurn: SKAction = {
    
        guard textureAtlasManager.coinTextureAtlas != nil else {
    
            return SKAction.animate(with: [
                SKTexture(image: #imageLiteral(resourceName: "bronze_1")),
                SKTexture(image: #imageLiteral(resourceName: "bronze_2")),
                SKTexture(image: #imageLiteral(resourceName: "bronze_3")),
                ], timePerFrame: 0.10)
            }
    
    return SKAction.animate(with: [
        textureAtlasManager.coinTextureAtlas!.textureNamed("bronze_1"),
        textureAtlasManager.coinTextureAtlas!.textureNamed("bronze_2"),
        textureAtlasManager.coinTextureAtlas!.textureNamed("bronze_3"),
        ], timePerFrame: 0.10)
    
    }()
    
    
    static let bronzeAnimationReverseTurn = bronzeAnimationTurn.reversed()

    
    static let AnimationsDict: [String: SKAction] = [
    
        "goldAnimation" : SKAction.sequence([
            goldAnimationTurn,
            goldAnimationReverseTurn
            ]),
        
        "silverAnimation" : SKAction.sequence([
            silverAnimationTurn,
            silverAnimationReverseTurn
            ]),
        
        "bronzeAnimation" : SKAction.sequence([
            bronzeAnimationTurn,
            bronzeAnimationReverseTurn
            ])
    
    ]
}
