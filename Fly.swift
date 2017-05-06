//
//  Fly.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/6/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//



import Foundation
import GameplayKit
import SpriteKit


class Fly: Enemy{
    
    
    /** Initializer for an enemy that uses a target node component to detect player proximity; doesn't rely on pathfinding algorithms to move around obstalces, and doesn't rely on the agent/goal simulation from GameplayKit **/
    
    convenience init(position: CGPoint, nodeName: String, scalingFactor: CGFloat?) {
        self.init()
        
        
        
        
        let flyTexture = SKTexture(image: #imageLiteral(resourceName: "fly"))
        //The selected alien texture is used to initialize the sprite node for the render component as well as the physics body for the physics body component; position arguments is used to initialize the graph node component as well as to set the initial position of the render component
        
        let node = SKSpriteNode(texture: flyTexture)
        node.position = position
        node.name = nodeName
        
        let renderComponent = RenderComponent(spriteNode: node)
        addComponent(renderComponent)
        
        let graphNodeComponent = GraphNodeComponent(cgPosition: position)
        addComponent(graphNodeComponent)
        
        
        
        let physicsBody = SKPhysicsBody(texture: flyTexture, size: flyTexture.size())
        physicsBody.affectedByGravity = false
        physicsBody.allowsRotation = false
        
        physicsBody.categoryBitMask = CollisionConfiguration.Enemy.categoryMask
        physicsBody.collisionBitMask = 4294967295
        physicsBody.contactTestBitMask = 0
        
        let physicsComponent = PhysicsComponent(physicsBody: physicsBody, collisionConfiguration: CollisionConfiguration.Enemy)
        
        addComponent(physicsComponent)
        
        let randomImpulseComponent = RandomImpulseComponent(impulseInterval: 7.00)
        addComponent(randomImpulseComponent)
        
        let orientationComponent = OrientationComponent(currentOrientation: .Left)
        addComponent(orientationComponent)
        orientationComponent.currentOrientation = .Left
        
        //Animations Component is initialized with an animations dictionary, which is stored on the EvilSun class as a static type property
        
        let animationComponent = BasicAnimationComponent(animationsDict: Fly.AnimationsDict)
        addComponent(animationComponent)
        animationComponent.runAnimation(withAnimationNameOf: "flappingLeft", andWithAnimationKeyOf: "flappingAnimation", repeatForever: true)
        
        let intelligenceComponent = IntelligenceComponent(states: [
            NormalFlyingState(enemyEntity: self)
            ])
        addComponent(intelligenceComponent)
        intelligenceComponent.stateMachine?.enter(NormalFlyingState.self)
        
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
