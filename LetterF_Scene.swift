//
//  LetterF_Scene.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/16/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class LetterF_Scene: BaseScene{
    
    convenience init(size: CGSize, reloadData: ReloadData?){
        
        self.init(sksFileName: "SpaceScene2", size: size, reloadData: reloadData)
    }
    
    required init(sksFileName: String, size: CGSize, reloadData: ReloadData?) {
        super.init(sksFileName: sksFileName, size: size, reloadData: reloadData)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        
        letterScene = .LetterF_Scene
        sceneLetterTarget = "F"
    }
    

}
