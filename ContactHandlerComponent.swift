//
//  ContactHandlerComponent.swift
//  AlphabetPilot
//
//  Created by Aleksander Makedonski on 4/22/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit


class ContactHandlerComponent: GKComponent{
   
    
    //A CategoryContactHandler is a closure type for callbacks that enables an entity to respond to other physics bodies belonging to a given category; a NodeContactHandler is a closure type for callbacks that enables an entity to respond to physics bodies whose parent entity has a node with a specific node name
    
    typealias CategoryContactHandler = (_ otherBodyCategoryBitmask: UInt32) -> Void
    typealias NodeContactHandler = (_ otherBodyNodeName: String) -> Void
    
    //Callback methods are provided as initializer arguments to allow for the parent entity's physics body to respond to physics contacts with different physics bodies.  Separate callbacks are provided for handling contact initiation and contact termination.
    
    var categoryBeginContactHandler: CategoryContactHandler?
    var nodeBeginContactHandler: NodeContactHandler?
    
    var categoryEndContactHandler: CategoryContactHandler?
    var nodeEndContactHandler: NodeContactHandler?
    
    init(categoryBeginContactHandler: CategoryContactHandler?, nodeBeginContactHandler: NodeContactHandler?, categoryEndContactHandler: CategoryContactHandler?, nodeEndContactHandler: NodeContactHandler?) {
        
        self.categoryBeginContactHandler = categoryBeginContactHandler
        self.nodeBeginContactHandler = nodeBeginContactHandler
        
        self.categoryEndContactHandler = categoryEndContactHandler
        self.nodeEndContactHandler = nodeEndContactHandler
        
        super.init()
        
        registerNotifications()
        
    }
    
 

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: A notification is posted when a physics body of a given category type makes contact with another physics body; the contact handler is then called as a callback
    func didMakeContact(notification: Notification){
        
        guard let (otherBodyCategoryBitMask, otherBodyNodeName) = getOtherBodyInfoFromPhysicsContact(notification: notification) else {
            
                print("Error: Failed to obtain physics contact info for other body")
                return
            }
            
            if let categoryContactHandler = self.categoryBeginContactHandler{
                categoryContactHandler(otherBodyCategoryBitMask)
            }
            
            if let nodeContactHandler = self.nodeBeginContactHandler{
                nodeContactHandler(otherBodyNodeName)
            }
        
     
    }
    
    func didEndContact(notification: Notification){
        
        guard let (otherBodyCategoryBitMask, otherBodyNodeName) = getOtherBodyInfoFromPhysicsContact(notification: notification) else {
            
                print("Error: Failed to obtain physics contact info for other body")
                return
        }
        
        if let categoryEndContactHandler = self.categoryEndContactHandler{
            categoryEndContactHandler(otherBodyCategoryBitMask)
        }
        
        
        if let nodeEndContactHandler = self.nodeEndContactHandler{
            nodeEndContactHandler(otherBodyNodeName)
        }
        
    }

    /**  MARK:  ********* Convenience Method for getting the category bitmask and node name for the physics body other than that of the current physics body from a notification broadcast during a collision event
 
 
    **/
    private func getOtherBodyInfoFromPhysicsContact(notification: Notification) -> (OtherBodyCategoryBitMask: UInt32, OtherBodyNodeName: String)?{
        
        
        guard let contactInfoDict = notification.userInfo else {
            print("Error: contact user info dict not provided in notification or not available")
            return nil
            
        }
        
        guard let physicsBody = entity?.component(ofType: PhysicsComponent.self)?.physicsBody else {
            print("Error: the entity must have a physics body in order for a contact handler to act as a component")
            return nil
            
        }
        
        
        
        let (bodyAName,bodyACategoryBitmask) = (contactInfoDict[ContactInfoKeys.PhysicsBodyANodeNameKey] as! String, contactInfoDict[ContactInfoKeys.PhysicsBodyACategoryBitmaskKey] as! UInt32)
        
        let (bodyBName,bodyBCategoryBitmask) =
            (contactInfoDict[ContactInfoKeys.PhysicsBodyBNodeNameKey] as! String, contactInfoDict[ContactInfoKeys.PhysicsBodyBCategoryBitmaskKey] as! UInt32)
        
        
        var otherBodyCategoryBitmask: UInt32
        var otherBodyNodeName: String
        
        if(physicsBody.categoryBitMask & bodyACategoryBitmask > 0){
            otherBodyCategoryBitmask = bodyBCategoryBitmask
            otherBodyNodeName = bodyBName
        } else {
            otherBodyCategoryBitmask = bodyACategoryBitmask
            otherBodyNodeName = bodyAName
        }

        return (otherBodyCategoryBitmask, otherBodyNodeName)
    }
    
    func registerNotifications(){
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(ContactHandlerComponent.didMakeContact(notification:)), name: Notification.Name.PlayerDidMakeContactNotification, object: nil)
        
        nc.addObserver(self, selector: #selector(ContactHandlerComponent.didEndContact(notification:)), name: Notification.Name.PlayerDidEndContactNotification, object: nil)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
}

class ContactInfoKeys{
    static let PhysicsBodyACategoryBitmaskKey: String = "categoryBitmaskA"
    static let PhysicsBodyACollisionBitmaskKey: String = "collisionBitmaskA"
    static let PhysicsBodyAContactBitmaskKey: String = "contactBitmaskA"
    static let PhysicsBodyANodeNameKey: String = "PhysicsBodyANodeName"
    
    static let PhysicsBodyBCategoryBitmaskKey: String = "categoryBitmaskB"
    static let PhysicsBodyBCollisionBitmaskKey: String = "collisionBitmaskB"
    static let PhysicsBodyBContactBitmaskKey: String = "contactBitmaskB"
    static let PhysicsBodyBNodeNameKey: String = "PhysicsBodyBNodeName"
    
    
}
