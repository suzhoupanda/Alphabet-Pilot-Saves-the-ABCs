//
//  AlienAttackState.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/2/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit


class AlienAttackState: GKState{
    
    /** Get a reference to the alien entity and its target node
 
    **/
    
    unowned let alienEntity: Alien
    var targetNode: SKSpriteNode?
    
    /** Get a reference to the obstacles graph for the scene to which the alien entity's render node has been added
 
     **/
    var obstacleGraph: GKObstacleGraph<GKGraphNode2D>? {
        get{
            
            if let scene = alienEntity.component(ofType: RenderComponent.self)?.node.scene as? BaseScene{
                
                return scene.obstacleGraph
            }
            
            return nil
        }
    }
    
    
    init(alienEntity: Alien){
        
        self.alienEntity = alienEntity
        super.init()
        
    }
    
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        
        //If the target node is set to nil (because of a notification sent to the TargetNode component, then the statemachine returns the enemy back to the inactive state
        
        if let targetDetectionComponent = alienEntity.component(ofType: TargetDetectionComponent.self){
            
            if targetDetectionComponent.playerHasLeftProximity{
                
                stateMachine?.enter(AlienActiveState.self)
                
                /** Get reference to the alien's render node in order to successively run moveTo actions that move the alien along the path leading to the target from the alien
                 
                **/
            } else if let node = alienEntity.component(ofType: RenderComponent.self)?.node {
                //node.lerpToPoint(targetPoint: targetNodeComponent.targetNode.position, withLerpFactor: 0.05)
                
                
                /** Get references to the graph nodes for the target (i.e. the player) and the start point (i.e. the current position of the alien enemy) for pathfinding algorithms
                **/
                
                guard let targetGraphNode = targetDetectionComponent.targetNode.entity?.component(ofType: GraphNodeComponent.self)?.graphNode else {
                    print("Error: graph node for target i.e. the player must be available in order to perform pathfinding")
                    return
                }
                
                
                guard let startGraphNode = alienEntity.component(ofType: GraphNodeComponent.self)?.graphNode else {
                    print("Error: graph node for the starting point i.e. the alien must be available in order to perform pathfinding")
                    return
                }
                
                
                
                guard let obstacleGraph = obstacleGraph else {
                    print("Error: obstacle graph from the base scene must be available in order to perform pathfinding")
                    return
                }
                
                /** Connect both the starting graph node and target graph node to the obstacle graph in order to perform pathfinding
                **/
                
        
                obstacleGraph.connectUsingObstacles(node: startGraphNode)
                obstacleGraph.connectUsingObstacles(node: targetGraphNode)
                
                
                
                let attackPath = obstacleGraph.findPath(from: startGraphNode, to: targetGraphNode)
                
                for graphNode in attackPath{
                    
                    let graphNode = graphNode as! GKGraphNode2D
                    
                    
                    let nextPoint = graphNode.getCGPointFromGraphNodeCoordinates()
                    let moveToNextPointAction = SKAction.move(to: nextPoint, duration: 2.00)
                    
                    node.run(moveToNextPointAction)
                }
                
                obstacleGraph.remove([startGraphNode,targetGraphNode])
                
                
                
                
                
            }
            
        }
        
    }
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        
        guard let animationComponent = alienEntity.component(ofType: BasicAnimationComponent.self) else {
            print("Error: failed to load the animation component while entering \(stateMachine?.currentState) from the \(previousState)")
            return
        }
        
        //Run any attack mode animations
        
        animationComponent.runAnimation(withAnimationNameOf: "attack", andWithAnimationKeyOf: "attackAnimation", repeatForever: true)
        
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        super.isValidNextState(stateClass)
        
        switch(stateClass){
            case is AlienActiveState.Type, is AlienInactiveState.Type:
                return true
            default:
                return false
            }
    }
    
    
    
    
   
    
}


extension GKGraphNode2D{
    
    func getCGPointFromGraphNodeCoordinates() -> CGPoint{
        
        let xPos = CGFloat(self.position.x)
        let yPos = CGFloat(self.position.y)
        
        return CGPoint(x: xPos, y: yPos)
    }
    
}

