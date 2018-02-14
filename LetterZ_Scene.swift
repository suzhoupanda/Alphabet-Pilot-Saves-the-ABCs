//
//  LetterZ_Scene.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/16/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class LetterZ_Scene: BaseScene{
    
    convenience init(size: CGSize, reloadData: ReloadData?){
        
        self.init(sksFileName: "PlaneScene3", size: size, reloadData: reloadData)
    }
    
    required init(sksFileName: String, size: CGSize, reloadData: ReloadData?) {
        super.init(sksFileName: sksFileName, size: size, reloadData: reloadData)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addEnemy(node: SKNode) {
        super.addEnemy(node: node)
        
        let positionValue = node.userData?.value(forKey: "position") as! NSValue
        let position = positionValue.cgPointValue
        
        if let nodeName = node.name,nodeName.contains("Enemy/"){
            
            if nodeName.contains("Animal/"){
                
                if nodeName.contains("Hippo"){
                    
                    let hippo = Animal(animalType: .Hippo, position: position, nodeName: "hippo\(position)", scalingFactor: 0.50)
                    
                    entityManager.addToWorld(hippo)
                }
                
                if nodeName.contains("Giraffe"){
                    
                    let giraffe = Animal(animalType: .Giraffe, position: position, nodeName: "giraffe\(position)", scalingFactor: 0.50)
                    
                    entityManager.addToWorld(giraffe)
                }
                
                if nodeName.contains("Parrot"){
                    
                    let parrot = Animal(animalType: .Parrot, position: position, nodeName: "parrot\(position)", scalingFactor: 0.50)
                    
                    entityManager.addToWorld(parrot)
                }
                
                
                if nodeName.contains("Pig"){
                    
                    let parrot = Animal(animalType: .Pig, position: position, nodeName: "pig\(position)", scalingFactor: 0.50)
                    
                    entityManager.addToWorld(parrot)
                }
                
                if nodeName.contains("Panda"){
                    
                    let panda = Animal(animalType: .Panda, position: position, nodeName: "panda\(position)", scalingFactor: 0.50)
                    
                    entityManager.addToWorld(panda)
                }
                
                if nodeName.contains("Monkey"){
                    
                    let monkey = Animal(animalType: .Monkey, position: position, nodeName: "monkey\(position)", scalingFactor: 0.50)
                    
                    entityManager.addToWorld(monkey)
                }

                if nodeName.contains("Penguin"){
                    
                    let penguin = Animal(animalType: .Penguin, position: position, nodeName: "penguin\(position)", scalingFactor: 0.50)
                    
                    entityManager.addToWorld(penguin)
                }
                
                if nodeName.contains("Elephant"){
                    
                    let elephant = Animal(animalType: .Elephant, position: position, nodeName: "elephant\(position)", scalingFactor: 0.50)
                    
                    entityManager.addToWorld(elephant)
                }

                
            }
        }
        
    }

    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        letterScene = .LetterZ_Scene
        sceneLetterTarget = "Z"
    }
}
