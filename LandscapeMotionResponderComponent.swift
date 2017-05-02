//
//  LandscapeMotionResponderComponent.swift
//  AlphabetPilot
//
//  Created by Aleksander Makedonski on 4/23/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit
import CoreMotion

class LandscapeMotionResponderComponent: MotionResponderComponent{
    
    override init(motionManager: CMMotionManager) {
        super.init(motionManager: motionManager)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
    
    }
    
    
    func setAppliedForceDeltaY(){
        
        if motionManager.isDeviceMotionAvailable && motionManager.isGyroAvailable,let motionData = motionManager.deviceMotion{
            let horizontalAttitude = -motionData.attitude.roll
            let horizontalRotationRate = -motionData.rotationRate.y
            
            
            if((horizontalAttitude > 0.00 && horizontalRotationRate > 0.00) || (horizontalAttitude < 0.00 && horizontalRotationRate < 0.00)){
                appliedForceDeltaY = CGFloat(horizontalRotationRate)*150.00
            }
 
            //appliedForceDeltaY = CGFloat(horizontalAttitude)*50.0

        }
    }
    
    
    func setAppliedForceDeltaX(){
        
        if motionManager.isDeviceMotionAvailable && motionManager.isGyroAvailable,let motionData = motionManager.deviceMotion{
            let verticalAttitude = -motionData.attitude.pitch
            let verticalRotationRate = -motionData.rotationRate.x
            
        
            if((verticalAttitude < 0.00 && verticalRotationRate < 0.00) || (verticalAttitude > 0.00 && verticalRotationRate > 0.00)){
                appliedForceDeltaX = CGFloat(verticalRotationRate)*150.00
            }
 
            
        }
    }
    

    
    func applyPhysicsBodyForceFromRotationInput(){
        let appliedImpulseVector = CGVector(dx: appliedForceDeltaX, dy: appliedForceDeltaY)
        physicsBody.applyForce(appliedImpulseVector)
        
    }
    
 
}


class LandscapeMotionResponderComponentY: LandscapeMotionResponderComponent{
    
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        setAppliedForceDeltaY()
        applyPhysicsBodyForceFromRotationInput()
    }
}


class LandscapeMotionResponderComponentX: LandscapeMotionResponderComponent{
    
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        
        setAppliedForceDeltaX()
        applyPhysicsBodyForceFromRotationInput()
    }
}


class LandscapeMotionResponderComponentXY: LandscapeMotionResponderComponent{
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        setAppliedForceDeltaX()
        setAppliedForceDeltaY()
        applyPhysicsBodyForceFromRotationInput()
    }
}
