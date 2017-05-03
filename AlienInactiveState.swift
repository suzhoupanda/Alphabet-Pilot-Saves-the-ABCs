//
//  AlienInactiveState.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/2/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class AlienInactiveState: GKState{
    
    let alienEntity: Alien
    
    var frameCount: TimeInterval = 0.00
    var inactiveInterval : TimeInterval = 2.00
    
    init(alienEntity: Alien){
        self.alienEntity = alienEntity
        super.init()
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        /** While in the inactive state, if the alien is not in its original position, then it will gradually lerp back towards that position. This occurs when the alien enters the inactive state while chasing the player in attack mode.
         **/
        
        guard let renderComponent = alienEntity.component(ofType: RenderComponent.self) else {
            print("Error: failed to load the render component for \(alienEntity) upon entering the \(stateMachine?.currentState)")
            return
        }
        
        let originalPosition = renderComponent.originalPosition
        
        if !renderComponent.node.position.equalTo(originalPosition){
            renderComponent.node.lerpToPoint(targetPoint: originalPosition, withLerpFactor: 0.05)
        }
        
        frameCount += seconds
        
        if frameCount > inactiveInterval{
            
            stateMachine?.enter(AlienActiveState.self)
            frameCount = 0.00
        }
    }
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        
      
       
        guard let animationComponent = alienEntity.component(ofType: BasicAnimationComponent.self) else {
            print("Error: state machine failed to enter \(stateMachine?.currentState) from \(previousState)")
            return }
        
        frameCount = 0.00
        
       
        //Remove any active animations
        if animationComponent.animationNode?.action(forKey: "activeAnimation") != nil{
            animationComponent.animationNode?.removeAction(forKey: "activeAnimation")
        }
        
        //Run any inactive animations
        
        let inactiveAnimationName = Alien.getInactiveAnimationName(alienColor: alienEntity.alienColor)
        
        animationComponent.runAnimation(withAnimationNameOf: inactiveAnimationName, andWithAnimationKeyOf: "inactiveAnimation", repeatForever: false)
        
        
    }
    

    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        super.isValidNextState(stateClass)
        
        switch(stateClass){
            case is AlienActiveState.Type:
                return true
            default:
                return false
        }
        
    }
    
   
}
