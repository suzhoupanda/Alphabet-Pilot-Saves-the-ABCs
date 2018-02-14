//
//  LoadOnDemandResourcesOperation.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/26/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation

import Foundation

//TODO: NSOperation subclass not yet fully implemented 


class LoadOnDemandResourcesOperation: Operation{
    
    let letterScene: LetterScene
    
    
    init(letterScene: LetterScene){
        self.letterScene = letterScene
    }
    
    
    override func start() {
        guard !isCancelled else { return }
        
        
        letterScene.loadSceneResources()
        
        let tags: Set<String> = [letterScene.rawValue]
        
        let bundleResourceRequest = NSBundleResourceRequest(tags: tags)
        
        bundleResourceRequest.beginAccessingResources(completionHandler: {
        
            error in
            
            if error != nil{
                print("Error: error occurred while downloading on demand resources")
                
                
                //TODO: not yet implemented
                
            }
            
        
        
        })
        
        
    }
    
    
    
    
}
