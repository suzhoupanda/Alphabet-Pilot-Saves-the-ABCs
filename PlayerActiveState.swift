//
//  PlayerActiveState.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/2/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit



class PlayerActiveState: GKState{
    
    unowned let playerEntity: Player
    
    var currentVelocityCategory: PlayerVelocityCategory?
     
    var currentHealth: Int?
    
    init(playerEntity: Player){
        self.playerEntity = playerEntity

        self.currentHealth = playerEntity.component(ofType: HealthComponent.self)?.currentHealth ?? 5
       
        super.init()

    }
    
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        
        print("Entering the player active state...")
        
        /**
        guard let playerNode = playerEntity.component(ofType: RenderComponent.self)?.node else {
            print("Error: playyer must have a render component")
            return
            }
        
        guard let playerHealth = playerEntity.component(ofType: HealthComponent.self)?.currentHealth else {
            print("Error: player must have a health component ")
            return
        }
        **/
        
        guard let playerPhysicsComponent = playerEntity.component(ofType: PhysicsComponent.self) else {
            print("Error: player must have a velocity component")
            return
        }
        
        guard let playerAnimation = playerEntity.component(ofType: BasicAnimationComponent.self) else {
                print("Error: player must have a basic animation component")
                return
        }
        
        //Changing emitter node when player enter the active state may not be necessary
        
       /** if currentHealth != playerHealth{
            currentHealth = playerHealth
        
        print("Removing previous emitter node...")
        let emitterNode = playerNode.childNode(withName: "smokeEmitterNode")
        
        /** If an emitter node has already been added, remove it **/
        if emitterNode != nil {
            emitterNode!.removeFromParent()
        }
        
        let playerNodeWidth = playerNode.size.width
        
