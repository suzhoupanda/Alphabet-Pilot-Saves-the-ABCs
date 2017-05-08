//
//  BlockmanInactiveState.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/8/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit


class BlockmanInactiveState: GKState{
    
    let blockman: BlockMan
    
    init(blockman: BlockMan){
        self.blockman = blockman
    }
    
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        
        print("Just entered the inactive state...")
        
        guard let animationComponent = blockman.component(ofType: BasicAnimationComponent.self) else {
            print("Error: failed to load the animation component while performing update on the barnacle in the inactive state")
            return
        }
        
        if let animationNode = animationComponent.animationNode{
            
            if animationNode.action(forKey: "mainAnimation") != nil{
                animationNode.removeAction(forKey: "mainAnimation")
            }
            
            
        }
        
        animationComponent.runAnimation(withAnimationNameOf: "normal", andWithAnimationKeyOf: "mainAnimation", repeatForever: false)
        
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        guard let fieldEmittingComponent = blockman.component(ofType: FieldEmittingComponent.self) else {
            print("Error: failed to load field emitting component while performing update on barnacle in the inactive state")
            return
        }
        
        
        
        if let fieldNode = fieldEmittingComponent.fieldNode, fieldNode.isEnabled{
            stateMachine?.enter(BlockmanEmittingState.self)
            
        }
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        super.isValidNextState(stateClass)
        
        switch stateClass {
        case is BlockmanEmittingState.Type:
            return true
        default:
            return false
        }
    }

}
