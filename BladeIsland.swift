//
//  BladeIsland.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/4/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit


class BladeIsland: Enemy{
    
    
    /** Initializer for an enemy that uses a target node component to detect player proximity; doesn't rely on pathfinding algorithms to move around obstalces, and doesn't rely on the agent/goal simulation from GameplayKit **/
    
    convenience init(position: CGPoint, nodeName: String, targetNode: SKSpriteNode, minimumProximityDistance: Double, scalingFactor: CGFloat?) {
        self.init()
        
        
        
        
        //The node for the blade island is loaded from the appropriate sks file
        guard let node = SKScene(fileNamed: "BladeIsland")?.childNode(withName: "BladeIslandCake") as? SKSpriteNode, let spinnerNode = node.childNode(withName: "Spinner") as? SKSpriteNode, let nodeTexture = node.texture, let spinnerTexture = spinnerNode.texture else {
            fatalError("Error: failed to load the node for blade island from the appropriate SKS file")
        }
        
        
        
        node.position = position
        node.name = nodeName
        
        let renderComponent = RenderComponent(spriteNode: node)
        addComponent(renderComponent)
        
        let graphNodeComponent = GraphNodeComponent(cgPosition: position)
        addComponent(graphNodeComponent)
        
        
        //Physics properites are configured in the scene file
      
        
        //Initialize the animation component by combining the pre-configured animations dict with a new dictionary whose actions are dynamically determined based on starting position
        
        let turnAnimation = SKAction.animate(with: [
            SKTexture(image: #imageLiteral(resourceName: "spinnerHalf")),
            SKTexture(image: #imageLiteral(resourceName: "spinnerHalf_spin"))
            ], timePerFrame: 0.10)
        
        let combinedDict = [["turnAnimation": turnAnimation], BladeIsland.AnimationsDict]
        
        var animationsDict = [String: SKAction]()
        
        for dict in combinedDict{
            for (key,value) in dict{
                animationsDict[key] = value
            }
        }
        
        let animationComponent = BasicAnimationComponent(animationsDict: animationsDict)
        addComponent(animationComponent)
        animationComponent.runAnimation(withAnimationNameOf:"turnAnimation", andWithAnimationKeyOf: "turnAnimation", onChildNodeWithName: "Spinner", repeatForever: true)
        
        //The target node argument is used to initialize the target detection component; typically, the player node is passed in as an argument for the target detection component to provide a target for pathfinding, smart enemies
        
        let targetDetectonComponent = TargetDetectionComponent(targetNode: targetNode, proximityDistance: minimumProximityDistance)
        addComponent(targetDetectonComponent)
        
        
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
