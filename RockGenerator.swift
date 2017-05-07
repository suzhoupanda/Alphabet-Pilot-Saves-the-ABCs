//
//  RockGenerator.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/7/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class RockGenerator: GKEntity{
    
  
    convenience init(rockType: FallingRock.RockType, rockSize: FallingRock.RockSize, position: CGPoint, nodeName: String, targetNode: SKSpriteNode, proximityDistance: Double, scalingFactor: CGFloat?) {
        self.init()
        
        let node = SKSpriteNode()
        node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        node.position = position
        node.name = nodeName
        
        let renderComponent = RenderComponent(spriteNode: node)
        addComponent(renderComponent)
        
        
        let targetDetectionComponent = TargetDetectionComponent(targetNode: targetNode, proximityDistance: proximityDistance)
        addComponent(targetDetectionComponent)
        
        
        let rockSpawningComponent = RockSpawningComponent(spawningInterval: 2.00, spawningPoint: position, spawnPosVariance: 20.00, rockType: rockType, rockSize: rockSize)
        addComponent(rockSpawningComponent)
 
        
        
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
