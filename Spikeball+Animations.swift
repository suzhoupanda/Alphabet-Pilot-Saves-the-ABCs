//
//  Spikeball+Animations.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/4/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

extension Spikeball{
    
    static let AnimationsDict: [String: SKAction] = [
        "turnAnimation" : SKAction.animate(with: [
            SKTexture(image: #imageLiteral(resourceName: "spikeBall1")),
            SKTexture(image: #imageLiteral(resourceName: "spikeBall_2"))
            ], timePerFrame: 0.10)
    
    ]

}
