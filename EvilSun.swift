//
//  EvilSun.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/4/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit


import Foundation
import GameplayKit
import SpriteKit


class EvilSun: Enemy{
    
    
    /** Initializer for an enemy that uses a target node component to detect player proximity; doesn't rely on pathfinding algorithms to move around obstalces, and doesn't rely on the agent/goal simulation from GameplayKit **/
    
    convenience init(position: CGPoint, nodeName: String, targetNode: SKSpriteNode, minimumProximityDistance: Double, scalingFactor: CGFloat?) {
        self.init()
        
        
        
        
        let sunTexture = SKTexture(image: #imageLiteral(resourceName: "sun1"))
        //The selected alien texture is used to initialize the sprite node for the render component as well as the physics body for the physics body component; position arguments is used to initialize the graph node component as well as to set the initial position of the render component
        
        let node = SKSpriteNode(texture: sunTexture)
        node.position = position
        node.name = nodeName
        
        let renderComponent = RenderComponent(spriteNode: node)
        addComponent(renderComponent)
        
        let graphNodeComponent = GraphNodeComponent(cgPosition: position)
        addComponent(graphNodeComponent)
        
        
        
        let physicsBody = SKPhysicsBody(texture: sunTexture, size: sunTexture.size())
        physicsBody.affectedByGravity = false
        physicsBody.allowsRotation = false
        
        let physicsComponent = PhysicsComponent(physicsBody: physicsBody, collisionConfiguration: CollisionConfiguration.Enemy)
        
        addComponent(physicsComponent)
        
        
        //Animations Component is initialized with an animations dictionary, which is stored on the Alien class as a static type property
        
        let secondPos = CGPoint(x: position.x + 50, y: position.y)
        let thirdPos = CGPoint(x: position.x - 50, y: position.y)
        
        let moveAnimation = SKAction.sequence([
            SKAction.move(to: secondPos, duration: 1.0),
            SKAction.move(to: thirdPos, duration: 1.0),
            SKAction.move(to: position, duration: 1.0)
            ])
        
        let cgRect = CGRect(x: 0.00, y: 0.00, width: 50.00, height: 50.00)
        let path = CGPath(ellipseIn: cgRect, transform: nil)
        let pathAnimation = SKAction.follow(path, asOffset: false, orientToPath: false, duration: 2.00)
        
        //Initialize the animation component by combining the pre-configured animations dict with a new dictionary whose actions are dynamically determined based on starting position
        
        let combinedDict = [["moveAnimation": moveAnimation, "pathAnimation":pathAnimation], EvilSun.AnimationsDict]
        
        var animationsDict = [String: SKAction]()
        
        for dict in combinedDict{
            for (key,value) in dict{
                animationsDict[key] = value
            }
        }
        
        let animationComponent = BasicAnimationComponent(animationsDict: animationsDict)
        addComponent(animationComponent)
        animationComponent.runAnimation(withAnimationNameOf: "pathAnimation", andWithAnimationKeyOf: "pathAnimation", repeatForever: true)
        
        //The target node argument is used to initialize the target detection component; typically, the player node is passed in as an argument for the target detection component to provide a target for pathfinding, smart enemies
        
        let targetDetectonComponent = TargetDetectionComponent(targetNode: targetNode, proximityDistance: minimumProximityDistance)
        addComponent(targetDetectonComponent)
        
        
        
        //Contact handler component: an attacking enemy enters the inactive state upon contact with the player; ensure that a reference to the entity-level state machine is captured in the contact handler expression
        
        let contactHandlerComponent = ContactHandlerComponent(categoryBeginContactHandler: {
            
            otherBodyCategoryBitmask in
            
            switch otherBodyCategoryBitmask{
            case CollisionConfiguration.Player.categoryMask:
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
