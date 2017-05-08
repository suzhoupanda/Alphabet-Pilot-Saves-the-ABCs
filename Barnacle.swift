//
//  Barnacle.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/7/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit


class Barnacle: GKEntity{
    
    enum BarnacleOrientation{
        case Up, Down
    }
    
    var previousEmittingState: Bool = false
    
    convenience init(barnacleOrientation: BarnacleOrientation, position: CGPoint, nodeName: String, scalingFactor: CGFloat?) {
        
        self.init()
    
        guard let barnacleTexture = Barnacle.getBarnacleTexture(orientation: barnacleOrientation) else {
            fatalError("Error: failed to load barnacle texture while performing intialization of barnacle entity")
            
        }
    
    
        let node = SKSpriteNode(texture: barnacleTexture)
        node.position = position
        node.name = nodeName
        
        let renderComponent = RenderComponent(spriteNode: node)
        addComponent(renderComponent)
        
        let physicsBody = SKPhysicsBody(texture: barnacleTexture, size: barnacleTexture.size())
        
        let physicsComponent = PhysicsComponent(physicsBody: physicsBody, collisionConfiguration: CollisionConfiguration.Enemy)
        addComponent(physicsComponent)
        
        physicsBody.affectedByGravity = false
        physicsBody.allowsRotation = false
        physicsBody.isDynamic = false
        
        let barnacleVortexRegion = SKRegion(radius: 100.0)
        
        let fieldEmittingComponent = FieldEmittingComponent(fieldInterval: 3.00, fieldType: .VortexField, strength: 10.0, falloff: 0.0, smoothness: 1.0, minimumRadius: 0.0, isExclusive: false, region: barnacleVortexRegion, linearGravityFieldVector: nil)
        
        addComponent(fieldEmittingComponent)
        
        
        let animationsDict = Barnacle.getBarnacleAnimationsDict(orientation: barnacleOrientation)
        let animationComponent = BasicAnimationComponent(animationsDict: animationsDict)
        addComponent(animationComponent)
        
        
        let intelligenceComponent = IntelligenceComponent(states: [
            BarnacleEmittingState(barnacle: self),
            BarnacleInactiveState(barnacle: self)
            ])
        addComponent(intelligenceComponent)
        intelligenceComponent.stateMachine?.enter(BarnacleInactiveState.self)
        
        
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        /**
        guard let fieldComponent = component(ofType: FieldEmittingComponent.self), let fieldNode = fieldComponent.fieldNode else {
            print("Error: failed to load the field component while performing entity-level update on the barnacle")
            return
        }
        
        guard let animationComponent = component(ofType: BasicAnimationComponent.self) else {
            print("Error: failed to load the animation component while performing entity-level update on the barnacle")
            return
        }
        
        if previousEmittingState == fieldNode.isEnabled{
            
            if let animationNode = animationComponent.animationNode,  animationNode.action(forKey: "mainAnimation") != nil{
               
                 animationNode.removeAction(forKey: "mainAnimation")
            }
            
            let animationName = fieldNode.isEnabled ? "flashing" : "closed"
            
            animationComponent.runAnimation(withAnimationNameOf: animationName, andWithAnimationKeyOf: "mainAnimation", repeatForever: true)
            
            previousEmittingState = fieldNode.isEnabled
        }
        **/
    }
    
}
