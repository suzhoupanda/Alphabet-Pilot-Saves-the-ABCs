//
//  Blockman+Animations.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/8/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

extension BlockMan{
    
    static func GetBlockmanTexture(blockType: BlockMan.BlockType) -> SKTexture?{
    
        switch blockType{
            case .Grass:
                return SKTexture(image: #imageLiteral(resourceName: "grassBlock"))
            
            case .Slime:
                return SKTexture(image: #imageLiteral(resourceName: "slimeBlock"))
                
        }
    }
    
    static func GetBlockmanAnimationsDict(blockType: BlockMan.BlockType) -> [String: SKAction]{
        
        switch blockType{
            case .Grass:
                return BlockMan.AnimationsDictGrass
            case .Slime:
                return BlockMan.AnimationsDictSlime
            
        }
    }
    
    static let AnimationsDictGrass: [String: SKAction] = [
        "flashing" : SKAction.animate(with: [
            SKTexture(image: #imageLiteral(resourceName: "grassBlock")),
            SKTexture(image: #imageLiteral(resourceName: "grassBlock_hit"))
            ], timePerFrame: 0.10),
        
        "normal" : SKAction.setTexture(SKTexture(image: #imageLiteral(resourceName: "grassBlock")))
    ]
    
    static let AnimationsDictSlime: [String: SKAction] = [
    
        "flashing" : SKAction.animate(with: [
            SKTexture(image: #imageLiteral(resourceName: "slimeBlock")),
            SKTexture(image: #imageLiteral(resourceName: "slimeBlock_hit"))
            ], timePerFrame: 0.10),
        
        "normal" : SKAction.setTexture(SKTexture(image: #imageLiteral(resourceName: "slimeBlock")))
    ]

}
