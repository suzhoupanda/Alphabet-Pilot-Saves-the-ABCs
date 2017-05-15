//
//  LoadBaseSceneOperation.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/15/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import UIKit

class LoadBaseSceneOperation: Operation, ProgressReporting{
    
    //MARK: Properties
    
    var requestedBaseScene: BaseScene?
    
    var sksFileName: String
    
    var progress: Progress
    
    
    //MARK: Initialization
    
    init(requestedBaseScene: BaseScene?, sksFileName: String){
        
        self.requestedBaseScene = requestedBaseScene
        self.sksFileName = sksFileName
        
        progress = Progress(totalUnitCount: 1)
        
        super.init()
        
    }
    
    override func start() {
        
        print("About to load base scene...")
        
        guard !isCancelled else { return }
        
        if progress.isCancelled {
            // Ensure the operation is marked as `cancelled`.
            cancel()
            return
        }
        
        requestedBaseScene = BaseScene(sksFileName: sksFileName, size: UIScreen.main.bounds.size)
        
        progress.completedUnitCount = 1
        
        
        //A notification is posted when the requested base scene is finished loading
        
        print("BaseScene finished loading...Posting notification...")
        
        NotificationCenter.default.post(name: Notification.Name.BaseSceneFinishedLoadingNotification, object: nil)
        
        
    }

    
}
