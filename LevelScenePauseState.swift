//
//  LevelScenePauseState.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/1/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class LevelScenePauseState: GKState{
    
    let levelScene: BaseScene
    
    init(levelScene: BaseScene){
        self.levelScene = levelScene
    }
}
