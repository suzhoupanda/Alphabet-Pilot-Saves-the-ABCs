//
//  LetterA_Scene.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/15/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//


import Foundation
import SpriteKit

class LetterA_Scene: BaseScene{
    
    var alienSpawnInterval: TimeInterval = 1.00
    var frameCount: TimeInterval = 0.00
    var adjustedLastUpdateTime: TimeInterval = 0.00
    
    convenience init(size: CGSize){
        
        self.init(sksFileName: "SpaceScene1", size: size)
    }
    
    required init(sksFileName: String, size: CGSize) {
        super.init(sksFileName: sksFileName, size: size)
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
        
        frameCount += currentTime - adjustedLastUpdateTime
        
        print("FrameCount: \(frameCount)")
        
        if frameCount > alienSpawnInterval{
            
            let playerNode = player.renderComponent.node
            
            let playerPosition = playerNode.position
            
            let alienPosition = CGPoint(x: playerPosition.x + 500.00, y: playerPosition.y)
            
            let alien = Alien(alienColor: .Pink, position: alienPosition, nodeName: "alien\(alienPosition)", targetNode: playerNode, minimumProximityDistance: 200.00, scalingFactor: 0.70)
            
            guard let alienRenderNode = alien.component(ofType: RenderComponent.self)?.node else {
                    print("Error: failed to load alien render node")
                    return
            }
            
            
            entityManager.addToWorld(alien)
            
            frameCount = 0
        }
        
        adjustedLastUpdateTime = currentTime
    }
    
    /** Letter E Scene features "Elephant" enemy **/
    
    override func addEnemy(node: SKNode) {
        super.addEnemy(node: node)
        
        let positionValue = node.userData?.value(forKey: "position") as! NSValue
        let position = positionValue.cgPointValue
        
        if let nodeName = node.name,nodeName.contains("Enemy/"){
            
            if nodeName.contains("Alien"){
                
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
                
                let alien = Alien(alienColor: alienColor, position: position, nodeName: "alien\(position)", targetNode: targetNode, minimumProximityDistance: 200.0, scalingFactor: 0.50)
                entityManager.addToWorld(alien)
                
                
            }
        
        }
    }
}
