//
//  Worm.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/8/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//


import Foundation
import SpriteKit
import GameplayKit

class Worm: GKEntity{
    
    enum WormColor{
        case Green, Pink
    }
    
    var horizontalVelocity: CGFloat?
    
    convenience init(wormColor: WormColor, position: CGPoint, nodeName: String, horizontalVelocity: CGFloat?, scalingFactor: CGFloat?) {
        
        self.init()
        
        self.horizontalVelocity = horizontalVelocity ?? 80
        
        
        
        guard let wormTexture = Worm.GetWormTexture(wormColor: wormColor) else {
            fatalError("Error: failed to load worm texture while performing initialization of worm")
        }
        
        
        let node = SKSpriteNode(texture: wormTexture)
        node.position = position
        node.name = nodeName
        
        let renderComponent = RenderComponent(spriteNode: node)
        addComponent(renderComponent)
        
        
        let physicsBody = SKPhysicsBody(texture: wormTexture, size: wormTexture.size())
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
        
        let wormAnimationsDict = wormColor == .Green ? Worm.AnimationsDictGreen : Worm.AnimationsDictPink
        
        let animationComponent = BasicAnimationComponent(animationsDict: wormAnimationsDict)
        
        addComponent(animationComponent)
        animationComponent.runAnimation(withAnimationNameOf: "crawlLeft", andWithAnimationKeyOf: "crawlAnimation", repeatForever: true)
        
        let intelligenceComponent = IntelligenceComponent(states: [
            WormNormalState(worm: self)
            ])
        addComponent(intelligenceComponent)
        intelligenceComponent.stateMachine?.enter(WormNormalState.self)
        
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

extension Worm{
    
    static let AnimationsDictPink: [String: SKAction] = [
        
        "crawlLeft" : SKAction.animate(with: [
            SKTexture(image: #imageLiteral(resourceName: "wormPink")),
            SKTexture(image: #imageLiteral(resourceName: "wormPink_move"))
            ], timePerFrame: 0.20),
        
        "crawlRight" : SKAction.animate(with: [
            SKTexture(image: #imageLiteral(resourceName: "wormPinkRight")),
            SKTexture(image: #imageLiteral(resourceName: "wormPink_moveRight"))
            ], timePerFrame: 0.20),
        
        
        ]
    
    static let AnimationsDictGreen: [String: SKAction] = [
        
        "crawlLeft" : SKAction.animate(with: [
            SKTexture(image: #imageLiteral(resourceName: "wormGreen")),
            SKTexture(image: #imageLiteral(resourceName: "wormGreen_move"))
            ], timePerFrame: 0.20),
        
        "crawlRight" : SKAction.animate(with: [
            SKTexture(image: #imageLiteral(resourceName: "wormGreenRight")),
            SKTexture(image: #imageLiteral(resourceName: "wormGreen_moveRight"))
            ], timePerFrame: 0.20),
        ]
    
    
}
