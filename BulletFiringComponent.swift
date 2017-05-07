//
//  BulletFiringComponent.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/7/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class BulletFiringComponent: GKComponent{
    
    //MARK: Firing Speed and Orientation Variables
    var bulletSpeed: CGFloat = 0.00
    var bulletColor: LaserBullet.LaserColor = .Blue
    var shootingDirection: LaserBullet.Direction = .Left
    
    //MARK: Firing Timing-Related Variables
    
    var frameCount: TimeInterval = 0.00
    var firingInterval: TimeInterval = 2.00
    
    convenience init(firingInterval: TimeInterval, shootingDirection: LaserBullet.Direction, bulletSpeed: CGFloat, bulletColor: LaserBullet.LaserColor) {
        
        self.init()

        self.firingInterval = firingInterval
        self.frameCount = 0.00
        
        self.bulletColor = bulletColor
        self.shootingDirection = shootingDirection
        
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
        
        guard let renderComponent = entity?.component(ofType: RenderComponent.self) else {
            print("Error: enemy must have a render component in order for bullet firing component to update")
            return
        }
        
        let renderNode = renderComponent.node
        
        if targetDetectionComponent.playerHasEnteredProximity{
       
            frameCount += seconds
        
            if frameCount > firingInterval{
            
                let laserOrientation: LaserBullet.LaserOrientation = (shootingDirection == .Up || shootingDirection == .Down) ? .Vertical : .Horizontal
            
                if let laserBullet = LaserBullet(laserColor: bulletColor, laserOrientation: laserOrientation, shootingDirection: shootingDirection, bulletSpeed: bulletSpeed, scalingFactor: 0.80), let worldNode = renderNode.parent{
                    
                    laserBullet.zPosition = 2
                    laserBullet.position = renderNode.position
                    worldNode.addChild(laserBullet)
                
                    
                    
                }
            
                frameCount = 0.00
            }
        }
    }
}
