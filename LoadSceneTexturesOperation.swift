//
//  LoadSceneTexturesOperation.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/22/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation


class LoadSceneTexturesOperation: Operation{
    
    let letterScene: LetterScene
    
    init(letterScene: LetterScene){
        self.letterScene = letterScene
    }
    
    
    override func start() {
        guard !isCancelled else { return }
        
       
        letterScene.loadSceneResources()
        
        
    }
    
}
