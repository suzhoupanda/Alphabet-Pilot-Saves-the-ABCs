//
//  BaseScene+SpriteLoader.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/1/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//


import Foundation
import SpriteKit
import GameplayKit

extension BaseScene{
    
    func loadNodesFromSKSceneFile(){
        
        /** Get the root node for the sks file or else crash the app
         **/
        guard let rootNode = SKScene(fileNamed: skSceneFileName)?.childNode(withName: "RootNode") else {
            fatalError("Error: the SKS file must have a root node in order to be loaded into the present scene")
        }
        
        
        /** Loop through each node in the SKS file, and save each node's position in its user dictionary.  Position data for placeholder nodes is used to initialize new entities
         
         **/
        saveSpriteInformation(rootNode: rootNode)
        
        /** Move the root node from the sks file to the world node of the current scene **/
        
        rootNode.move(toParent: worldNode)
        
        
        /** Loop through all the nodes and initialize a GKObstacleGraph with polygons corresponding to non-navigable objects (e.g. islands) in the scene
         
         **/
        
        //initializePlaceholderGraph(rootNode: rootNode)
        //initializeObstacleGraph(rootNode: rootNode)
        
        
        /**  Loop through all the child nodes of the root node, and if the placeholder node name contains specific keyword names, add letters, enemies, etc.
         
         **/
        
        
        for node in rootNode.children{
            if var node = node as? SKNode{
                

                addEnemy(node: node)
                addLetterEntity(node: node)
            }
        }
        
        
        
        
        
    }
    
    
    func initializePlaceholderGraph(rootNode: SKNode){
        /**
        var graphNodes = [GKGraphNode2D]()
        
        print("Initializing placeholder graph...")
        
        for node in rootNode.children{
            if node.name == "GraphNode"{
                let positionVal = node.userData?.value(forKey: "position") as! NSValue
                let graphNodePos = positionVal.cgPointValue
                
                let vfPosition = graphNodePos.getVectorFloat2()
                let graphNode = GKGraphNode2D(point: vfPosition)
                graphNodes.append(graphNode)
                print("Added another graphNode...")
            }
            
        }
        
        placeholderGraph = GKMeshGraph(nodes: graphNodes)
        print("placeholder graph initialized")
        **/
        
    }
    
    func initializeObstacleGraph(rootNode: SKNode){
        /**
        var obstacleNodes = [SKNode]()
        
        for node in rootNode.children{
            
            if let node = node as? SKSpriteNode, node.name == "Island"{
                obstacleNodes.append(node)
                
            }
        }
        
        let obstacleGraphNodes = SKNode.obstacles(fromNodeBounds: obstacleNodes)
        
        
        obstacleGraph = GKObstacleGraph(obstacles: obstacleGraphNodes, bufferRadius: 20.00)
        
        **/
        
    }
    
    func addEnemy(node: SKNode){
        if let nodeName = node.name,nodeName.contains("Enemy/"){
            
            if nodeName.contains("BladeIsland"){
                print("Adding a blade island based on placeholder position...")
                
            }
            
            
            if nodeName.contains("Alien"){
                print("Adding an alien to the scene")
              
                
            }
        }
    }
    
    
    
    
    func addLetterEntity(node: SKNode){
        
        if let nodeName = node.name, nodeName.contains("Letter/"){
            
            /** Get the letter character from the node name **/
            let letterIndex = nodeName.index(before: nodeName.characters.endIndex)
            let letterString = nodeName.substring(from: letterIndex)
            
            /** Get node position info from node's userData **/
            let positionVal = node.userData?.value(forKey: "position") as! NSValue
            let position = positionVal.cgPointValue
            
            /**  Initialize a new letter entity based on the character in the node name and the
             position from the userData dict **/
            
            var baseString = "letter"
            baseString.append(letterString)
            
            guard let letterCategory = LetterNode.LetterCategory(rawValue: baseString) else {
                print("Error: Failed to initialize a letter cateogry")
                return
            }
            
            /** Initialize a new letter entity from the letter category and position information **/
            let letterEntity = Letter(letterCategory: letterCategory, position: position, letterMass: 0.1)
            
            /** Add the letter entity to the entity manager **/
            entityManager.addToWorld(letterEntity)
            
            
        }
    }
}
