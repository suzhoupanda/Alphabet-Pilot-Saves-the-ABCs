//
//  BeeActiveState.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/4/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class BeeActiveState: GKState{
    
    let bee: Bee
    
    var previousOrientation: Orientation = .Left
    
    init(bee: Bee){
        self.bee = bee
    }
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        guard let updatedOrientation = bee.component(ofType: OrientationComponent.self)?.currentOrientation else {
            print("Error: failed to load the orientation component for bee while performing updates in the active state")
            return
        }
        
        guard let animationComponent = bee.component(ofType: BasicAnimationComponent.self), let animationNode = animationComponent.animationNode else {
            print("Error: failed to load the animation component for the bee while performing updates in the active state")
            return
            }
        
        
        if updatedOrientation != previousOrientation{
            
            
            if animationNode.action(forKey: "flyAnimation") != nil{
                animationNode.removeAction(forKey: "flyAnimation")
            }
            
            let animationName = Bee.getFlyAnimation(forOrientation: updatedOrientation)
            
            animationComponent.runAnimation(withAnimationNameOf: animationName, andWithAnimationKeyOf: "flyAnimation", repeatForever: true)
            
            previousOrientation = updatedOrientation
        }

        
        
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        super.isValidNextState(stateClass)
        
        switch stateClass{
            default:
            return false
        }
    }
}
