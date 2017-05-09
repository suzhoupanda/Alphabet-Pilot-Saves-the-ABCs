//
//  SceneLoaderPreparingResourcesState.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/9/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//


import Foundation
import GameplayKit

class SceneLoaderPreparingResourcesState: GKState{
    
    //MARK: Properties
    
    unowned let sceneLoader: SceneLoader
    
    
    var operationQueue: OperationQueue!
    
    //MARK: Initialization
    
    init(sceneLoader: SceneLoader){
        self.sceneLoader = sceneLoader
    }
}
