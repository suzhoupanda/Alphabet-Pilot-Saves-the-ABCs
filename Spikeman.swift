//
//  Spikeman.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/7/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Spikeman: GKEntity{
    
    var horizontalVelocity: CGFloat?
    
    convenience init(position: CGPoint, nodeName: String, horizontalVelocity: CGFloat?, scalingFactor: CGFloat?) {
        
        self.init()
        
        self.horizontalVelocity = horizontalVelocity ?? 80
        
        
        
        let spikemanTexture = SKTexture(image: #imageLiteral(resourceName: "spikeMan_stand"))
       
        
        let node = SKSpriteNode(texture: spikemanTexture)
        node.position = position
        node.name = nodeName
        
        let renderComponent = RenderComponent(spriteNode: node)
        addComponent(renderComponent)
        
        let graphNodeComponent = GraphNodeComponent(cgPosition: position)
        addComponent(graphNodeComponent)
        
        
        
        let physicsBody = SKPhysicsBody(texture: spikemanTexture, size: spikemanTexture.size())
        physicsBody.affectedByGravity = true
        physicsBody.allowsRotation = false
        physicsBody.isDynamic = true
        
        physicsBody.categoryBitMask = CollisionConfiguration.Enemy.categoryMask
        physicsBody.collisionBitMask = CollisionConfiguration.Player.categoryMask | 256
        physicsBody.contactTestBitMask = 256
        
        physicsBody.linearDamping = 0.00
        physicsBody.friction = 0.00
        
        if let horizontalVelocity = horizontalVelocity{
            physicsBody.velocity.dx = horizontalVelocity
        }
        
        let physicsComponent = PhysicsComponent(physicsBody: physicsBody, collisionConfiguration: CollisionConfiguration.Enemy)
        
        addComponent(physicsComponent)
        
        let contactHandlerComponent = ContactHandlerComponent(categoryBeginContactHandler: {
            
            otherCategoryBitMask in
            
            if otherCategoryBitMask == 256{
                physicsBody.velocity.dx = -physicsBody.velocity.dx
            }
            
        }, nodeBeginContactHandler: nil, categoryEndContactHandler: nil, nodeEndContactHandler: nil)
        addComponent(contactHandlerComponent)
        
        
        let orientationComponent = OrientationComponent(currentOrientation: .Left)
        addComponent(orientationComponent)
        
    
        //Animations Component is initialized with an animations dictionary, which is stored on the EvilSun class as a static type property
        
        let animationComponent = BasicAnimationComponent(animationsDict: Spikeman.AnimationsDict)
        addComponent(animationComponent)
        animationComponent.runAnimation(withAnimationNameOf: "walkLeft", andWithAnimationKeyOf: "walkAnimation", repeatForever: true)
        
        let intelligenceComponent = IntelligenceComponent(states: [
            SpikemanNormalState(spikeManEntity: self),
            SpikemanJumpState(spikeManEntity: self)
            ])
        addComponent(intelligenceComponent)
        intelligenceComponent.stateMachine?.enter(SpikemanNormalState.self)
        
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
