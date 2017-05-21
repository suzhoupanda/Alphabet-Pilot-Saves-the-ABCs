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
    
    //MARK: ************  Nested-type for Alien Color
    
    enum AlienColor{
        case Yellow, Blue, Pink, Beige
    }
    
    //MARK: ************** Private instance variables
    
    var alienColor: AlienColor!
    
    /** Initializer for an enemy that uses a target node component to detect player proximity; doesn't rely on pathfinding algorithms to move around obstalces, and doesn't rely on the agent/goal simulation from GameplayKit **/
    
    convenience init(alienColor: AlienColor, position: CGPoint, nodeName: String, targetNode: SKSpriteNode, minimumProximityDistance: Double, scalingFactor: CGFloat?) {
        self.init()
        
        //Get the appropriate texture for a given alien color in order to initialize the sprite node for the render component
        
        var texture: SKTexture?
        
        switch(alienColor){
        case .Pink:
            texture = TextureAtlasManager.sharedManager.alienTextureAtlas?.textureNamed("shipPink_manned")
            break
        case .Blue:
             texture = TextureAtlasManager.sharedManager.alienTextureAtlas?.textureNamed("shipBlue_manned")
            break
        case .Beige:
             texture = TextureAtlasManager.sharedManager.alienTextureAtlas?.textureNamed("shipBeige_manned")
            break
        case .Yellow:
             texture = TextureAtlasManager.sharedManager.alienTextureAtlas?.textureNamed("shipYellow_manned")
            break
        }
        
        //Store a reference to the alien color on the entity class in order to allow for animations component to select appropriate animations from the animations dictionary
        
        self.alienColor = alienColor
        
        guard let alienTexture = texture else {
            fatalError("Error: the texture for the alien failed to load")
        }
        
        //The selected alien texture is used to initialize the sprite node for the render component as well as the physics body for the physics body component; position arguments is used to initialize the graph node component as well as to set the initial position of the render component 
        
        let node = SKSpriteNode(texture: alienTexture)
        node.position = position
        node.name = nodeName
        
        let renderComponent = RenderComponent(spriteNode: node)
        addComponent(renderComponent)
        
        let graphNodeComponent = GraphNodeComponent(cgPosition: position)
        addComponent(graphNodeComponent)
        
        
       
        let physicsBody = SKPhysicsBody(texture: alienTexture, size: alienTexture.size())
        physicsBody.affectedByGravity = false
        physicsBody.allowsRotation = false
        
        let physicsComponent = PhysicsComponent(physicsBody: physicsBody, collisionConfiguration: CollisionConfiguration.Enemy)
        
        addComponent(physicsComponent)
        
        
      
        
        //Animations Component is initialized with an animations dictionary, which is stored on the Alien class as a static type property
        
        let animationComponent = BasicAnimationComponent(animationsDict: Alien.AnimationsDict)
        addComponent(animationComponent)
        
        //The target node argument is used to initialize the target detection component; typically, the player node is passed in as an argument for the target detection component to provide a target for pathfinding, smart enemies
        
        let targetDetectonComponent = TargetDetectionComponent(targetNode: targetNode, proximityDistance: minimumProximityDistance)
        addComponent(targetDetectonComponent)
        
        
        
        //The intelligence component manages the different states of the alien, and manages the changes in render, physics, and animations properties characteristic of different states
        
        let intelligenceComponent = IntelligenceComponent(states: [
            AlienInactiveState(alienEntity: self),
            AlienAttackState(alienEntity: self),
            AlienActiveState(alienEntity: self)
            ])
        
        addComponent(intelligenceComponent)
        intelligenceComponent.stateMachine?.enter(AlienInactiveState.self)
        
        //Contact handler component: an attacking enemy enters the inactive state upon contact with the player; ensure that a reference to the entity-level state machine is captured in the contact handler expression
        
        let contactHandlerComponent = ContactHandlerComponent(categoryBeginContactHandler: {
            
            otherBodyCategoryBitmask in
            
            switch otherBodyCategoryBitmask{
            case CollisionConfiguration.Player.categoryMask:
                intelligenceComponent.stateMachine?.enter(AlienInactiveState.self)
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

