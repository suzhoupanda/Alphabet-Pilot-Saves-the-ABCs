//
//  LetterA_Scene.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/15/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//


import Foundation
import SpriteKit
import GameplayKit

class LetterA_Scene: BaseScene{
    
    /**
    let alienSpawnPositions: [CGPoint] = [
        CGPoint(x: 500, y: 0),
        CGPoint(x: 1000, y: 0),
        CGPoint(x: 2000, y: 0),
        CGPoint(x: 2500, y: 0),
        CGPoint(x: 3000, y: 0),
        CGPoint(x: 3500, y: 0),
        CGPoint(x: 4000, y: 0),
        CGPoint(x: 4500, y: 0),
        CGPoint(x: 5000, y: 0),
        CGPoint(x: 5500, y: 0),
        CGPoint(x: 6000, y: 0),
        CGPoint(x: 6500, y: 0),
        CGPoint(x: 7000, y: 0)
    ]
    **/
    
    var alienSpawnInterval: TimeInterval = 5.00
    var frameCount: TimeInterval = 0.00
    var adjustedLastUpdateTime: TimeInterval = 0.00
    
    convenience init(size: CGSize, reloadData: ReloadData?){
        
        self.init(sksFileName: "SpaceScene1", size: size, reloadData: reloadData)
    }
    
    required init(sksFileName: String, size: CGSize, reloadData: ReloadData?) {
        super.init(sksFileName: sksFileName, size: size, reloadData: reloadData)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func didMove(to view: SKView) {
        
        //Preload animal texture atlas as well as any background music
        Alien.loadResources(){
            print("Animal texture atlas loaded")
        }
        
        super.didMove(to: view)
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        /** Optional: spawn alien enemies ahead of the player at regular intervals **/
        
        /**
        frameCount += currentTime - adjustedLastUpdateTime
        
        if frameCount > alienSpawnInterval{
            
            let playerNode = player.renderComponent.node
            
            let playerPosition = playerNode.position
            
            
            let randomDistribution = GKGaussianDistribution(randomSource: GKRandomSource(), mean: 0.00, deviation: 500.00)
            
            let randomYOffset = Double(randomDistribution.nextUniform())
            
            let alienPosition = CGPoint(x: Double(playerPosition.x) + 1000.00, y: Double(playerPosition.y) + randomYOffset)
            
            let alien = Alien(alienColor: .Pink, position: alienPosition, nodeName: "alien\(alienPosition)", targetNode: playerNode, minimumProximityDistance: 200.00, scalingFactor: 0.70)
            
            entityManager.addToWorld(alien)
            
            frameCount = 0
        }
        
        adjustedLastUpdateTime = currentTime
 
        **/
    }
    
    /**
    override func addEnemy(node: SKNode) {
        super.addEnemy(node: node)
        
        for position in alienSpawnPositions{
            
            let targetNode = player.renderComponent.node
            
            let alien = Alien(alienColor: .Pink, position: position, nodeName: "alien\(position)", targetNode: targetNode, minimumProximityDistance: 200.0, scalingFactor: 0.50)
            entityManager.addToWorld(alien)
            
        }
    }
 
    **/
    
    /** Letter E Scene features "Elephant" enemy **/
    
    /**
    override func addEnemy(node: SKNode) {
        super.addEnemy(node: node)
        
        guard let positionVal = node.userData?["position"] as? NSValue else {
            print("Error: failed to retrieve position data from enemy node user data dictionaries")
            return
        }
        
        let cgPointPosition = positionVal.cgPointValue
        
        if let nodeName = node.name,nodeName.contains("Enemy/"){
            
            if nodeName.contains("Alien/"){
                

                var alienColor: Alien.AlienColor = .Pink
                
                if nodeName.contains("Beige"){
                    alienColor = .Beige
                }
                
                if nodeName.contains("Yellow"){
                    alienColor = .Yellow
                }
                
                if nodeName.contains("Blue"){
                    alienColor = .Blue
                }
                
                if nodeName.contains("Pink"){
                    alienColor = .Pink
                }
                
                let targetNode = player.renderComponent.node
                
                let alien = Alien(alienColor: alienColor, position: cgPointPosition, nodeName: "alien\(position)", targetNode: targetNode, minimumProximityDistance: 200.0, scalingFactor: 0.50)
                entityManager.addToWorld(alien)
                
                
            }
        
        }
 
    }
    **/
}