        switch(playerHealth){
            case 3:
                print("Adding new emitter node...")
                let smokeEmitterNode = SKScene(fileNamed: "Damage1")
                smokeEmitterNode?.name = "smokeEmitterNode"
                smokeEmitterNode?.zPosition = -1
                smokeEmitterNode?.position = CGPoint(x: -(playerNodeWidth*0.20), y: 0.00)
                smokeEmitterNode?.move(toParent: playerNode)
                break
            case 2:
                print("Adding new emitter node...")
                let smokeEmitterNode = SKScene(fileNamed: "Damage2")
                smokeEmitterNode?.name = "smokeEmitterNode"
                smokeEmitterNode?.zPosition = -1
                smokeEmitterNode?.position = CGPoint(x: -(playerNodeWidth*0.20), y: 0.00)
                smokeEmitterNode?.move(toParent: playerNode)
                break
            case 1:
                print("Adding new emitter node...")
                let smokeEmitterNode = SKScene(fileNamed: "Damage3")
                smokeEmitterNode?.name = "smokeEmitterNode"
                smokeEmitterNode?.zPosition = -1
                smokeEmitterNode?.position = CGPoint(x: -(playerNodeWidth*0.20), y: 0.00)
                smokeEmitterNode?.move(toParent: playerNode)
                break
            case 0:
                print("Adding new emitter node...")
                let smokeEmitterNode = SKScene(fileNamed: "Damage3")
                smokeEmitterNode?.name = "smokeEmitterNode"
                smokeEmitterNode?.zPosition = -1
                smokeEmitterNode?.position = CGPoint(x: -(playerNodeWidth*0.20), y: 0.00)
                smokeEmitterNode?.move(toParent: playerNode)
            break

            
            default:
                break
        }
            
        } **/
        
        let playerVelocityX = Int(playerPhysicsComponent.physicsBody.velocity.dx)
        let velocityCategory = PlayerVelocityCategory(playerVelocityX: playerVelocityX)
        currentVelocityCategory = velocityCategory
        
            print("Removing current velocity animation...")
            playerAnimation.animationNode?.removeAction(forKey: "velocityAnimation")

            print("Setting new velocity animation...")
            switch(velocityCategory){
                case .High:
                    playerAnimation.runAnimation(withAnimationNameOf: "highVelocity", andWithAnimationKeyOf: "velocityAnimation", repeatForever: true)
                    break
                case .Medium:
                    playerAnimation.runAnimation(withAnimationNameOf: "mediumVelocity", andWithAnimationKeyOf: "velocityAnimation", repeatForever: true)
                    break
                case .Low:
                    playerAnimation.runAnimation(withAnimationNameOf: "lowVelocity", andWithAnimationKeyOf: "velocityAnimation", repeatForever: true)
                    break
                case .None:
                    playerAnimation.runAnimation(withAnimationNameOf: "mediumVelocityRed", andWithAnimationKeyOf: "velocityAnimation", repeatForever: true)
            }
        
        
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        
      
        /** Prior to update the velocity animation, check player health. If player health has fallen to zero, the player enter the PlayerDead state, whereupon the die animation is executed
 
        **/
        
        guard let playerNode = playerEntity.component(ofType: RenderComponent.self)?.node else {
            print("Error: unable to retrieve player's render node")
            return
            }
        
        guard let updatedHealth = playerEntity.component(ofType: HealthComponent.self)?.currentHealth else {
            print("Error: unable to retrieve player's health")
            return }

        
        if(updatedHealth <= 0){
            stateMachine?.enter(PlayerDeadState.self)
            return
        }
        
        /** If the player's damage state has changed since the previous update, then update the emitter node.  Lower health (i.e. more damage) corresponds to thicker and faster smoke emitting from the plane.
 
        **/
        if updatedHealth != currentHealth{
            let emitterNode = playerNode.childNode(withName: "smokeEmitterNode")
            
            /** If an emitter node has already been added, remove it **/
            if emitterNode != nil {
                emitterNode!.removeFromParent()
            }
            
            let playerNodeWith = playerNode.size.width
            
            switch(updatedHealth){
                case 3:
                    print("Adding new emitter node...")
                    let smokeEmitterNode = SKScene(fileNamed: "Damage1.sks")
                    smokeEmitterNode?.name = "smokeEmitterNode"
                    smokeEmitterNode?.zPosition = -1
                    smokeEmitterNode?.position = CGPoint(x: -(playerNodeWith*0.20), y: 0.00)
                    smokeEmitterNode?.move(toParent: playerNode)
                    break
                case 2:
                    print("Adding new emitter node...")
                    let smokeEmitterNode = SKScene(fileNamed: "Damage2.sks")
                    smokeEmitterNode?.name = "smokeEmitterNode"
                    smokeEmitterNode?.zPosition = -1
                    smokeEmitterNode?.position = CGPoint(x: -(playerNodeWith*0.20), y: 0.00)
                    smokeEmitterNode?.move(toParent: playerNode)
                    break
                case 1:
                    print("Adding new emitter node...")
                    let smokeEmitterNode = SKScene(fileNamed: "Damage3.sks")
                    smokeEmitterNode?.name = "smokeEmitterNode"
                    smokeEmitterNode?.zPosition = -1
                    smokeEmitterNode?.position = CGPoint(x: -(playerNodeWith*0.20), y: 0.00)
                    smokeEmitterNode?.move(toParent: playerNode)
                    break
                case 0:
                    print("Adding new emitter node...")
                    let smokeEmitterNode = SKScene(fileNamed: "Damage3.sks")
                    smokeEmitterNode?.name = "smokeEmitterNode"
                    smokeEmitterNode?.zPosition = -1
                    smokeEmitterNode?.position = CGPoint(x: -(playerNodeWith*0.20), y: 0.00)
                    smokeEmitterNode?.move(toParent: playerNode)
                    break
                default:
                    break
            }
        
            
            currentHealth = updatedHealth
        }
        
        
        /** Obtain a reference to the playe's physics boy and compute an update velocity category for the player.  If the velocity category hasn't changed, then exit the update function.  Otherwise, update the player's animation based on the new velocity category.
 
        **/
        
        guard let playerPhysicsBody = playerEntity.component(ofType: PhysicsComponent.self)?.physicsBody else {
            print("Error: player must have a physics component")
            return
        }
        
        let updatedVelocityDx = Int(playerPhysicsBody.velocity.dx)
        
        let updatedVelocityCategory = PlayerVelocityCategory(playerVelocityX: updatedVelocityDx)
        
        
        guard updatedVelocityCategory != currentVelocityCategory else { return }
        
        print("Velocity category has been updated...")
     
        currentVelocityCategory = updatedVelocityCategory
        
        guard let playerAnimation = playerEntity.component(ofType: BasicAnimationComponent.self) else {
                print("Error: player must have a basic animation component")
                return
        }
            
        print("Updating velocity animation...")
        
        /** Remove previously running velocity animations **/
        if playerAnimation.animationNode?.action(forKey: "velocityAnimation") != nil{
            playerAnimation.animationNode?.removeAction(forKey: "velocityAnimation")

        }
        
        switch(updatedVelocityCategory){
            case .High:
                playerAnimation.runAnimation(withAnimationNameOf: "highVelocity", andWithAnimationKeyOf: "velocityAnimation", repeatForever: true)
                break
            case .Medium:
                 playerAnimation.runAnimation(withAnimationNameOf: "mediumVelocity", andWithAnimationKeyOf: "velocityAnimation", repeatForever: true)
                break
            case .Low:
                 playerAnimation.runAnimation(withAnimationNameOf: "lowVelocity", andWithAnimationKeyOf: "velocityAnimation", repeatForever: true)
                break
            case .None:
                playerAnimation.runAnimation(withAnimationNameOf: "mediumVelocity", andWithAnimationKeyOf: "velocityAnimation", repeatForever: true)
        
            }
    
    
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        super.isValidNextState(stateClass)
        
        switch stateClass{
            case is PlayerDamagedState.Type, is PlayerDeadState.Type, is PlayerSuccessState.Type:
                return true
            default:
                return false
        }
        
    }
    
  
}
