//
//  Animal.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/15/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class Animal: Enemy{
    
    //MARK: ************  Nested-type for Alien Color
    
    enum AnimalType{
        case Giraffe, Panda, Monkey, Rabbit, Elephant, Pig, Snake, Parrot, Hippo, Penguin
    }
    
    //MARK: ************** Private instance variables
    
    var animalType: AnimalType!
    
    /** Initializer for an enemy that uses a target node component to detect player proximity; doesn't rely on pathfinding algorithms to move around obstalces, and doesn't rely on the agent/goal simulation from GameplayKit **/
    
    convenience init(animalType: AnimalType, position: CGPoint, nodeName: String, scalingFactor: CGFloat?) {
        self.init()
        
        //Get the appropriate texture for a given alien color in order to initialize the sprite node for the render component
        
        var texture: SKTexture?
        
        texture = Animal.getTexture(forAnimalType: animalType)
        
        //Store a reference to the alien color on the entity class in order to allow for animations component to select appropriate animations from the animations dictionary
        
        self.animalType = animalType
        
        guard let animalTexture = texture else {
            fatalError("Error: the texture for the animal failed to load")
        }
        
        //The selected alien texture is used to initialize the sprite node for the render component as well as the physics body for the physics body component; position arguments is used to initialize the graph node component as well as to set the initial position of the render component
        
        let node = SKSpriteNode(texture: animalTexture)
        node.position = position
        node.name = nodeName
        
        let renderComponent = RenderComponent(spriteNode: node)
        addComponent(renderComponent)
        
        
        let physicsBody = SKPhysicsBody(texture: animalTexture, size: animalTexture.size())
        physicsBody.affectedByGravity = false
        physicsBody.allowsRotation = true
        
        let physicsComponent = PhysicsComponent(physicsBody: physicsBody, collisionConfiguration: CollisionConfiguration.Enemy)
        
        addComponent(physicsComponent)
        
        
        
        
        //Animations Component is initialized with an animations dictionary, which is stored on the Alien class as a static type property
        
        let animationComponent = BasicAnimationComponent(animationsDict: Animal.AnimationsDict)
        addComponent(animationComponent)
        
        
        
        let randomImpulseComponent = RandomImpulseComponent(impulseInterval: 2.00, meanImpulseValue: 500.00, deviation: 20.00)
        addComponent(randomImpulseComponent)
        
      
        //Contact handler component: an attacking enemy enters the inactive state upon contact with the player; ensure that a reference to the entity-level state machine is captured in the contact handler expression
        
        let contactHandlerComponent = ContactHandlerComponent(categoryBeginContactHandler: {
            
            otherBodyCategoryBitmask in
            
            switch otherBodyCategoryBitmask{
            case CollisionConfiguration.Player.categoryMask:
                //TODO: activate animation upon collision with player
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
