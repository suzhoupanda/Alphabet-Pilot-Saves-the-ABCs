//
//  BlockMan.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/8/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//


import Foundation
import SpriteKit
import GameplayKit


class BlockMan: GKEntity{
    
   
    enum BlockType{
        case Grass,Slime
    }
    
    
    convenience init(blockType: BlockType, position: CGPoint, nodeName: String, scalingFactor: CGFloat?) {
        
        self.init()
        
        guard let blockmanTexture = BlockMan.GetBlockmanTexture(blockType: blockType) else {
            
            fatalError("Error: failed to load the blockman texture while initializing the blockman")
        }
        
        
        let node = SKSpriteNode(texture: blockmanTexture)
        node.position = position
        node.name = nodeName
        
        let renderComponent = RenderComponent(spriteNode: node)
        addComponent(renderComponent)
        
        let physicsBody = SKPhysicsBody(texture: blockmanTexture, size: blockmanTexture.size())
        
        let physicsComponent = PhysicsComponent(physicsBody: physicsBody, collisionConfiguration: CollisionConfiguration.Enemy)
        addComponent(physicsComponent)
        
        physicsBody.affectedByGravity = false
        physicsBody.allowsRotation = false
        physicsBody.isDynamic = false
        
        let blockmanVortexRegion = SKRegion(radius: 100.0)
        
        let fieldEmittingComponent = FieldEmittingComponent(fieldInterval: 3.00, fieldType: .VortexField, strength: 10.0, falloff: 0.0, smoothness: 1.0, minimumRadius: 0.0, isExclusive: false, region: blockmanVortexRegion, linearGravityFieldVector: nil)
        
        addComponent(fieldEmittingComponent)
        
        
        let animationsDict = BlockMan.GetBlockmanAnimationsDict(blockType: blockType)
        let animationComponent = BasicAnimationComponent(animationsDict: animationsDict)
        addComponent(animationComponent)
        
        
        let intelligenceComponent = IntelligenceComponent(states: [
            BlockmanInactiveState(blockman: self),
            BlockmanEmittingState(blockman: self)
            
            ])
        addComponent(intelligenceComponent)
        intelligenceComponent.stateMachine?.enter(BlockmanInactiveState.self)
        
        
    }
    
   
    
}
