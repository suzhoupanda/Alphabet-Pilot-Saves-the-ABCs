//
//  RockSpawningComponent.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/7/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//


import Foundation
import SpriteKit
import GameplayKit

class RockSpawningComponent: GKComponent{
    
    
    
    //MARK: Firing Speed and Orientation Variables
    
    var spawningPoint: CGPoint = .zero
    var xPosVariance: CGFloat = 0.00
    
    var rockType: FallingRock.RockType = .Stone
    var rockSize: FallingRock.RockSize = .Large
    
    //MARK: Timing-Related Variables
    
    var frameCount: TimeInterval = 0.00
    var spawningInterval: TimeInterval = 2.00
    
    convenience init(spawningInterval: TimeInterval, spawningPoint: CGPoint, spawnPosVariance: CGFloat, rockType: FallingRock.RockType, rockSize: FallingRock.RockSize) {
        
        self.init()
        
        self.xPosVariance = spawnPosVariance
        self.spawningPoint = spawningPoint
        self.spawningInterval = spawningInterval
        self.frameCount = 0.00
    
        self.rockSize = rockSize
        self.rockType = rockType
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        guard let targetDetectionComponent = entity?.component(ofType: TargetDetectionComponent.self) else {
            print("Error: enemy must have a target detection component in order for bullet firing component to update")
            return
        }
        
        guard let worldNode = entity?.component(ofType: RenderComponent.self)?.node.parent else {
            print("Error: enemy must have a render component whose node is attached to the node hierarchy of the worldNode")
            return
        }
     
        
        if targetDetectionComponent.playerHasEnteredProximity{
            
            frameCount += seconds
            
            if frameCount > spawningInterval{
                
                print("Spawning rock...")
                
                if let fallingRock = FallingRock(rockType: rockType, rockSize: rockSize, scalingFactor: 0.70){
                    
                    print("Adding rock to scene...")
                    worldNode.addChild(fallingRock)

                    fallingRock.zPosition = 2
                    
                    let randomSource = GKMersenneTwisterRandomSource()
                    let randomDist = GKGaussianDistribution(randomSource: randomSource, mean: Float(spawningPoint.x), deviation: Float(xPosVariance))
                    
                    let spawnPos = CGPoint(x: CGFloat(randomDist.nextUniform()), y: spawningPoint.y)
                    
                    fallingRock.position = spawnPos
                    
                    
                    
                    
                    fallingRock.run(SKAction.fadeOut(withDuration: 4.00), completion: {
                        fallingRock.removeFromParent()
                    })
                    
                    
                    
                }
                
                frameCount = 0.00
            }
        }
    }
}
