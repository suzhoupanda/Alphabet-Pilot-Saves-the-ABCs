//
//  TargetDetectionComponent.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/2/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//


import Foundation
import GameplayKit
import SpriteKit


/** The target detection component tests for whether or not the player or other target has entered its proximity, as defined by a minimum proximity distance
 
 
 **/

class TargetDetectionComponent: GKComponent{
    
    
    var targetNode: SKSpriteNode
    
    var renderNode: SKSpriteNode?
    
    var proximityDistance: Double
    var playerHasEnteredProximity: Bool = false
    var playerHasLeftProximity: Bool = true
    
    init(targetNode: SKSpriteNode, proximityDistance: Double){
        self.targetNode = targetNode
        self.proximityDistance = proximityDistance
        
        
        
        super.init()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didAddToEntity() {
        renderNode = entity?.component(ofType: RenderComponent.self)?.node
    }
    
    override func willRemoveFromEntity() {
        renderNode = nil
        
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        
        guard let renderNode = self.renderNode else {
            print("The enemy must have a render node in order to test for player proximity")
            return }
        
        
        if  playerHasLeftProximity && renderNode.position.getDistanceToPoint(otherPoint: targetNode.position) < proximityDistance{
            print("Enemy has enetered the proximity zone...")
            
            self.playerHasEnteredProximity = true
            playerHasLeftProximity = false
        }
        
        if playerHasEnteredProximity && renderNode.position.getDistanceToPoint(otherPoint: targetNode.position) > proximityDistance{
            
            print("Enemy has left the proximity zone...")
            playerHasEnteredProximity = false
            playerHasLeftProximity = true
        }
        
    }
    
    
    
}
