//
//  LoadGameSceneControllerOperation.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/15/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import UIKit

class PresentGameSceneControllerOperation: Operation, ProgressReporting{
    
    //MARK: Properties
    
    var levelViewController: LevelViewController
    
    var gameSceneViewController: GameSceneController
    
    var preloadedBaseScene: BaseScene
    
    var progress: Progress
    
    
    //MARK: Initialization
    
    init(levelViewController: LevelViewController, gameSceneViewController: GameSceneController, baseScene: BaseScene){
        
        self.levelViewController = levelViewController
        self.gameSceneViewController = gameSceneViewController
        self.preloadedBaseScene = baseScene
        
        progress = Progress(totalUnitCount: 1)
        
        super.init()
        
    }
    
    override func start() {
        
        print("About to present the Game Scene Controller...")
        
        guard !isCancelled else { return }
        
        if progress.isCancelled {
            // Ensure the operation is marked as `cancelled`.
            cancel()
            return
        }
        
        gameSceneViewController.baseScene = preloadedBaseScene
        
        levelViewController.present(gameSceneViewController, animated: true, completion: {
        
            self.progress.completedUnitCount = 1
            
        })
        
        
        
        
        
    }
    
    
}
