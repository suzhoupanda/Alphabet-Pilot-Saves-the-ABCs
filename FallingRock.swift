//
//  FallingRock.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/7/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class FallingRock: SKSpriteNode{
    
    enum RockType{
        case Stone, Dirt
    }
    
    enum RockSize{
        case Large, Small
    }
    
    typealias RockConfiguration = (rockType: RockType, rockSize: RockSize)
    
    convenience init?(rockType: RockType, rockSize: RockSize, scalingFactor: CGFloat?) {
        
        guard let rockTexture = FallingRock.GetRockTexture(forRockConfiguration: (rockType, rockSize)) else {
            print("Error: failed to load the laser texture")
            return nil
        }
        
        self.init(texture: rockTexture, color: .clear, size: rockTexture.size())
        
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        physicsBody = SKPhysicsBody(rectangleOf: rockTexture.size())
        
        physicsBody?.affectedByGravity = true
        physicsBody?.allowsRotation = true
        physicsBody?.linearDamping = 0.00
        
        physicsBody?.categoryBitMask = CollisionConfiguration.Enemy.categoryMask
        physicsBody?.collisionBitMask = 0
        physicsBody?.contactTestBitMask = CollisionConfiguration.Player.categoryMask
        
        
        if let scalingFactor = scalingFactor{
            xScale *= scalingFactor
            yScale *= scalingFactor
        }
        
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension FallingRock{
    
    static func GetRockTexture(forRockConfiguration rockConfiguration: RockConfiguration) -> SKTexture?{
        
        
        var rockTexture: SKTexture?
        
        switch rockConfiguration{
            case (.Stone, .Large):
                rockTexture = TextureAtlasManager.sharedManager.rocksTextureAtlas?.textureNamed("stoneCaveRockLarge")
                break
            case (.Stone, .Small):
                rockTexture = TextureAtlasManager.sharedManager.rocksTextureAtlas?.textureNamed("stoneCaveRockSmall")
                break
            case (.Dirt, .Large):
                rockTexture = TextureAtlasManager.sharedManager.rocksTextureAtlas?.textureNamed("dirtCaveRockLarge")
                break
            case (.Dirt, .Small):
                rockTexture = TextureAtlasManager.sharedManager.rocksTextureAtlas?.textureNamed("dirtCaveRockSmall")
                break
                }
        
            return rockTexture
    }
    
}
