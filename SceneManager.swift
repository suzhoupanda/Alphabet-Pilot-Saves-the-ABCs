//
//  SceneManager.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/9/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit


protocol SceneManagerDelegate: class{
    //Called whenever a scene manager has transitioned to a new scene
    
    func sceneManager(_ sceneManager: SceneManager, didTransitionTo scene: SKScene)
}


final class SceneManager{
    
    //MARK: Types
    
    enum SceneIdentifier{
        case home, end
        case currentLevel, nextLevel
        case level(Int)
    }
    
    //MARK: Properties 
    
    //A mapping of scene metadata instances to the resource requests responsible for accessing the necessary resources for those scenes
    
    let sceneLoaderForMetadata: [SceneMetaData: SceneLoader]
    
    //The view used to choreograph scene transitions
    
    let presentingView: SKView
    
    
    //The SceneManager's delegate
    
    weak var delegate: SceneManagerDelegate?
    
    
    var nextSceneMetadata: SceneMetaData{
        
        let homeScene = sceneConfigurationInfo.first!
        
        guard let currentSceneMetadata = currentSceneMetadata else {
            return homeScene
        }
        
        let index = sceneConfigurationInfo.index(of: currentSceneMetadata)!
        
        
        if index+1<sceneConfigurationInfo.count{
            return sceneConfigurationInfo[index+1]
        }
        
        return homeScene
    }
    
    //The scene that is currently being presented
    
    private (set) var currentSceneMetadata: SceneMetaData?
    
    //TODO: The scene used to indicate progress when additional content needs to be loaded
    
   // private var progressScene: ProgressScene?
    
    //Cached array of scene structure loaded from SceneConfiguration.plist
    
    private let sceneConfigurationInfo: [SceneMetaData]
    
    //An object to act as the observer for the SceneLoaderDidCompleteNotification
    
    private var loadingCompletedObserver: AnyObject?
    
    //MARK: Initialization
    
    init(presentingView: SKView){
        self.presentingView = presentingView
        
        let url = Bundle.main.url(forResource: "SceneConfiguration", withExtension: "plist")!
        let scenes = NSArray(contentsOf: url) as! [[String:AnyObject]]
        
        sceneConfigurationInfo = scenes.map {
                SceneMetaData(sceneConfiguration: $0)
            }
        
        //Map 'SceneMetaData' to 'SceneLoader' for each possible scene
        
        var sceneLoaderForMetadata = [SceneMetaData: SceneLoader]()
        
        for metaData in sceneConfigurationInfo{
            
            let sceneLoader = SceneLoader(sceneMetadata: metaData)
            
            sceneLoaderForMetadata[metaData] = sceneLoader
        }
        
        
        //Keep an immutable copy of the scene loader dictionary
        self.sceneLoaderForMetadata = sceneLoaderForMetadata
        
        
        registerForNotifications()
    }
    
    
    func presentScene(for loader: SceneLoader){
        
        guard let scene = loader.scene else {
            
            assertionFailure("Requested presentation for a scene loader without a valid scene")
            return
        }
        
        //Hold on to a reference to the current scene's metadata
        
        currentSceneMetadata = loader.sceneMetadata
        
        //Ensure that we present the scene on the main queue 
        
        DispatchQueue.main.async {
            // scene.sceneManager = self
            
            //Present the scene with a transition 
            
            let transition = SKTransition.fade(withDuration: 3.00)
            self.presentingView.presentScene(scene, transition: transition)
            
            self.beginDownloadingNextPossibleScenes()
            
            //self.progressScene = nil
            
            self.delegate?.sceneManager(self, didTransitionTo: scene)
            
            loader.stateMachine.enter(SceneLoaderInitialState.self)
        }
    }
    
    func transitionToScene(identifier sceneIdentifier: SceneIdentifier){
        
        let loader = self.sceneLoader(forSceneIdentifier: sceneIdentifier)
        
        if loader.stateMachine.currentState is SceneLoaderResourcesReadyState{
            presentScene(for: loader)
        } else {
            
            _ = loader.asynchronouslyLoadSceneForPresentation()
            
            loader.requestedForPresentation = true
            
            if loader.requiresProgressSceneForPreparing{
                presentProgressScene(for: loader)
            }
        }
        
    }
    
    private func beginDownloadingNextPossibleScenes(){
        
        let possibleScenes = allPossibleNextScenes()
        
        for sceneMetadata in possibleScenes{
            
            let resourceRequest = sceneLoaderForMetadata[sceneMetadata]
            
            resourceRequest?.donwloadResourcesIfNecessary()
        }
        
        var unreachableScenes = Set(sceneLoaderForMetadata.keys)
        
        unreachableScenes.subtract(possibleScenes)
        
        for sceneMetadata in unreachableScenes{
            
            let resourceRequest = sceneLoaderForMetadata[sceneMetadata]!
            
            resourceRequest.purgeResources()
        }
    }
    
    private func allPossibleNextScenes() -> Set<SceneMetaData>{
        
        let homeScene = sceneConfigurationInfo.first!
        
        guard let currentSceneMetadata = currentSceneMetadata else {
            return [homeScene]
        }
        
        return [homeScene, nextSceneMetadata, currentSceneMetadata]
    }
    
    func sceneLoader(forSceneIdentifier sceneIdentifier: SceneIdentifier) -> SceneLoader{
        
        let sceneMetadata: SceneMetaData
        
        switch sceneIdentifier{
            case .home:
                sceneMetadata = sceneConfigurationInfo.first!
                break
            case .currentLevel:
                guard let currentSceneMetadata = currentSceneMetadata else {
                    fatalError("Current scene doesn't exist")
                    }
                sceneMetadata = currentSceneMetadata
                break
            case .nextLevel:
                sceneMetadata = nextSceneMetadata
                break
            case .level(let levelNumber):
                sceneMetadata = sceneConfigurationInfo[levelNumber]
                break
            case .end:
                sceneMetadata = sceneConfigurationInfo.last!
                break
        }
        
        return sceneLoaderForMetadata[sceneMetadata]!
    }
    
    deinit {
        if let loadingCompletedObserver = loadingCompletedObserver{
            
            NotificationCenter.default.removeObserver(loadingCompletedObserver, name: Notification.Name.SceneLoaderDidCompleteNotification, object: nil)
        }
    }
    
    //Configures the progress scene to show the progress of the scene loader
    
    func presentProgressScene(for loader: SceneLoader){
        
        /**
        guard progressScene == nil else { return }
        
        progressScene = ProgressScene.progressScene(withSceneLoader: loader)
        
        progressScene!.sceneManager = self
        
        let transition = SKTransition.doorsCloseVertical(withDuration: 3.00)
        
        presentingView.presentScene(progressScene!, transition: transition)
        **/
    }
    
    func registerForNotifications(){
        
        guard loadingCompletedObserver == nil else { return }
        
        loadingCompletedObserver = NotificationCenter.default.addObserver(forName: Notification.Name.SceneLoaderDidCompleteNotification, object: nil, queue: OperationQueue.main, using: {
            
            [unowned self] notification in
            
            let sceneLoader = notification.object as! SceneLoader
            
            guard let managedSceneLoader = self.sceneLoaderForMetadata[sceneLoader.sceneMetadata], managedSceneLoader === sceneLoader else { return }
            
            guard sceneLoader.stateMachine.currentState is SceneLoaderResourcesReadyState else {
                    fatalError("Received complete notification, but the stateMachine's current state is not ready")
                }
            
            if sceneLoader.requestedForPresentation{
                self.presentScene(for: sceneLoader)
            }
            
            sceneLoader.requestedForPresentation = false
        })
    }
}
