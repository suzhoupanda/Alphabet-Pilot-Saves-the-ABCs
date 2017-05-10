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
    
    
    //An internal operation queue for loading resources in the background
    
    let operationQueue: OperationQueue = OperationQueue()
    
    
    var progress: Progress? {
        didSet{
            guard let progress = progress else { return }
            
            progress.cancellationHandler = {
                
                [unowned self] in
                
                    self.cancel()
            
                }
        }
    }
    
    //MARK: Initialization
    
    init(sceneLoader: SceneLoader){
        self.sceneLoader = sceneLoader
        
        operationQueue.name = "com.AlexMakedonski.AlphabetLearner.SceneLoaderPreparingResourcesState"
        
        operationQueue.qualityOfService = .utility
    }
    
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        
        loadResourcesAsynchronously()
    }
    
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        super.isValidNextState(stateClass)
        
        switch stateClass {
        // Only valid if the `sceneLoader`'s scene has been loaded.
        case is SceneLoaderResourcesReadyState.Type where sceneLoader.scene != nil:
            return true
            
        case is SceneLoaderResourcesAvailableState.Type:
            return true
            
        default:
            return false
        }
    }
    
    //Load Resources
    
    func loadResourcesAsynchronously(){
        let sceneMetadata = sceneLoader.sceneMetadata
        
        let loadingProgress = Progress(totalUnitCount: sceneMetadata.loadableTypes.count + 1)
        
        
        sceneLoader.progress?.addChild(loadingProgress, withPendingUnitCount: 1)
        
        progress = loadingProgress
        
        let loadSceneOperation =  LoadSceneOperation(sceneMetadata: sceneMetadata)
        
        loadingProgress.addChild(loadSceneOperation.progress, withPendingUnitCount: 1)
        
        loadSceneOperation.completionBlock = { [unowned self] in
            DispatchQueue.main.async {
                
                self.sceneLoader.scene = loadSceneOperation.scene
                
                let didEnterReadyState = self.stateMachine!.enter(SceneLoaderResourcesReadyState.self)
                assert(didEnterReadyState, "Failed to transition to 'ReadyState' after resources were prepared")
            }
        
        }
        
        for loaderType in sceneMetadata.loadableTypes{
            
            let loadResourceOperation = LoadResourcesOperation(loadableType: loaderType)
            
            loadingProgress.addChild(loadResourceOperation.progress, withPendingUnitCount: 1)
            
            loadSceneOperation.addDependency(loadResourceOperation)
            
            operationQueue.addOperation(loadResourceOperation)
            
        }
    }
    
    //Cancel all pending operations
    
    func cancel(){
        operationQueue.cancelAllOperations()
        sceneLoader.scene = nil
        sceneLoader.error = NSError(domain: NSCocoaErrorDomain, code: NSUserCancelledError, userInfo: nil)
        
        DispatchQueue.main.async {
            self.stateMachine?.enter(SceneLoaderResourcesAvailableState.self)
            
            //Notify that the loading was not completed
            NotificationCenter.default.post(name: Notification.Name.SceneLoaderDidFailNotification, object: self.sceneLoader)
        }
    }
}
