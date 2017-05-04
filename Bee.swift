//
//  Bee.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/4/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit


class Bee: Enemy{
    
 
    /** Initializer for an enemy that uses a target node component to detect player proximity; doesn't rely on pathfinding algorithms to move around obstalces, and doesn't rely on the agent/goal simulation from GameplayKit **/
    
    convenience init(position: CGPoint, nodeName: String, targetNode: SKSpriteNode, minimumProximityDistance: Double, scalingFactor: CGFloat?) {
        self.init()
        
      
       
        
        let beeTexture = SKTexture(image: #imageLiteral(resourceName: "bee"))
        //The selected alien texture is used to initialize the sprite node for the render component as well as the physics body for the physics body component; position arguments is used to initialize the graph node component as well as to set the initial position of the render component
        
        let node = SKSpriteNode(texture: beeTexture)
        node.position = position
        node.name = nodeName
        
        let renderComponent = RenderComponent(spriteNode: node)
        addComponent(renderComponent)
        
        let graphNodeComponent = GraphNodeComponent(cgPosition: position)
        addComponent(graphNodeComponent)
        
        
        
        let physicsBody = SKPhysicsBody(texture: beeTexture, size: beeTexture.size())
        physicsBody.affectedByGravity = false
        physicsBody.allowsRotation = false
        
        let physicsComponent = PhysicsComponent(physicsBody: physicsBody, collisionConfiguration: CollisionConfiguration.Enemy)
        
        addComponent(physicsComponent)
        
        
        let orientationComponent = OrientationComponent(currentOrientation: .Left)
        addComponent(orientationComponent)
        
        //Animations Component is initialized with an animations dictionary, which is stored on the Alien class as a static type property
        
        let animationComponent = BasicAnimationComponent(animationsDict: Bee.AnimationsDict)
        addComponent(animationComponent)
        
        //The target node argument is used to initialize the target detection component; typically, the player node is passed in as an argument for the target detection component to provide a target for pathfinding, smart enemies
        
        let targetDetectonComponent = TargetDetectionComponent(targetNode: targetNode, proximityDistance: minimumProximityDistance)
        addComponent(targetDetectonComponent)
        
        
        
        //The intelligence component manages the different states of the alien, and manages the changes in render, physics, and animations properties characteristic of different states
        
        let intelligenceComponent = IntelligenceComponent(states: [
                BeeInactiveState(enemyEntity: self),
                BeeAttackState(enemyEntity: self),
                BeeActiveState(enemyEntity: self)
            ])
        
        addComponent(intelligenceComponent)
        intelligenceComponent.stateMachine?.enter(BeeInactiveState.self)
        
        //Contact handler component: an attacking enemy enters the inactive state upon contact with the player; ensure that a reference to the entity-level state machine is captured in the contact handler expression
        
        let contactHandlerComponent = ContactHandlerComponent(categoryBeginContactHandler: {
            
            otherBodyCategoryBitmask in
            
            switch otherBodyCategoryBitmask{
            case CollisionConfiguration.Player.categoryMask:
                intelligenceComponent.stateMachine?.enter(BeeInactiveState.self)
                break
            default:
                break
            }
            
        }, nodeBeginContactHandler: nil, categoryEndContactHandler: nil, nodeEndContactHandler: nil)
        addComponent(contactHandlerComponent)
        
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

