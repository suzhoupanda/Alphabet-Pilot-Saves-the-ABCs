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
        
        /**
        guard let scene = SceneFileCacheHelper.sharedHelper.getScene(forLetterScene: self.letterScene) else {
            
            fatalError("Error: failed to retrieve the SKS file from the dictionary cache")
        }
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
        initializeObstacleGraph(rootNode: rootNode)
        
        
        /**  Loop through all the child nodes of the root node, and if the placeholder node name contains specific keyword names, add letters, enemies, etc.
         
         **/
        
        
        for node in rootNode.children{
            addEnemy(node: node)
            addCollectibles(node: node)
            addLetterEntity(node: node)
            
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
        
        var obstacleNodes = [SKNode]()
        
        for node in rootNode.children{
            
            if let node = node as? SKSpriteNode, let nodeName = node.name{
                
                if nodeName.contains("Barrier/") && nodeName.contains("Spike"){
                    obstacleNodes.append(node)
                }
                
            }
        }
        
        let obstacleGraphNodes = SKNode.obstacles(fromNodeBounds: obstacleNodes)
        
        
        obstacleGraph = GKObstacleGraph(obstacles: obstacleGraphNodes, bufferRadius: 10.00)
        
        
        
    }
    
    func addCollectibles(node: SKNode){
        if let nodeName = node.name,nodeName.contains("Coin/"){
            
            let positionValue = node.userData?.value(forKey: "position") as! NSValue
            let position = positionValue.cgPointValue
            
            if nodeName.contains("Gold"){
               
                let coin = Coin(coinType: .Gold, position: position, nodeName: "coin/gold/\(position)", scalingFactor: 1.00)
                entityManager.addToWorld(coin)
                
                }
            
            if nodeName.contains("Silver"){
                let coin = Coin(coinType: .Silver, position: position, nodeName: "coin/silver/\(position)", scalingFactor: 1.00)
                entityManager.addToWorld(coin)
                
            }
            
            if nodeName.contains("Bronze"){
                let coin = Coin(coinType: .Bronze, position: position, nodeName: "coin/bronze/\(position)", scalingFactor: 1.00)
                entityManager.addToWorld(coin)
                
            }
        }
    }
    
    func addEnemy(node: SKNode){
        /**
        if let nodeName = node.name, nodeName.contains("Barrier/HasEnemy"){
            let targetNode = player.renderComponent.node

            if let node = node.childNode(withName: "Enemy/LaserGun/Bottom"){
                let positionValue = node.userData?.value(forKey: "position") as! NSValue
                let position = positionValue.cgPointValue
                
                let laserGun = LaserGun(laserGunOrientation: .Bottom, position: position, nodeName: "laserGun\(position)", targetNode: targetNode, proximityDistance: 300.00, scalingFactor: 1.00)
                entityManager.addToWorld(laserGun)
            
            }
            
            if let node = node.childNode(withName: "Enemy/LaserGun/Top"){
                let positionValue = node.userData?.value(forKey: "position") as! NSValue
                let position = positionValue.cgPointValue
                
                let laserGun = LaserGun(laserGunOrientation: .Top, position: position, nodeName: "laserGun\(position)", targetNode: targetNode, proximityDistance: 300.00, scalingFactor: 1.00)
                entityManager.addToWorld(laserGun)
                
            }
            
            if let node = node.childNode(withName: "Enemy/LaserGun/Left"){
                let positionValue = node.userData?.value(forKey: "position") as! NSValue
                let position = positionValue.cgPointValue
                
                let laserGun = LaserGun(laserGunOrientation: .Left, position: position, nodeName: "laserGun\(position)", targetNode: targetNode, proximityDistance: 300.00, scalingFactor: 1.00)
                entityManager.addToWorld(laserGun)
                
            }
        }
        **/
        
        
       
        if let nodeName = node.name,nodeName.contains("RockGenerator/"){

            let targetNode = player.renderComponent.node
            
            if nodeName.contains("Stone/"){
                
                let rockSize: FallingRock.RockSize = nodeName.contains("Large") ? .Large: .Small
                
                
                let rockGenerator = RockGenerator(rockType: .Stone, rockSize: rockSize, position: position, nodeName: "rockGenerator\(position)", targetNode: targetNode, proximityDistance: 500.00, scalingFactor: 1.00)
                
                entityManager.addToWorld(rockGenerator)
                
                print("Added a \(rockSize) stone rock to the world")
            }
            
            if nodeName.contains("Dirt/"){
                let rockSize: FallingRock.RockSize = nodeName.contains("Large") ? .Large: .Small
                
                let rockGenerator = RockGenerator(rockType: .Dirt, rockSize: rockSize, position: position, nodeName: "rockGenerator\(position)", targetNode: targetNode, proximityDistance: 500.00, scalingFactor: 1.00)
                
                entityManager.addToWorld(rockGenerator)
                
                print("Added a \(rockSize) stone rock to the world")
                
            }
        }
        

        
        
        if let nodeName = node.name,nodeName.contains("Enemy/"){
            
            let positionValue = node.userData?.value(forKey: "position") as! NSValue
            let position = positionValue.cgPointValue
            
            
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
                    
                    let alien = Alien(alienColor: alienColor, position: position, nodeName: "alien\(position)", targetNode: targetNode, minimumProximityDistance: 200.0, scalingFactor: 0.50)
                    entityManager.addToWorld(alien)
                    
                    
                }
                
            

        
            
            if nodeName.contains("Spikeman"){
                let spikeman = Spikeman(position: position, nodeName: "spikeman\(position)", horizontalVelocity: -80, scalingFactor: 1.00)
                
                entityManager.addToWorld(spikeman)
            }
            
            
            if nodeName.contains("Barnacle"){
                
                let barnacleOrientation: Barnacle.BarnacleOrientation = nodeName.contains("Up") ? .Up : .Down
                
                let barnacle = Barnacle(barnacleOrientation: barnacleOrientation, position: position, nodeName: "barnacle\(position)",scalingFactor: 0.90)
                
                entityManager.addToWorld(barnacle)
            }
            
            
            if nodeName.contains("Worm"){
                
                let wormColor: Worm.WormColor = nodeName.contains("Green") ? .Green : .Pink
                
                let worm = Worm(wormColor: wormColor, position: position, nodeName: "worm\(position)", horizontalVelocity: nil, scalingFactor: 0.90)
                
                entityManager.addToWorld(worm)
            }
            
            
            if nodeName.contains("Blockman"){
                
                let blockmanType: BlockMan.BlockType = nodeName.contains("Slime") ? .Slime : .Grass
                
                let blockman = BlockMan(blockType: blockmanType, position: position, nodeName: "blockman\(position)", scalingFactor: 0.90)
                entityManager.addToWorld(blockman)
            }
            
            if nodeName.contains("Bomb"){
                let bomb = Bomb(position: position, nodeName: "bomb\(position)", scalingFactor: 0.90)
                
                entityManager.addToWorld(bomb)
            }
            
            if nodeName.contains("BladeIsland"){
                let targetNode = player.renderComponent.node
            
                let bladeIsland = BladeIsland(position: position, nodeName: "bladeIsland\(position)", targetNode: targetNode, minimumProximityDistance: 300.0, scalingFactor: 1.0)
                entityManager.addToWorld(bladeIsland)
            }
            
            if nodeName.contains("LaserGun"){
                let targetNode = player.renderComponent.node
                
                if nodeName.contains("Left"){
                    let laserGun = LaserGun(laserGunOrientation: .Left, position: position, nodeName: "laserGun\(position)", targetNode: targetNode, proximityDistance: 300.0, bulletSpeed: 200.0, bulletColor: .Blue, scalingFactor: 1.00)
                    entityManager.addToWorld(laserGun)
                }
                
                if nodeName.contains("Top"){
                     let laserGun = LaserGun(laserGunOrientation: .Top, position: position, nodeName: "laserGun\(position)", targetNode: targetNode, proximityDistance: 300.0, bulletSpeed: 200.0, bulletColor: .Blue, scalingFactor: 1.00)
                    entityManager.addToWorld(laserGun)
                }
                
                if nodeName.contains("Bottom"){
                     let laserGun = LaserGun(laserGunOrientation: .Bottom, position: position, nodeName: "laserGun\(position)", targetNode: targetNode, proximityDistance: 300.0, bulletSpeed: 200.0, bulletColor: .Blue, scalingFactor: 1.00)
                    entityManager.addToWorld(laserGun)
                }
                
            }
            
            if nodeName.contains("Bee"){
                
                let targetNode = player.renderComponent.node

                var bee: Bee = Bee(position: position, nodeName: "bee\(position)", targetNode: targetNode, minimumProximityDistance: 300.00, scalingFactor: 0.50)
                
                if nodeName.contains("Queen"){
                    bee =  Bee(position: position, nodeName: "bee\(position)", targetNode: targetNode, minimumProximityDistance: 100.0, scalingFactor: 1.4)
                    
                }
                
                
                if nodeName.contains("King"){
                    bee =  Bee(position: position, nodeName: "bee\(position)", targetNode: targetNode, minimumProximityDistance: 200.0, scalingFactor: 1.0)
                    
                }
                
                if nodeName.contains("Prince"){
                    bee =  Bee(position: position, nodeName: "bee\(position)", targetNode: targetNode, minimumProximityDistance: 250.0, scalingFactor: 0.8)
                    
                }
                
               
                entityManager.addToWorld(bee)
                
            }
            
            if nodeName.contains("Fly"){
            
                let fly = Fly(position: position, nodeName: "fly\(position)", scalingFactor: 0.60)
                entityManager.addToWorld(fly)
                
            }
            
        
            if nodeName.contains("Spikeball"){
                
                let spikeball = Spikeball(position: position, nodeName: "spikeball\(position)", scalingFactor: 0.80)
                entityManager.addToWorld(spikeball)
                
            }
            
            if nodeName.contains("EvilSun"){
                
                let evilSun = EvilSun(position: position, nodeName: "evilSun\(position)", scalingFactor: 0.80)
                
                if let renderNode = evilSun.component(ofType: RenderComponent.self)?.node,let fireNode = SKScene(fileNamed: "Fire.sks"), nodeName.contains("Fire"){
                    
                    renderNode.xScale *= 0.5
                    renderNode.yScale *= 0.5
                    
                    renderNode.addChild(fireNode)
                    fireNode.position = .zero
                    fireNode.zPosition = -3
                    
                   

                }
                
                entityManager.addToWorld(evilSun)
                
               
 
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
