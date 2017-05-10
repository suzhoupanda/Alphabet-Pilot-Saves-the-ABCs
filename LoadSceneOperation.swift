//
//  LoadSceneOperation.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/9/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import UIKit


/** A subclass of operation that manages the loading of a BaseScene
 
 **/


class LoadSceneOperation: SceneOperation, ProgressReporting{
    
    //MARK: ****** PROPERTIES 
    
    //The metadata for the scene to load
    let sceneMetadata: SceneMetaData
    
    //The scene this operation is responsible for loading, set after completion
    var scene: BaseScene?
    
    
    //Progress used to report on the status of this operation
    let progress: Progress
    
    
    init(sceneMetadata: SceneMetaData){
        self.sceneMetadata = sceneMetadata
        
        progress = Progress(totalUnitCount: 1)
        
        super.init()
    }
    
    //MARK: NSOperation
    
    override func start() {
        guard !isCancelled else { return }
        
        if progress.isCancelled{
            cancel()
            return
        }
        
        
        self.state = .executing
        
        let scene = sceneMetadata.sceneType.init(sksFileName: sceneMetadata.fileName, size: UIScreen.main.bounds.size)
        self.scene = scene
        
        progress.completedUnitCount = 1
        
        self.state = .finished
    }
}
