//
//  Coin.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/6/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit


class Coin: GKEntity{
    
    enum CoinType: String{
        case Gold, Silver, Bronze
        
        var coinValue: Int{
            get{
                switch self{
                    case .Gold:
                        return 5
                    case .Silver:
                        return 3
                    case .Bronze:
                        return 1
                }

            }
        }
    }
    
    var coinType: CoinType = .Gold
    
    var coinValue: Int{
        get{
            switch coinType{
                case .Gold:
                    return 5
                case .Silver:
                    return 3
                case .Bronze:
                    return 1
            }
        }
    }
    
    /** Initializer for an enemy that uses a target node component to detect player proximity; doesn't rely on pathfinding algorithms to move around obstalces, and doesn't rely on the agent/goal simulation from GameplayKit **/
    
    convenience init(coinType: CoinType, position: CGPoint, nodeName: String, scalingFactor: CGFloat?) {
        self.init()
        
        
        self.coinType = coinType
        
        guard let coinTexture = Coin.getCoinTexture(coinType: coinType) else {
            print("Error: failed to load coin texture")
            return
        }
        
        //The selected coin texture is used to initialize the sprite node for the render component as well as the physics body for the physics body component; position arguments is used to initialize the graph node component as well as to set the initial position of the render component
        
        let node = SKSpriteNode(texture: coinTexture)
        node.position = position
        node.name = nodeName
        
        let renderComponent = RenderComponent(spriteNode: node)
        addComponent(renderComponent)
        
        
        let physicsBody = SKPhysicsBody(texture: coinTexture, size: coinTexture.size())
        physicsBody.affectedByGravity = false
        physicsBody.allowsRotation = false
        physicsBody.isDynamic = false
        
        
        let physicsComponent = PhysicsComponent(physicsBody: physicsBody, collisionConfiguration: CollisionConfiguration.Collectible)

        addComponent(physicsComponent)
        
        
        let contactHandlerComponent = ContactHandlerComponent(categoryBeginContactHandler: nil, nodeBeginContactHandler: {
            
            otherBodyNodeName in
            
            if otherBodyNodeName.contains("player"){
                print("Contacted player...")
                physicsBody.categoryBitMask = 0
                node.removeFromParent()
            }
        
        }, categoryEndContactHandler: nil, nodeEndContactHandler: nil)
        
        addComponent(contactHandlerComponent)
        
        
        //Animations Component is initialized with an animations dictionary, which is stored on the Coin class as a static type property
        
        
        let animationComponent = BasicAnimationComponent(animationsDict: Coin.AnimationsDict)
        addComponent(animationComponent)
        
        let coinAnimationName = Coin.getCoinAnimationFor(coinType: coinType, forAnimationKey: "defaultAnimation")
        
        animationComponent.runAnimation(withAnimationNameOf: coinAnimationName, andWithAnimationKeyOf: "defaultAnimation", repeatForever: true)
        
        
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
    
    
    
    static func getCoinTexture(coinType: CoinType) -> SKTexture?{
    
        var coinTexture: SKTexture?
        
        switch coinType{
            case .Gold:
                coinTexture = SKTexture(image: #imageLiteral(resourceName: "gold_1"))
                break
            case .Silver:
                coinTexture = SKTexture(image: #imageLiteral(resourceName: "silver_1"))
                break
            case .Bronze:
                coinTexture = SKTexture(image: #imageLiteral(resourceName: "bronze_1"))
                break
        }
        
        return coinTexture
    }
    
    static func getCoinAnimationFor(coinType: CoinType, forAnimationKey: String) -> String{
        
        var coinAnimationName: String = String()
        
        switch coinType{
            case .Gold:
                coinAnimationName = "goldAnimation"
                break
            case .Silver:
                coinAnimationName = "silverAnimation"
                break
            case .Bronze:
                coinAnimationName = "bronzeAnimation"
                break
        }
        
        return coinAnimationName
    }
    
}
