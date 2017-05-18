//
//  LetterE_Scene.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/15/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit

class LetterE_Scene: BaseScene{
    
    
    convenience init(size: CGSize, reloadData: ReloadData?){
        
        self.init(sksFileName: "CandyScene4", size: size, reloadData: reloadData)
    }
    
    required init(sksFileName: String, size: CGSize, reloadData: ReloadData?) {
        super.init(sksFileName: sksFileName, size: size, reloadData: reloadData)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    override func didMove(to view: SKView) {
        
        //Preload animal texture atlas as well as any background music
        Animal.loadResources(){
            print("Animal texture atlas loaded")
        }
        
        super.didMove(to: view)
    }
    

    
    /** Letter E Scene features "Elephant" enemy **/
    
    override func addEnemy(node: SKNode) {
        super.addEnemy(node: node)
        
        let positionValue = node.userData?.value(forKey: "position") as! NSValue
        let position = positionValue.cgPointValue
        
        if let nodeName = node.name,nodeName.contains("Enemy/"){

            if nodeName.contains("Animal/"){
            
                if nodeName.contains("Elephant"){
                
                    let elephant = Animal(animalType: .Elephant, position: position, nodeName: "elephant\(position)", scalingFactor: 0.20)
                
                    entityManager.addToWorld(elephant)
                }
            }
        }
        
    }
}


