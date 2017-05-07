//
//  Barnacle.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/7/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit


class Barnacle: GKEntity{
    
    convenience init(position: CGPoint, nodeName: String, horizontalVelocity: CGFloat?, scalingFactor: CGFloat?) {
        
        self.init()
    
        let barnacleTexture = SKTexture(image: #imageLiteral(resourceName: "barnacle_bite"))
    
    
        let node = SKSpriteNode(texture: barnacleTexture)
        node.position = position
        node.name = nodeName
        
        let renderComponent = RenderComponent(spriteNode: node)
        addComponent(renderComponent)
        
    }
    
}
