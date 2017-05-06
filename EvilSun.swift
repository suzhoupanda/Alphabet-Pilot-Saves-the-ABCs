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


class EvilSun: Enemy{
    
    
    /** Initializer for an enemy that uses a target node component to detect player proximity; doesn't rely on pathfinding algorithms to move around obstalces, and doesn't rely on the agent/goal simulation from GameplayKit **/
    
    convenience init(position: CGPoint, nodeName: String, scalingFactor: CGFloat?) {
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
        physicsBody.isDynamic = false
        
        let physicsComponent = PhysicsComponent(physicsBody: physicsBody, collisionConfiguration: CollisionConfiguration.Enemy)
        
        addComponent(physicsComponent)
        
        
    
        
        //Animations Component is initialized with an animations dictionary, which is stored on the EvilSun class as a static type property
        
        let animationsDict = getAnimationsDictionary(position: position)
        
        
        let animationComponent = BasicAnimationComponent(animationsDict: animationsDict)
        addComponent(animationComponent)
        animationComponent.runAnimation(withAnimationNameOf: "turnAnimation", andWithAnimationKeyOf: "turnAnimation", repeatForever: true)
        
        //Add an intelligence movement to manage the different animation states of the Evil Sun 
        
        let intelligenceComponent = IntelligenceComponent(states: [
                SunHorizontalMoveState(enemyEntity: self),
                SunVerticalMoveState(enemyEntity: self),
                SunPathMoveState(enemyEntity: self),
            ])
        
        addComponent(intelligenceComponent)
        intelligenceComponent.stateMachine?.enter(SunHorizontalMoveState.self)
        
    
        
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
    
    
    
    func getAnimationsDictionary(position: CGPoint) -> [String: SKAction]{
        
        
        
        let offsetRight = CGFloat(arc4random_uniform(UInt32(20))) + 20.00
        let offsetLeft = CGFloat(arc4random_uniform(UInt32(20))) + 20.00
        let randomDuration1 = 0.50
        
        let movePoint1 = CGPoint(x: position.x + offsetRight, y: position.y)
        let movePoint2 = CGPoint(x: position.x + offsetLeft, y: position.y)
        
        let moveAction1 = SKAction.move(to: movePoint1, duration: randomDuration1)
        let moveAction2 = SKAction.move(to: movePoint2, duration: randomDuration1)
        let moveAction3 = SKAction.move(to: position, duration: randomDuration1)
        
        let horizontalMoveAnimation = SKAction.sequence([
            moveAction1,
            moveAction2,
            moveAction3
            ])
        
        
        let offsetUp = CGFloat(arc4random_uniform(UInt32(20))) + 20.00
        let offsetDown = CGFloat(arc4random_uniform(UInt32(20))) + 20.00
        let randomDuration2 = 0.50
        
        let vertMovePoint1 = CGPoint(x: position.x, y: position.y + offsetUp)
        let vertMovePoint2 = CGPoint(x: position.x, y: position.y + offsetDown)
        
        let vertMoveAction1 = SKAction.move(to: vertMovePoint1, duration: randomDuration2)
        let vertMoveAction2 = SKAction.move(to: vertMovePoint2, duration: randomDuration2)
        let vertMoveAction3 = SKAction.move(to: position, duration: randomDuration2)
        
        let verticalMoveAnimation = SKAction.sequence([
            vertMoveAction1,
            vertMoveAction2,
            vertMoveAction3
            ])
        
        
        let randomWidth = Double(arc4random_uniform(UInt32(40))) + 30.00
        let randomHeight = Double(arc4random_uniform(UInt32(40))) + 30.00
        let randomDuration = 0.50
        
        let cgRect = CGRect(x: Double(position.x), y: Double(position.y), width: randomWidth, height: randomHeight)
        let path = CGPath(ellipseIn: cgRect, transform: nil)
        let pathAnimation = SKAction.follow(path, asOffset: false, orientToPath: false, duration: randomDuration)
        
        let combinedDict = [
            
            ["pathMoveAnimation" : pathAnimation,
             "horizontalMoveAnimation" : horizontalMoveAnimation,
             "verticalMoveAnimation" : verticalMoveAnimation]
            ,
            
            EvilSun.AnimationsDict
        ]

        
        var animationsDict = [String: SKAction]()
        
        for dict in combinedDict{
            for (key,value) in dict{
                animationsDict[key] = value
            }
        }
        
        return animationsDict
    }
    
    
}
