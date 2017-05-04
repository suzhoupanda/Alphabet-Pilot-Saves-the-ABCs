//
//  EnemyAttackState.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/3/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class EnemyAttackState: GKState{
    
    
    let enemyEntity: Enemy
    var targetNode: SKSpriteNode?
    
    /** Get a reference to the obstacles graph for the scene to which the alien entity's render node has been added
     
     **/
    var obstacleGraph: GKObstacleGraph<GKGraphNode2D>? {
        get{
            
            if let scene = enemyEntity.component(ofType: RenderComponent.self)?.node.scene as? BaseScene{
                
                return scene.obstacleGraph
            }
            
            return nil
        }
    }
    
    
    
    init(enemyEntity: Enemy){
        
        self.enemyEntity = enemyEntity
        super.init()
        
    }
    
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        
        //If the target node is set to nil (because of a notification sent to the TargetNode component, then the statemachine returns the enemy back to the inactive state
        
        if let targetDetectionComponent = enemyEntity.component(ofType: TargetDetectionComponent.self){
            
            if targetDetectionComponent.playerHasLeftProximity{
                
                stateMachine?.enter(EnemyActiveState.self)
                
                /** Get reference to the alien's render node in order to successively run moveTo actions that move the alien along the path leading to the target from the alien
                 
                 **/
            } else if let node = enemyEntity.component(ofType: RenderComponent.self)?.node {
              
                
                /** Get references to the graph nodes for the target (i.e. the player) and the start point (i.e. the current position of the alien enemy) for pathfinding algorithms
                 **/
                
                guard let targetGraphNode = targetDetectionComponent.targetNode.entity?.component(ofType: GraphNodeComponent.self)?.graphNode else {
                    print("Error: graph node for target i.e. the player must be available in order to perform pathfinding")
                    return
                }
                
                
                guard let startGraphNode = enemyEntity.component(ofType: GraphNodeComponent.self)?.graphNode else {
                    print("Error: graph node for the starting point i.e. the alien must be available in order to perform pathfinding")
                    return
                }
                
                
                
                guard let obstacleGraph = obstacleGraph else {
                    print("Error: obstacle graph from the base scene must be available in order to perform pathfinding")
                    return
                }
                
                /** Connect both the starting graph node and target graph node to the obstacle graph in order to perform pathfinding
                 **/
                
                print("Connecting start and end nodes to obstacle graph...")
                
                obstacleGraph.connectUsingObstacles(node: startGraphNode)
                obstacleGraph.connectUsingObstacles(node: targetGraphNode)
                
                
                
                print("Determining attack path...")
                
                let attackPath = obstacleGraph.findPath(from: startGraphNode, to: targetGraphNode)
                
                for graphNode in attackPath{
                    
                    let graphNode = graphNode as! GKGraphNode2D
                    
                    let nextPoint = graphNode.getCGPointFromGraphNodeCoordinates()
                    let moveToNextPointAction = SKAction.move(to: nextPoint, duration: 1.00)
                    
                    print("Executing move to next point in path..")
                    node.run(moveToNextPointAction)
                }
                
                obstacleGraph.remove([startGraphNode,targetGraphNode])
                
                
                
                
                
            }
            
        }
        
    }
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        
       
        
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        super.isValidNextState(stateClass)
        
        switch(stateClass){
        case is EnemyActiveState.Type, is EnemyInactiveState.Type:
            return true
        default:
            return false
        }
    }
    
    
    /**  If the alien contacts the player, send a notification so that alien is forced to transition back to the inactive state and  pathfinding is suspended.
     
     **/
    
 
   
    
}

