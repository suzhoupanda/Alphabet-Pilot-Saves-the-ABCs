//
//  VelocityComponent.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/1/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import GameplayKit




class VelocityComponent: GKComponent{
    
    var physicsBody: SKPhysicsBody?
    
    var velocityCategory: PlayerVelocityCategory?{
        get{
            guard let velocity = physicsBody?.velocity.dx else {
                print("Error: unable to compute velocityDx from velocity component ")
                return nil }
            
            let intVelocity = Int(velocity)
            
            return PlayerVelocityCategory(playerVelocityX: intVelocity)
        }
    }
    
    var velocityX: CGFloat = 0.00
    

    
    init(velocityX: CGFloat){
        
        self.velocityX = velocityX
        super.init()
        
        registerForNotification()
    }
    
    func increaseVelocityX(notification: Notification){
        velocityX += 10
    }
    
    func decreaseVelocityX(notification: Notification){
        velocityX -= 10
    }
    
    override func didAddToEntity() {
        guard let physicsBody = entity?.component(ofType: PhysicsComponent.self)?.physicsBody else {
            print("Error: the entity must have a physics component as a precondition for adding a velocity component")
            return
        }
        
        self.physicsBody = physicsBody
        self.physicsBody?.velocity.dx = velocityX
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        
        if let physicsBody = self.physicsBody{
            physicsBody.velocity.dx = velocityX
        }
    }
    
    func registerForNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(VelocityComponent.increaseVelocityX(notification:)), name: Notification.Name.DidIncreasePlayerVelocityNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(VelocityComponent.decreaseVelocityX(notification:)), name: Notification.Name.DidDecreasePlayerVelocityNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
