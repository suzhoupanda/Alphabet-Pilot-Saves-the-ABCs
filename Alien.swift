//
//  Alien.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/2/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//


import Foundation
import GameplayKit
import SpriteKit

class Alien: Enemy{
    
    enum AlienColor{
        case Yellow, Blue, Pink, Beige
    }
    
    
    /** Initializer for an enemy that uses a target node component to detect player proximity; doesn't rely on pathfinding algorithms to move around obstalces, and doesn't rely on the agent/goal simulation from GameplayKit **/
    
    convenience init(alienColor: AlienColor, position: CGPoint, nodeName: String, targetNode: SKSpriteNode, minimumProximityDistance: Double, scalingFactor: CGFloat?) {
        self.init()
        
        var texture: SKTexture?
        
        switch(alienColor){
        case .Pink:
            texture = SKTexture(image: #imageLiteral(resourceName: "shipPink_manned"))
            break
        case .Blue:
            texture = SKTexture(image: #imageLiteral(resourceName: "shipBlue_manned"))
            break
        case .Beige:
            texture = SKTexture(image: #imageLiteral(resourceName: "shipBeige_manned"))
            break
        case .Yellow:
            texture = SKTexture(image: #imageLiteral(resourceName: "shipYellow_manned"))
            break
        }
        
        guard let alienTexture = texture else {
            fatalError("Error: the texture for the alien failed to load")
        }
        
        let node = SKSpriteNode(texture: alienTexture)
        node.position = position
        
        let renderComponent = RenderComponent(spriteNode: node)
        addComponent(renderComponent)
        
        let graphNodeComponent = GraphNodeComponent(cgPosition: node.position)
        addComponent(graphNodeComponent)
        
        
       
        let physicsBody = SKPhysicsBody(texture: alienTexture, size: alienTexture.size())
        physicsBody.affectedByGravity = false
        physicsBody.allowsRotation = false
        
        let physicsComponent = PhysicsComponent(physicsBody: physicsBody, collisionConfiguration: CollisionConfiguration.Enemy)
        
        addComponent(physicsComponent)
        
        let animationComponent = BasicAnimationComponent(animationsDict: Alien.AnimationsDict)
        addComponent(animationComponent)
        
        let targetDetectonComponent = TargetDetectionComponent(targetNode: targetNode, proximityDistance: minimumProximityDistance)
        addComponent(targetDetectonComponent)
        
        let intelligenceComponent = IntelligenceComponent(states: [
            AlienInactiveState(alienEntity: self),
            AlienAttackState(alienEntity: self),
            AlienActiveState(alienEntity: self)
            ])
        
        addComponent(intelligenceComponent)
        intelligenceComponent.stateMachine?.enter(AlienInactiveState.self)
        
        if let scalingFactor = scalingFactor{
            node.xScale *= scalingFactor
            node.yScale *= scalingFactor
        }
    }
    
    
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
}

