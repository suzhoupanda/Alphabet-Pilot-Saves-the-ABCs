//
//  SceneLoaderResourcesReadyState.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/9/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import GameplayKit

class SceneLoaderResourcesReadyState: GKState{
    
    // MARK: Properties
    
    unowned let sceneLoader: SceneLoader
    
    // MARK: Initialization
    
    init(sceneLoader: SceneLoader) {
        self.sceneLoader = sceneLoader
    }
    
    // MARK: GKState Life Cycle
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        
        // Clear the `sceneLoader`'s progress as loading is complete.
        sceneLoader.progress = nil
        
        // Notify to any interested objects that the download has completed.
        NotificationCenter.default.post(name: NSNotification.Name.SceneLoaderDidCompleteNotification, object: sceneLoader)
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is SceneLoaderResourcesAvailableState.Type, is SceneLoaderInitialState.Type:
            return true
            
        default:
            return false
        }
    }
    
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
        
        /*
         Presenting the scene is a one shot operation. Clear the scene when
         exiting the ready state.
         */
        sceneLoader.scene = nil
    }
}
