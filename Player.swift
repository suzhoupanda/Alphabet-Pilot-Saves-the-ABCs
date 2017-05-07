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
    
    enum PlaneColor{
        case Red, Yellow, Green, Blue
    }
    
    var planeColor: PlaneColor = .Red
    
    //MARK: Properties 
    let mainMotionManager = MainMotionManager.sharedMotionManager
    
    ///ThvarRenderComponent' associated with the player
    
    var renderComponent: RenderComponent{
        guard let renderComponent = component(ofType: RenderComponent.self) else {
            fatalError("A player must have a render component")
        }
        
        return renderComponent

    }
    
    
    var hasAttainedLetter: Bool = false
    
    //MARK: Initializers
    
    
    convenience init(planeColor: PlaneColor) {
        
        self.init()
        addPlayerComponents(forPlaneColor: planeColor)
        
        let collectibleStorageComponent = CollectibleStorageComponent(lifeThreshold: 20)
        addComponent(collectibleStorageComponent)
        
    }
    
    override init() {
        super.init()
       
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func addPlayerComponents(forPlaneColor planeColor: PlaneColor){
        
        guard let texture = Player.getPlaneTexture(forPlaneColor: planeColor) else { return }
        
        /** Add the render component with the appropriate SKTexture derived from the Bunny base image
         **/
        
        addRenderNodeAndGraphNodeComponent(texture: texture)
        addPlayerPositionBroadcastingComponent()
        addPhysicsComponent(texture: texture)
        addVelocityComponent()
        addMotionResponderComponent()
        addAnimationComponent(forPlaneColor: planeColor)
        addHealthComponent()
        addIntelligenceComponent()
        addContactHandlerComponent()
        
    }
    
    func addRenderNodeAndGraphNodeComponent(texture: SKTexture){
        
        let renderComponent = RenderComponent(position: .zero, autoRemoveEnabled: false)
        renderComponent.node = SKSpriteNode(texture: texture, color: .clear, size: texture.size())
        renderComponent.node.name = "player"
        addComponent(renderComponent)
        
        let startPos = renderComponent.node.position
        let graphNodeComponent = GraphNodeComponent(cgPosition: startPos)
        addComponent(graphNodeComponent)
        
    }
    
    func addPlayerPositionBroadcastingComponent(){
        let playerPositionBroadcastingComponent = PlayerPositionBroadcasterComponent()
        addComponent(playerPositionBroadcastingComponent)
        
    }
    
    func addPhysicsComponent(texture: SKTexture){
        
        let physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        physicsBody.affectedByGravity = false
        physicsBody.allowsRotation = false
        physicsBody.mass = 1.00
        physicsBody.linearDamping = 0.00
        physicsBody.fieldBitMask = 0b1 << 0
        
        let physicsComponent = PhysicsComponent(physicsBody: physicsBody, collisionConfiguration: CollisionConfiguration.Player)
        addComponent(physicsComponent)
        
        
    }
    
    func addVelocityComponent(){

        let velocityComponent = VelocityComponent(velocityX: 50.0)
        addComponent(velocityComponent)
    }
    
    
    func addMotionResponderComponent(){
        
        let motionResponderComponent = LandscapeMotionResponderComponentY(motionManager: mainMotionManager)
        addComponent(motionResponderComponent)
        
    }

    func addHealthComponent(){
        
        let healthComponent = HealthComponent(startingHealth: 8)
        addComponent(healthComponent)
        
    }
    
    
    func addAnimationComponent(forPlaneColor planeColor: PlaneColor){
        
        let animationsDict = Player.getPlaneAnimationsDict(forPlaneColor: planeColor)
        
        let animationComponent = BasicAnimationComponent(animationsDict: animationsDict)
        
        addComponent(animationComponent)
    }
    
    func addIntelligenceComponent(){
        
        let intelligenceComponent = IntelligenceComponent(states: [
            PlayerActiveState(playerEntity: self),
            PlayerDamagedState(playerEntity: self),
            PlayerDeadState(playerEntity: self)
            ])
        addComponent(intelligenceComponent)
        intelligenceComponent.stateMachine?.enter(PlayerActiveState.self)
        
        
        addComponent(intelligenceComponent)
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
                self.hasAttainedLetter = true
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
            
        }, nodeBeginContactHandler: {
            
            (_ otherBodyNodeName: String) in
            
            if otherBodyNodeName.contains("coin"){
                
                if otherBodyNodeName.contains("gold"){
                    let userInfo = ["coinType":"gold", "coinNodeName":otherBodyNodeName]
                    NotificationCenter.default.post(name: Notification.Name.PlayerContactedCoinNotification, object: nil, userInfo: userInfo)
                }
                
                if otherBodyNodeName.contains("silver"){
                    let userInfo = ["coinType":"silver", "coinNodeName":otherBodyNodeName]
                    NotificationCenter.default.post(name: Notification.Name.PlayerContactedCoinNotification, object: nil, userInfo: userInfo)
                }
                
                if otherBodyNodeName.contains("bronze"){
                    let userInfo = ["coinType":"bronze", "coinNodeName":otherBodyNodeName]
                    NotificationCenter.default.post(name: Notification.Name.PlayerContactedCoinNotification, object: nil, userInfo: userInfo)
                }
                
            }
        
        }, categoryEndContactHandler: {
            
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






