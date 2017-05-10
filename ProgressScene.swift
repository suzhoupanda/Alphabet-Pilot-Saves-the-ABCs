//
//  ProgressScene.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/10/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit


private var progressSceneKVOContext = 0

class ProgressScene: SKScene{
    
    var progressInterfaceNode: SKSpriteNode!
    
    
    var labelNode: SKLabelNode{
        return progressInterfaceNode.childNode(withName: "LabelContainer")!.childNode(withName: "Label") as! SKLabelNode
    }
    
    var progressBarNode: SKSpriteNode{
        return progressInterfaceNode.childNode(withName: "ProgressBarContainer")!.childNode(withName: "ProgressBar") as! SKSpriteNode
    }
    
    
    var sceneLoader: SceneLoader!
    
    var progressBarInitialWidth: CGFloat!
    
    var progress: Progress?{
        didSet{
            
        }
    }
    
    private var downloadFailedObserver: AnyObject?
    
    static func progressScene(withSceneLoader loader: SceneLoader) -> ProgressScene{
        
        let progressScene = ProgressScene(size: UIScreen.main.bounds.size)
        
        progressScene.setup(withSceneLoader: loader)
        
        return progressScene
       
        
    }
    
    func setup(withSceneLoader loader: SceneLoader){
        
        progressInterfaceNode = SKScene(fileNamed: "ProgressInterface")!.childNode(withName: "RootNode") as! SKSpriteNode
        
        sceneLoader = loader
        
        if let progress = sceneLoader.progress{
            self.progress = progress
        } else {
            progress = sceneLoader.asynchronouslyLoadSceneForPresentation()
        }
        
        let defaultCenter = NotificationCenter.default
        
        downloadFailedObserver = defaultCenter.addObserver(forName: Notification.Name.SceneLoaderDidFailNotification, object: sceneLoader, queue: OperationQueue.main, using: {
        
            [unowned self] notification in
            
            guard let loader = notification.object as? SceneLoader, let error = loader.error else { fatalError("The scene loader has no error to show") }
            
            self.showError(error: error as NSError)
        
        })
        
        
    }
    
    deinit {
        if let downloadFailedObserver = downloadFailedObserver{
            NotificationCenter.default.removeObserver(downloadFailedObserver, name: Notification.Name.SceneLoaderDidFailNotification, object: sceneLoader)
        }
        
        progress = nil
    }
    
    func showError(error: Error){
        
    }
    
    //MARK: Scene Life Cycle
    
    
    //MARK: Key-Value Observing (KVO) for NSProgress
    
    //MARK: ButtoNode Responder Types 
    
    //MARK: Convenience
    
    
}
