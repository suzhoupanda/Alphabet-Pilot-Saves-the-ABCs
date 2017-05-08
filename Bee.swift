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
        
        let secondPos = CGPoint(x: position.x + 50, y: position.y)
        let thirdPos = CGPoint(x: position.x - 50, y: position.y)
        
        let setOrientationLeftAction = SKAction.run {
            orientationComponent.currentOrientation = .Left
        }
        
        let setOrientationRightAction = SKAction.run {
            orientationComponent.currentOrientation = .Right
        }
        
        let moveRightAction = SKAction.group([
            setOrientationRightAction,
            SKAction.move(to: secondPos, duration: 1.0)
            ])
        
        let moveLeftAction = SKAction.group([
            setOrientationLeftAction,
            SKAction.move(to: thirdPos, duration: 1.0)
            ])
        
        let returnBackAction = SKAction.group([
            setOrientationRightAction,
            SKAction.move(to: position, duration: 1.0)
            ])
        
        let moveAnimation = SKAction.sequence([
            moveRightAction,
            moveLeftAction,
            returnBackAction
            ])
        
        let cgRect = CGRect(x: 0.00, y: 0.00, width: 50.00, height: 50.00)
        let path = CGPath(ellipseIn: cgRect, transform: nil)
        let pathAnimation = SKAction.follow(path, asOffset: true, orientToPath: false, duration: 2.00)
        
        //Initialize the animation component by combining the pre-configured animations dict with a new dictionary whose actions are dynamically determined based on starting position
        
        let combinedDict = [["moveAnimation": moveAnimation, "pathAnimation":pathAnimation], Bee.AnimationsDict]
        
        var animationsDict = [String: SKAction]()
        
        for dict in combinedDict{
            for (key,value) in dict{
                animationsDict[key] = value
            }
        }

        let animationComponent = BasicAnimationComponent(animationsDict: animationsDict)
        addComponent(animationComponent)
        animationComponent.runAnimation(withAnimationNameOf: "moveAnimation", andWithAnimationKeyOf: "moveAnimation", repeatForever: true)
        
        //The target node argument is used to initialize the target detection component; typically, the player node is passed in as an argument for the target detection component to provide a target for pathfinding, smart enemies
        
        let targetDetectonComponent = TargetDetectionComponent(targetNode: targetNode, proximityDistance: minimumProximityDistance)
        addComponent(targetDetectonComponent)
        
        
        let intelligenceComponent = IntelligenceComponent(states: [
            BeeActiveState(bee: self)
            ])
        addComponent(intelligenceComponent)
        intelligenceComponent.stateMachine?.enter(BeeActiveState.self)
      
        //Contact handler component: an attacking enemy enters the inactive state upon contact with the player; ensure that a reference to the entity-level state machine is captured in the contact handler expression
        
        let contactHandlerComponent = ContactHandlerComponent(categoryBeginContactHandler: {
            
            otherBodyCategoryBitmask in
            
            switch otherBodyCategoryBitmask{
            case CollisionConfiguration.Player.categoryMask:
                
                let currentOrientation = orientationComponent.currentOrientation
                
                let deadAnimationName = Bee.getDeadAnimation(forOrientation: currentOrientation)

                guard let deadAnimation = Bee.AnimationsDict[deadAnimationName] else {
                    print("Error: failed to load the dead animation from animations dict from contact handler scope")
                    return
                }
                
                let disableGravityAction = SKAction.run {
                    physicsBody.affectedByGravity = true
                }
                
                let waitAction = SKAction.fadeOut(withDuration: 4.00)
                
                let dieAnimation = SKAction.group([
                    deadAnimation, disableGravityAction, waitAction
                    ])
                
                if let animationNode = animationComponent.animationNode{
                    animationNode.removeAllActions()
                    animationNode.run(dieAnimation, completion: {
                        renderComponent.node.removeFromParent()
                    })
                }
               
                
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

