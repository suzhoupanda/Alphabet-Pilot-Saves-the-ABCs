//
//  MotionResponderComponent.swift
//  Badboy Bunny Saves the Alphabet
//
//  Created by Aleksander Makedonski on 4/25/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit
import CoreMotion

class MotionResponderComponent: GKComponent{
    
    var motionManager: CMMotionManager!
    
    var physicsBody: SKPhysicsBody{
        guard let physicsBody = entity?.component(ofType: PhysicsComponent.self)?.physicsBody else {
            fatalError("Entity must have a physics body in order to enable its MotionResponderComponent functionality")
        }
        
        return physicsBody
    }
    
    
    var appliedForceDeltaX: CGFloat = 0.00
    var appliedForceDeltaY: CGFloat = 0.00
    
    
    /**  AdjustmentCoefficents allow fine-tuning of the sensitivty level of the CoreMotion responder.  Player movement can be modified so as to make it faster on icy surfaces, slower on muddy surfaces or in lava pits, etc.  Likewise, if player is an airplane, it can be modified so that player movement is less sensitive for a low fuel or damaged state.
 
    **/
    var adjustmentCoefficientY: Double = 500.00
    var adjustmentCoefficientX: Double = 500.00
    
    
    
    init(motionManager: CMMotionManager){
        super.init()
        
        self.motionManager = motionManager
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        

    }
    
    
    
    
  
    deinit {

        NotificationCenter.default.removeObserver(self)
    }
    
    
}
