//
//  IntelligenceComponent.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/2/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit


class IntelligenceComponent: GKComponent{
    
    var stateMachine: GKStateMachine?
    
    init(states: [GKState]) {
        
        stateMachine = GKStateMachine(states: states)
        super.init()
        
        registerNotifications()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        stateMachine?.update(deltaTime: seconds)
    }
    
    func playerTookDamage(notification: Notification){
        
        if let currentState = stateMachine?.currentState{
            if currentState is PlayerDamagedState { return }
        }
        
        guard let playerHealthComponent = entity?.component(ofType: HealthComponent.self) else {
            print("Error: player must have a health component in order for damage to occur")
            return
        }
        
        playerHealthComponent.decreasePlayerHealth(amount: 1)
        stateMachine?.enter(PlayerDamagedState.self)
        
    }
    
    func registerNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(IntelligenceComponent.playerTookDamage(notification:)), name: Notification.Name.PlayerDidTakeDamageNotification, object: nil)
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
