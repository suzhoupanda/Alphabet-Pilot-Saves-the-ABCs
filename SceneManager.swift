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
            scene.sceneManager = self
            
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
        
    }
    
    private func beginDownloadingNextPossibleScenes(){
        
    }
    
    private func allPossibleNextScenes() -> Set<SceneMetaData>{
        
    }
    
    func sceneLoader(forSceneIdentifier sceneIdentifier: SceneIdentifier) -> SceneLoader{
        
        
    }
    
    deinit {
        
    }
    
    //Configures the progress scene to show the progress of the scene loader
    
    func presentProgressScene(for loader: SceneLoader){
        
    }
    
    func registerForNotifications(){
        
    }
}
