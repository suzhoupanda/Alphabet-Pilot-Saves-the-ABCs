//
//  Extensions.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/2/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

/** 
 
 Useful extensions for several commonly-used classes (both from the standard library and from imported frameworks e.g. GKAgent2D, SKSpriteNoe, CGPoint, vector_float2 )

 **/

//MARK: ******* Convenience Methods (via extension of CGPoint and vector_float2 classes) to allow easy interconversion between CGPoint and vector_float2 values


extension GKAgent2D{
    func lerpToPoint(cgPoint: CGPoint, withLerpFactor lerpFactor: Float){
        
        let lerpXPos = (Float(cgPoint.x) - self.position.x)*lerpFactor
        let lerpYPos = (Float(cgPoint.y) - self.position.y)*lerpFactor
        
        self.position.x += lerpXPos
        self.position.y += lerpYPos
        
    }
}


extension SKSpriteNode{
    func lerpToPoint(agentPosition: vector_float2, withLerpFactor lerpFactor: CGFloat){
        let lerpXPos = (CGFloat(agentPosition.x) - self.position.x)*lerpFactor
        let lerpYPos = (CGFloat(agentPosition.y) - self.position.y)*lerpFactor
        
        self.position.x += lerpXPos
        self.position.y += lerpYPos
        
    }
    
    func lerpToPoint(targetPoint: CGPoint, withLerpFactor lerpFactor: CGFloat){
        let xLerp = (targetPoint.x - self.position.x)*lerpFactor
        let yLerp = (targetPoint.x - self.position.y)*lerpFactor
        
        self.position.x += xLerp
        self.position.y += yLerp
    }
}

extension SKPhysicsBody{
    func lerpToVelocity(agentVelocity: vector_float2, withLerpFactor lerpFactor: CGFloat){
        
        let renderNodeVelocityDx = self.velocity.dx
        let renderNodeVelocityDy = self.velocity.dy
        
        let lerpXVelocity = (CGFloat(agentVelocity.x) - renderNodeVelocityDx)*0.10
        let lerpYVelocity = (CGFloat(agentVelocity.y) - renderNodeVelocityDy)*0.10
        
        self.velocity.dx += lerpXVelocity
        self.velocity.dy += lerpYVelocity
    }
}

extension CGPoint{
    
    func getVectorFloat2() -> vector_float2{
        let xPos = Float(self.x)
        let yPos = Float(self.y)
        
        return vector_float2(x: xPos, y: yPos)
    }
    
    
    func getDistanceToPoint(otherPoint: CGPoint) -> Double{
        let dx = otherPoint.x - self.x
        let dy = otherPoint.y - self.y
        
        let dxSquared = Double(pow(dx, 2.0))
        let dySquared = Double(pow(dy, 2.0))
        
        return sqrt(dxSquared + dySquared)
        
        
    }
}

extension vector_float2{
    
    
    func getDistanceToPoint(otherPoint: vector_float2) -> Double{
        
        let dx = otherPoint.x - self.x
        let dy = otherPoint.y - self.y
        
        let dxSquared = Double(pow(dx, 2.0))
        let dySquared = Double(pow(dy, 2.0))
        
        return sqrt(dxSquared+dySquared)
    }
    
    func getCGPoint() -> CGPoint{
        let xPos = CGFloat(self.x)
        let yPos = CGFloat(self.y)
        
        return CGPoint(x: xPos, y: yPos)
    }
    
    func getCGVector() -> CGVector{
        
        let dx = CGFloat(self.x)
        let dy = CGFloat(self.y)
        
        return CGVector(dx: dx, dy: dy)
        
    }
    
    /**
     func getConvertedDataType<T>() -> T{
     let convertedX = CGFloat(self.x)
     let convertedY = CGFloat(self.y)
     
     var t = T()
     t.x = convertedX
     t.y = convertedY
     
     return t
     }
     **/
}
