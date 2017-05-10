//
//  LoadResourcesOperation.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/9/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation


class LoadResourcesOperation: SceneOperation, ProgressReporting{
    
    let loadableType: ResourceLoadableType.Type
    
    let progress: Progress
    
    init(loadableType: ResourceLoadableType.Type){
        
        self.loadableType = loadableType
        
        progress = Progress(totalUnitCount: 1)
        
        super.init()
    }
    
    override func start() {
        guard !isCancelled else { return }
        
        if progress.isCancelled{
            cancel()
            return
        }
        
        state = .executing
        
        loadableType.loadResources {
            [unowned self] in
            
            self.finish()
            
        }
    }
    
    func finish(){
        progress.completedUnitCount = 1
        state = .finished
    }
}
