//
//  RabbitEntity.swift
//  AlphabetPilot
//
//  Created by Aleksander Makedonski on 4/22/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit


class Player: GKEntity{
    
    
    //MARK: Properties 
    let mainMotionManager = MainMotionManager.sharedMotionManager
    
    ///ThvarRenderComponent' associated with the player
    
    var renderComponent: RenderComponent{
        guard let renderComponent = component(ofType: RenderComponent.self) else {
            fatalError("A player must have a render component")
        }
        
        return renderComponent

    }
    
    //MARK: Initializers
    
    override init() {
        super.init()
        
        /** Add the render component with the appropriate SKTexture derived from the Bunny base image
        **/
        let texture = SKTexture(image: #imageLiteral(resourceName: "planeRed1"))
        let renderComponent = RenderComponent(position: .zero, autoRemoveEnabled: false)
        renderComponent.node = SKSpriteNode(texture: texture, color: .clear, size: texture.size())
        renderComponent.node.name = "player"
        addComponent(renderComponent)
      
        let startPos = renderComponent.node.position
        let graphNodeComponent = GraphNodeComponent(cgPosition: startPos)
        addComponent(graphNodeComponent)
        
        
        let playerPositionBroadcastingComponent = PlayerPositionBroadcasterComponent()
        addComponent(playerPositionBroadcastingComponent)
    
        /**  Add a physics body component whose physics body dimensions are based on that of the node texture
 
        **/
        let physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        physicsBody.affectedByGravity = false
        physicsBody.allowsRotation = false
        physicsBody.mass = 1.00
        physicsBody.linearDamping = 0.00
        
        let physicsComponent = PhysicsComponent(physicsBody: physicsBody, collisionConfiguration: CollisionConfiguration.Player)
        addComponent(physicsComponent)
        
        
        let velocityComponent = VelocityComponent(velocityX: 50.0)
        addComponent(velocityComponent)
        
        let motionResponderComponent = LandscapeMotionResponderComponentY(motionManager: mainMotionManager)
        addComponent(motionResponderComponent)
        
        addContactHandlerComponent()
        
        //The player is scaled down after the physics body is added so that the physics body scaled down along with the node texture
        
        
        let animationComponent = BasicAnimationComponent(animationsDict: Player.AnimationsDict)
        addComponent(animationComponent)
        
        let healthComponent = HealthComponent(startingHealth: 5)
        addComponent(healthComponent)
        
        let intelligenceComponent = IntelligenceComponent(states: [
            PlayerActiveState(playerEntity: self),
            PlayerDamagedState(playerEntity: self),
            PlayerDeadState(playerEntity: self)
            ])
        addComponent(intelligenceComponent)
        intelligenceComponent.stateMachine?.enter(PlayerActiveState.self)
        
        
        addComponent(intelligenceComponent)
        
        renderComponent.node.xScale *= 0.50
        renderComponent.node.yScale *= 0.50
        
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
  
    func addContactHandlerComponent(){
    
        let contactHandlerComponent = ContactHandlerComponent(categoryBeginContactHandler: {
            
            //MARK: ******** Handler for contact initiation with physics bodies of various category bitmasks 
            
            (otherBodyCategoryBitMask: UInt32 ) in
            
            switch(otherBodyCategoryBitMask){
            case CollisionConfiguration.Barrier.categoryMask:
                print("Player contacted barrier")
                break
            case CollisionConfiguration.Enemy.categoryMask:
                NotificationCenter.default.post(name: Notification.Name.PlayerDidTakeDamageNotification, object: nil, userInfo: nil)
                break
            case CollisionConfiguration.Collectible.categoryMask:
                print("Player contacted collectible")
                break
            case CollisionConfiguration.Letter.categoryMask:
                print("Player contacted letter")
                self.component(ofType: IntelligenceComponent.self)?.stateMachine?.enter(PlayerSuccessState.self)
         
                break
            case CollisionConfiguration.NonCollidingEnemy.categoryMask:
                print("Player contacted non-colliding enemy")
                break
            case CollisionConfiguration.Other.categoryMask:
                print("Player contacted other entity")
                break
            default:
                print("No contact logic implemented")
            }
            
        }, nodeBeginContactHandler: nil, categoryEndContactHandler: {
            
              //MARK: ******** Handler for contact termination with physics bodies of various category bitmasks 
            
            (otherBodyCategoryBitMask: UInt32 ) in
            
            switch(otherBodyCategoryBitMask){
            case CollisionConfiguration.Barrier.categoryMask:
               // print("Player stopped contacting barrier")
                break
            case CollisionConfiguration.Enemy.categoryMask:
              //  print("Player stopped contacting enemy")
                break
            case CollisionConfiguration.Collectible.categoryMask:
               // print("Player stopped contacting collectible")
                break
            case CollisionConfiguration.Letter.categoryMask:
               // print("Player stopped contacting letter")
                break
            case CollisionConfiguration.NonCollidingEnemy.categoryMask:
               // print("Player stopped contacting non-colliding enemy")
                break
            case CollisionConfiguration.Other.categoryMask:
               // print("Player stopped contacting other entity")
                break
            default:
                print("No contact logic implemented")
            }
            
        }, nodeEndContactHandler: nil)
        addComponent(contactHandlerComponent)
        

    }
 
}






