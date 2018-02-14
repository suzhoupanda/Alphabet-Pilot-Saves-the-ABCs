//
//  LetterL_Scene.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/16/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class LetterL_Scene: BaseScene{
    
    convenience init(size: CGSize, reloadData: ReloadData?){
        
        self.init(sksFileName: "ForestScene3", size: size, reloadData: reloadData)
    }
    
    required init(sksFileName: String, size: CGSize, reloadData: ReloadData?) {
        super.init(sksFileName: sksFileName, size: size, reloadData: reloadData)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        letterScene = .LetterL_Scene
        sceneLetterTarget = "L"
    }
    
    override func addEnemy(node: SKNode) {
        super.addEnemy(node: node)
        
        let positionValue = node.userData?.value(forKey: "position") as! NSValue
        let position = positionValue.cgPointValue
        
        if let nodeName = node.name,nodeName.contains("Enemy/"){
            
            if nodeName.contains("Animal/"){
                
                if nodeName.contains("Panda"){
                    
                    let panda = Animal(animalType: .Panda, position: position, nodeName: "panda\(position)", scalingFactor: 0.50)
                    
                    entityManager.addToWorld(panda)
                }
            }
        }
        
    }
}
