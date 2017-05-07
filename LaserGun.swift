//
//  LaserGun.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/7/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class LaserGun: GKEntity{
    
    enum LaserGunOrientation{
        case Top,Bottom,Left
    }
    
    convenience init(laserGunOrientation: LaserGunOrientation, position: CGPoint, nodeName: String, targetNode: SKSpriteNode, proximityDistance: Double, bulletSpeed: CGFloat, bulletColor: LaserBullet.LaserColor, scalingFactor: CGFloat?) {
        self.init()
        
            var gunTexture: SKTexture
        
            switch laserGunOrientation{
                case .Top:
                    gunTexture = SKTexture(image: #imageLiteral(resourceName: "laserGunTop1"))
                case .Bottom:
                    gunTexture = SKTexture(image: #imageLiteral(resourceName: "laserGunBottom1"))
                case .Left:
                    gunTexture = SKTexture(image: #imageLiteral(resourceName: "laserGunLeft1"))
            }
    
        let node = SKSpriteNode(texture: gunTexture)
        
        node.anchorPoint = CGPoint(x: 0.5, y: 0.00)
        node.position = position
        node.name = nodeName
        
        let renderComponent = RenderComponent(spriteNode: node)
        addComponent(renderComponent)
        
      
        
        let physicsBody = SKPhysicsBody(texture: gunTexture, size: gunTexture.size())
        physicsBody.affectedByGravity = false
        physicsBody.allowsRotation = false
        physicsBody.isDynamic = false
        
        let physicsComponent = PhysicsComponent(physicsBody: physicsBody, collisionConfiguration: CollisionConfiguration.Enemy)
        
        addComponent(physicsComponent)
        
        let targetDetectionComponent = TargetDetectionComponent(targetNode: targetNode, proximityDistance: proximityDistance)
        addComponent(targetDetectionComponent)
        
        var shootingDirection: LaserBullet.Direction
        
        switch laserGunOrientation{
            case .Bottom:
                shootingDirection = .Up
                break
            case .Left:
                shootingDirection = .Left
                break
            case .Top:
                shootingDirection = .Down
                break
            }
        
        let bulletFiringComponent = BulletFiringComponent(firingInterval: 2.00, shootingDirection: shootingDirection, bulletSpeed: bulletSpeed, bulletColor: bulletColor)
        
        addComponent(bulletFiringComponent)
        
        //Animations Component is initialized with an animations dictionary, which is stored on the EvilSun class as a static type property
        
        let animationsDict = LaserGun.GetAnimationsDict(laserGunOrientation: laserGunOrientation)
        let animationComponent = BasicAnimationComponent(animationsDict: animationsDict)
        addComponent(animationComponent)
       
    
        if let scalingFactor = scalingFactor{
            node.xScale *= scalingFactor
            node.yScale *= scalingFactor
        }
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
