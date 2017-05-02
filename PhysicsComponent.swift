//
//  PhysicsComponent.swift
//  AlphabetPilot
//
//  Created by Aleksander Makedonski on 4/22/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit


class PhysicsComponent: GKComponent{
    
    //MARK: Properties 
    
    var physicsBody: SKPhysicsBody
    
    //MARK: Initializer
    
    init(physicsBody: SKPhysicsBody, collisionConfiguration: CollisionConfiguration){
        
        self.physicsBody = physicsBody
        self.physicsBody.categoryBitMask = collisionConfiguration.categoryMask
        self.physicsBody.collisionBitMask = collisionConfiguration.collisionMask
        self.physicsBody.contactTestBitMask = collisionConfiguration.contactMask
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func didAddToEntity() {
        
        guard let node = entity?.component(ofType: RenderComponent.self)?.node else {
            fatalError("The physics component must be attached to an entity")
        }
        
        node.physicsBody = physicsBody
    }
    
    override func willRemoveFromEntity() {
        
        guard let node = entity?.component(ofType: RenderComponent.self)?.node else {
            fatalError("The physics component must be attached to an entity")
        }
        
        node.physicsBody = nil
    }
}
