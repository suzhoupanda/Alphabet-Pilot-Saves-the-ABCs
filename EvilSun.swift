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
        
        let physicsComponent = PhysicsComponent(physicsBody: physicsBody, collisionConfiguration: CollisionConfiguration.Enemy)
        
        addComponent(physicsComponent)
        
        
    
        
        //Animations Component is initialized with an animations dictionary, which is stored on the EvilSun class as a static type property
        
        let animationsDict = getAnimationsDictionary(position: position)
        
        
        let animationComponent = BasicAnimationComponent(animationsDict: animationsDict)
        addComponent(animationComponent)
        animationComponent.runAnimation(withAnimationNameOf: "pathAnimation", andWithAnimationKeyOf: "pathAnimation", repeatForever: true)
        
        //Add an intelligence movement to manage the different animation states of the Evil Sun 
        
        let intelligenceComponent = IntelligenceComponent(states: [
                HorizontalMovementState(evilSunEntity: self),
                VerticalMovementState(evilSunEntity: self),
                PathMovementState(evilSunEntity: self)
            ])
        addComponent(intelligenceComponent)
        intelligenceComponent.stateMachine?.enter(HorizontalMovementState.self)
        
    
        
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
        
        //Configure Back-and-Forth Move Animation (position offsets and movement time are randomized)
        
        let offsetRight = CGFloat(arc4random_uniform(UInt32(90))) + 10.00
        let offsetLeft =  CGFloat(arc4random_uniform(UInt32(90))) + 10.00
        
        let randomMoveTime1 = Double(arc4random_uniform(UInt32(5))) + 2.00
        let randomMoveTime2 = Double(arc4random_uniform(UInt32(5))) + 2.00
        let randomMoveTime3 = Double(arc4random_uniform(UInt32(5))) + 2.00
        
        let secondPos = CGPoint(x: position.x + offsetRight, y: position.y)
        let thirdPos = CGPoint(x: position.x - offsetLeft, y: position.y)
        
        let horizontalMoveAnimation = SKAction.sequence([
            SKAction.move(to: secondPos, duration: randomMoveTime1),
            SKAction.move(to: thirdPos, duration: randomMoveTime2),
            SKAction.move(to: position, duration: randomMoveTime3)
            ])
        
        //Configure Up-and-Down Move Animation (position offsets and movement time are randomzied)
        
        let offsetUp = CGFloat(arc4random_uniform(UInt32(90))) + 10.00
        let offsetDown = CGFloat(arc4random_uniform(UInt32(90))) + 10.00
        
        let secondPosVert = CGPoint(x: position.x, y: position.y + offsetUp)
        let thirdPosVert = CGPoint(x: position.x, y: position.y - offsetDown)
        
      
        let verticalMoveAnimation = SKAction.sequence([
            SKAction.move(to: secondPosVert, duration: 2.00),
            SKAction.move(to: thirdPosVert, duration: 2.00),
            SKAction.move(to: position, duration: 2.00)
            ])
        
        //Configure elliptical path animation
        
        let randomWidth = Double(arc4random_uniform(UInt32(40))) + 10.00
        let randomHeight =  Double(arc4random_uniform(UInt32(40))) + 10.00
        let randomPathTime =  Double(arc4random_uniform(UInt32(5))) + 2

        let cgRect = CGRect(x: 0.00, y: 0.00, width: randomWidth, height: randomHeight)
        
        let path = CGPath(ellipseIn: cgRect, transform: nil)
        let pathAnimation = SKAction.follow(path, asOffset: false, orientToPath: false, duration: randomPathTime)
        
        //Initialize the animation component by combining the pre-configured animations dict with a new dictionary whose actions are dynamically determined based on starting position
        
        let combinedDict = [
            ["horizontalMoveAnimation": horizontalMoveAnimation,
             "verticalMoveAnimation": verticalMoveAnimation,
             "pathAnimation":pathAnimation
            ],
            
            EvilSun.AnimationsDict]
        
        var animationsDict = [String: SKAction]()
        
        for dict in combinedDict{
            for (key,value) in dict{
                animationsDict[key] = value
            }
        }
        
        return animationsDict
    }
    
    
}
