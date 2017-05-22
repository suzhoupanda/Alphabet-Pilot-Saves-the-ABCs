//
//  AlienActiveState.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/2/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class AlienActiveState: GKState{
    
    var frameCount: TimeInterval = 0.00
    var activeInterval: TimeInterval = 7.00
    
    unowned let alienEntity: Alien
    
    init(alienEntity: Alien) {
        self.alienEntity = alienEntity
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        
        frameCount = 0.0
        
        guard let animationComponent = alienEntity.component(ofType: BasicAnimationComponent.self) else {
            print("Error: failed to load the animation component for \(alienEntity) upon entering the \(stateMachine?.currentState) state from \(previousState)")
            return
        }
        
        switch(previousState){
        
        case is AlienInactiveState:
            if animationComponent.animationNode?.action(forKey: "inactiveAnimation") != nil{
                animationComponent.animationNode?.removeAction(forKey: "inactiveAnimation")
            }
            
            let activeAnimationName = Alien.getActiveAnimationName(alienColor: alienEntity.alienColor)
            
            animationComponent.runAnimation(withAnimationNameOf: activeAnimationName, andWithAnimationKeyOf: "activeAnimation", repeatForever: false)
            break
        case is AlienAttackState:
            //Remove attack mode animation
            if animationComponent.animationNode?.action(forKey: "attackAnimation") != nil{
                    animationComponent.animationNode?.removeAction(forKey: "attackAnimation")
            }
            break
        default:
            break
        }
        
        
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        if let targetDetectionComponent = alienEntity.component(ofType: TargetDetectionComponent.self), targetDetectionComponent.playerHasEnteredProximity{
            
            print("Player has entered alien vicinity...Now entering attack mode...")
            stateMachine?.enter(AlienAttackState.self)
            
        }
        
        frameCount += seconds
        
        if frameCount > activeInterval{
            
            stateMachine?.enter(AlienInactiveState.self)
            frameCount = 0.00
        }
        
       
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        super.isValidNextState(stateClass)
        
        switch(stateClass){
            case is AlienAttackState.Type, is AlienInactiveState.Type:
                return true
            default:
                return false
        }
    }
 
}
