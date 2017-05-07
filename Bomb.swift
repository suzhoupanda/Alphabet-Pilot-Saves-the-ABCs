//
//  Bomb.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/7/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Bomb: GKEntity{
    
    /** Initializer for an enemy that uses a target node component to detect player proximity; doesn't rely on pathfinding algorithms to move around obstalces, and doesn't rely on the agent/goal simulation from GameplayKit **/
    
    convenience init(position: CGPoint, nodeName: String, scalingFactor: CGFloat?) {
        self.init()
        
        
        
        
        let bombTexture = SKTexture(image: #imageLiteral(resourceName: "bomb"))
        
        
        let node = SKSpriteNode(texture: bombTexture)
        node.position = position
        node.name = nodeName
        
        let renderComponent = RenderComponent(spriteNode: node)
        addComponent(renderComponent)
      
        
        
        let physicsBody = SKPhysicsBody(texture: bombTexture, size: bombTexture.size())
        physicsBody.affectedByGravity = false
        physicsBody.allowsRotation = true
        physicsBody.isDynamic = true
        
        
        let physicsComponent = PhysicsComponent(physicsBody: physicsBody, collisionConfiguration: CollisionConfiguration.Enemy)
        
        addComponent(physicsComponent)
  
        
        //Animations Component is initialized with an animations dictionary, which is stored on the EvilSun class as a static type property
        
        let animationComponent = BasicAnimationComponent(animationsDict: Bomb.AnimationsDict)
        addComponent(animationComponent)
        
        let contactHandlerComponent = ContactHandlerComponent(categoryBeginContactHandler: nil, nodeBeginContactHandler: {
        
            otherNodeName in
            
            if(otherNodeName == "player"){
                
                guard let explosionAnimation = Bomb.AnimationsDict["explode"] else {
                    print("Error: failed to load explosion animation")
                    return
                }
                
                renderComponent.node.run(explosionAnimation, completion: {
                    renderComponent.node.removeFromParent()
                })
            }
            
        }, categoryEndContactHandler: nil, nodeEndContactHandler: nil)
        
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
