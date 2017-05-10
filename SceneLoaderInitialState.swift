//
//  SceneLoaderInitialState.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/9/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//


import Foundation
import GameplayKit

class SceneLoaderInitialState: GKState{
    
    //MARK: Properties
    
    unowned let sceneLoader: SceneLoader
    
    //MARK: Initialization
    
    init(sceneLoader: SceneLoader){
        self.sceneLoader = sceneLoader
    }
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        
        if !sceneLoader.sceneMetadata.requiresOnDemandResources{
            stateMachine!.enter(SceneLoaderResourcesAvailableState.self)
        }
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        super.isValidNextState(stateClass)
        
        if stateClass is SceneLoaderDownloadingResourcesState.Type{
            return true
        }
        
        return stateClass is SceneLoaderResourcesAvailableState.Type
    }
    
    
}
