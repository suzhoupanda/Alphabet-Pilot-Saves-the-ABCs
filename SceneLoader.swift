//
//  SceneLoader.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/8/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit


//A class encapsulating the work necessary to load a scene and its resources based on a given Scene MetaData instance
class SceneLoader{
    
    //MARK: Properties 
    
    lazy var stateMachine: GKStateMachine = {
        var states = [
            SceneLoaderPreparingResourcesState(sceneLoader: self),
            SceneLoaderResourcesReadyState(sceneLoader: self),
            SceneLoaderInitialState(sceneLoader: self),
            SceneLoaderResourcesAvailableState(sceneLoader: self),
            SceneLoaderDownloadFailedState(sceneLoader: self),
            SceneLoaderDownloadingResourcesState(sceneLoader: self)
        ]

        return GKStateMachine(states: states)
    }()
    
    //The metadata describing the scene whose resources should be loaded
    
    let sceneMetadata: SceneMetaData
    
    var scene: BaseScene?
    
    var error: Error?
   
    /**  A parent progress, constructed when prepareSceneForPresentation() is called. Child progress objects are added by the 'SceneLoaderDownloadingResourcesState' and 'SceneLoaderPreparingResourcesState‘
 
    **/
    var progress: Progress?{
        didSet{
            guard let progress = progress else { return }
            
            progress.cancellationHandler = { [unowned self] in
            
                
                self.requestedForPresentation = false
                
                self.error = NSError(domain: NSCocoaErrorDomain, code: NSUserCancelledError, userInfo: nil)
                
                NotificationCenter.default.post(name: Notification.Name.SceneLoaderDidFailNotification, object: self)
            
            }
        }
    }
    
    
    /*     The current `NSBundleResourceRequest` used to download the necessary resources.
     We keep a reference to the resource request so that it can be modified while it is in progress, and pin the resources when complete.
     
     For example: the `loadingPriority` is updated when the user reaches the loading scene, and the request is cancelled and released as part of cleaning up the scene loader.
     */
    
    var bundleResourceRequest: NSBundleResourceRequest?
    
    
    var requiresProgressSceneForPreparing: Bool{
        return sceneMetadata.loadableTypes.contains(where: {$0.resourcesNeedLoading})
    }
    
    /** Indicates whether the scene we are loading has been requested to be presented
     to the user. Used to change how aggressively the resources are being made available.
     */

    var requestedForPresentation: Bool = false{
        didSet{
            
            //If requestedForPresentation is set to 'False', there's no need to adjust scene loading priorities
            
            guard requestedForPresentation else { return }
            
            if stateMachine.currentState is SceneLoaderDownloadingResourcesState{
                bundleResourceRequest?.loadingPriority = NSBundleResourceRequestLoadingPriorityUrgent
            }
            
            if let preparingState = stateMachine.currentState as? SceneLoaderPreparingResourcesState{
                preparingState.operationQueue.qualityOfService = .userInteractive
            }
        }
    }
    
    init(sceneMetadata: SceneMetaData){
        self.sceneMetadata = sceneMetadata
        
        stateMachine.enter(SceneLoaderInitialState.self)
    }
    
    
    func donwloadResourcesIfNecessary(){
        
    }
    
    func asynchronouslyLoadSceneForPresentation() -> Progress{
        
        return Progress()
    }
    
    func purgeResources(){
        
    }
}
