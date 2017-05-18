//
//  RandomImpulseComponent.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/6/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class RandomImpulseComponent: GKComponent{
    
    
    var physicsBody: SKPhysicsBody?
    
    var frameCount: TimeInterval = 0.00
    var impulseInterval: TimeInterval = 5.00
    var impulseVector: CGVector?
    
    convenience init(impulseInterval: TimeInterval, meanImpulseValue: Float, deviation: Float) {
        self.init()
        
        self.impulseInterval = impulseInterval
        
        
        
        let randomDist = GKGaussianDistribution(randomSource: GKARC4RandomSource(), mean: meanImpulseValue, deviation: deviation)
        
        let randomDy = randomDist.nextInt()
        let randomDx = randomDist.nextInt()
        
        let cgVector = CGVector(dx: randomDx, dy: randomDy)
        
        impulseVector = cgVector
    }
    
    convenience init(impulseInterval: TimeInterval) {
        self.init()
        
        self.impulseInterval = impulseInterval
        
        let randomDx = Double(arc4random_uniform(UInt32(200.00))) + -100.00
        let randomDy = Double(arc4random_uniform(UInt32(200.00))) + -100.00

        let cgVector = CGVector(dx: randomDx, dy: randomDy)
        impulseVector = cgVector
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didAddToEntity() {
        physicsBody = entity?.component(ofType: PhysicsComponent.self)?.physicsBody
    }
    
    override func willRemoveFromEntity() {
        physicsBody = nil
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        frameCount += seconds
        
        if frameCount > impulseInterval{
            
            if let appliedImpulse = impulseVector{
                physicsBody?.applyImpulse(appliedImpulse)
            }
            
            frameCount = 0.00
        }
        
    }
    
}
