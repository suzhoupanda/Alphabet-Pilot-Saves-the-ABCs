//
//  LetterC_Scene.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/16/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class LetterC_Scene: BaseScene{
    
    convenience init(size: CGSize){
        
        self.init(sksFileName: "PlaneScene1", size: size)
    }
    
    required init(sksFileName: String, size: CGSize) {
        super.init(sksFileName: sksFileName, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
