//
//  SceneOperation.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/9/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation

class SceneOperation: Operation{
    
    @objc enum State: Int{
        case ready
        case executing
        case finished
        case cancelled
    }
    
    dynamic var state = State.ready
    
    override var isExecuting: Bool{
        return state == .executing
    }
    
    override var isFinished: Bool{
        return state == .finished
    }
    
    override var isCancelled: Bool{
        return state == .cancelled
    }
    
    class func keyPathsForValuesAffectingIsReady() -> Set<String> {
        return ["state"]
    }
    
    class func keyPathsForValuesAffectingIsExecuting() -> Set<String> {
        return ["state"]
    }
    
    class func keyPathsForValuesAffectingIsFinished() -> Set<String> {
        return ["state"]
    }
    
    class func keyPathsForValuesAffectingIsCancelled() -> Set<String> {
        return ["state"]
    }
    
    
    
}
