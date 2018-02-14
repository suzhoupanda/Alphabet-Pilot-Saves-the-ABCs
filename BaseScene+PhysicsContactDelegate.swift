//
//  BaseScene+PhysicsContactDelegate.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/1/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit

extension BaseScene: SKPhysicsContactDelegate{
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        
        
        /** These variables may be required later for implementing contact logic between different combinations of non-player entities: 
         
        guard let playerPhysicsBody = player.component(ofType: PhysicsComponent.self)?.physicsBody else { return }
        
        let playerBody = (contact.bodyA.categoryBitMask & CollisionConfiguration.Player.categoryMask > 0) ? contact.bodyA : contact.bodyB
        
        let otherBody = (contact.bodyA.categoryBitMask & CollisionConfiguration.Player.categoryMask > 0) ? contact.bodyB : contact.bodyA
        
        let enemyBody = (contact.bodyA.categoryBitMask & CollisionConfiguration.Enemy.categoryMask > 0) ? contact.bodyA : contact.bodyB
        
        let nonEnemyBody = (contact.bodyA.categoryBitMask & CollisionConfiguration.Enemy.categoryMask > 0) ? contact.bodyB : contact.bodyA
        **/
        
        //NodeNames corresponding to physics bodies A and B
        
        let bodyANodeName = contact.bodyA.node?.entity?.component(ofType: RenderComponent.self)?.node.name ?? "BodyANodeName"
        
        let bodyBNodeName = contact.bodyB.node?.entity?.component(ofType: RenderComponent.self)?.node.name ?? "BodyBNodeName"
        
        let userInfo = [
            ContactInfoKeys.PhysicsBodyACategoryBitmaskKey: contact.bodyA.categoryBitMask,
            ContactInfoKeys.PhysicsBodyANodeNameKey: bodyANodeName,
            ContactInfoKeys.PhysicsBodyBCategoryBitmaskKey : contact.bodyB.categoryBitMask,
            ContactInfoKeys.PhysicsBodyBNodeNameKey : bodyBNodeName
        ] as [String : Any]
        
        NotificationCenter.default.post(name: Notification.Name.PlayerDidMakeContactNotification, object: nil, userInfo: userInfo)
        
        
       
    
    }
    
    
    func didEnd(_ contact: SKPhysicsContact) {
        
        /** These variables may be required later for implementing contact logic among different combinations of non-player entities: 
         
        guard let playerPhysicsBody = player.component(ofType: PhysicsComponent.self)?.physicsBody else { return }
        
        
        let playerBody = (contact.bodyA.categoryBitMask & CollisionConfiguration.Player.categoryMask > 0) ? contact.bodyA : contact.bodyB
        
        let otherBody = (contact.bodyA.categoryBitMask & CollisionConfiguration.Player.categoryMask > 0) ? contact.bodyB : contact.bodyA
        
        let enemyBody = (contact.bodyA.categoryBitMask & CollisionConfiguration.Enemy.categoryMask > 0) ? contact.bodyA : contact.bodyB
        
        let nonEnemyBody = (contact.bodyA.categoryBitMask & CollisionConfiguration.Enemy.categoryMask > 0) ? contact.bodyB : contact.bodyA
        **/
        
        //NodeNames corresponding to physics bodies A and B
        
        let bodyANodeName = contact.bodyA.node?.entity?.component(ofType: RenderComponent.self)?.node.name ?? "BodyANodeName"
        
        let bodyBNodeName = contact.bodyB.node?.entity?.component(ofType: RenderComponent.self)?.node.name ?? "BodyBNodeName"
        
        let userInfo = [
            ContactInfoKeys.PhysicsBodyACategoryBitmaskKey: contact.bodyA.categoryBitMask,
            ContactInfoKeys.PhysicsBodyANodeNameKey: bodyANodeName,
            ContactInfoKeys.PhysicsBodyBCategoryBitmaskKey : contact.bodyB.categoryBitMask,
            ContactInfoKeys.PhysicsBodyBNodeNameKey : bodyBNodeName
            ] as [String : Any]
        
        NotificationCenter.default.post(name: Notification.Name.PlayerDidEndContactNotification, object: nil, userInfo: userInfo)
        /**
        let otherBody = contact.bodyA.categoryBitMask & CollisionConfiguration.Player.categoryMask > 0 ? contact.bodyB : contact.bodyA
        
        
        switch(otherBody.categoryBitMask){
        case CollisionConfiguration.Collectible.categoryMask:
            player.renderComponent.node.run(powerUpSound1)
            print("Sound should be playing....")
            
            break
        case CollisionConfiguration.Barrier.categoryMask:
            player.renderComponent.node.run(hitBarrierSound)
            print("Hit barrier sound should be playing..")
            break
        case CollisionConfiguration.Enemy.categoryMask:
            player.renderComponent.node.run(hitEnemySound)
            print("Hit enemy sound should be playing...")
            break
        default:
            break
        }
         **/
        
    }
}
