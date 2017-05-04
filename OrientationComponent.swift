//
//  OrientationComponent.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/4/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//


import Foundation
import GameplayKit
import SpriteKit


enum Orientation: String{
    case Left, Right, None
}


class OrientationComponent: GKComponent{
    
    
    var currentOrientation: Orientation
    
    init(currentOrientation: Orientation){
        self.currentOrientation = currentOrientation
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        /** For symmetrical entities which don't have orientation, orientation is not set dynamically based on the horizontal velocity of the physics body
         
         **/
        guard currentOrientation != .None else { return }
        
        guard let physicsBody = entity?.component(ofType: PhysicsComponent.self)?.physicsBody else { return }
        
        if physicsBody.velocity.dx > 10{
            currentOrientation = .Right
        } else if physicsBody.velocity.dx < -10 {
            currentOrientation = .Left
        }
        
    }
}

