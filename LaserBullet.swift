//
//  LaserBullet.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/7/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class LaserBullet: SKSpriteNode{
    
    enum LaserColor{
        case Red, Blue, Green, Yellow
    }
    
    enum LaserOrientation{
        case Horizontal, Vertical
    }
    
    enum Direction{
        case Up,Down,Left,Right
    }
    
    typealias LaserConfiguration = (laserColor: LaserColor, laserOrientation: LaserOrientation)
    
    convenience init?(laserColor: LaserColor, laserOrientation: LaserOrientation, shootingDirection: Direction, bulletSpeed: CGFloat, scalingFactor: CGFloat?) {
        
        guard let laserTexture = LaserBullet.GetLaserTexture(forLaserConfiguration: (laserColor, laserOrientation)) else {
                print("Error: failed to load the laser texture")
                return nil
            }
        
        self.init(texture: laserTexture, color: .clear, size: laserTexture.size())
        
        
        self.physicsBody = SKPhysicsBody(rectangleOf: laserTexture.size())
        
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.linearDamping = 0.00
        
        self.physicsBody?.categoryBitMask = CollisionConfiguration.Enemy.categoryMask
        self.physicsBody?.collisionBitMask = CollisionConfiguration.Player.categoryMask
        self.physicsBody?.contactTestBitMask = CollisionConfiguration.Player.categoryMask
        
        
        var firingVelocity = CGVector.zero
        
        let adjustedBulletSpeed = abs(bulletSpeed)
        
        switch shootingDirection{
            case .Up:
                firingVelocity = CGVector(dx: 0.00, dy: adjustedBulletSpeed)
            case .Down:
                firingVelocity = CGVector(dx: 0.00, dy: -adjustedBulletSpeed)
            case .Right:
                firingVelocity = CGVector(dx: adjustedBulletSpeed, dy: 0.00)
            case .Left:
                firingVelocity = CGVector(dx: -adjustedBulletSpeed, dy: 0.00)
        }
        
        self.physicsBody?.velocity = firingVelocity
        
        
        
        if let scalingFactor = scalingFactor{
            xScale *= scalingFactor
            yScale *= scalingFactor
        }
        
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension LaserBullet{
    
    static func GetLaserTexture(forLaserConfiguration laserConfiguration: LaserConfiguration) -> SKTexture?{
        
        
        var laserTexture: SKTexture?
        
        switch laserConfiguration{
        case (.Red, .Horizontal):
            laserTexture = SKTexture(image: #imageLiteral(resourceName: "laserRed"))
            break
        case (.Red, .Vertical):
            laserTexture = SKTexture(image: #imageLiteral(resourceName: "laserRedTop"))
            break
        case (.Yellow, .Horizontal):
            laserTexture = SKTexture(image: #imageLiteral(resourceName: "laserYellow"))
            break
        case (.Yellow, .Vertical):
            laserTexture = SKTexture(image: #imageLiteral(resourceName: "laserYellowTop"))
            break
        case (.Green, .Horizontal):
            laserTexture = SKTexture(image: #imageLiteral(resourceName: "laserGreen"))
            break
        case (.Green, .Vertical) :
            laserTexture = SKTexture(image: #imageLiteral(resourceName: "laserGreenTop"))
            break
        case (.Blue, .Horizontal):
            laserTexture = SKTexture(image: #imageLiteral(resourceName: "laserBlue"))
            break
        case (.Blue, .Vertical) :
            laserTexture = SKTexture(image: #imageLiteral(resourceName: "laserBlueTop"))
            break
        }
        
        return laserTexture
    }
    
}
