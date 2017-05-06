//
//  NotificationNameExtension.swift
//  AlphabetPilot
//
//  Created by Aleksander Makedonski on 4/22/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation


extension Notification.Name{
    
  
    
    static let DidTouchPlayerNodeNotification = Notification.Name("didTouchPlayerNodeNotification")
    static let DidTouchScreenNotification = Notification.Name(rawValue: "didTouchScreenNotification")
    static let PlayerDidContactLetterNotification = Notification.Name(rawValue: "playerDidContactLetterNotification")
    static let PlayerStartedBarrierContactNotification = Notification.Name(rawValue: "playerStartedBarrierContactNotification")
    static let PlayerStoppedBarrierContactNotification = Notification.Name(rawValue: "playerStoppedBarrierContactNotification")
    static let PlayerDidTakeDamageNotification = Notification.Name(rawValue: "playerDidTakeDamageNotification")
 
    
    static let PlayerDidMakeContactNotification = Notification.Name(rawValue: "didMakeContactNotification")
    static let PlayerDidEndContactNotification = Notification.Name(rawValue: "didEndContactNotification")
    static let PlayerEnteredPredefinedRange = Notification.Name(rawValue: "playerEnteredPredefinedRange")
    static let DidIncreasePlayerVelocityNotification = Notification.Name(rawValue: "didIncreasePlayerVelocityNotification")
    static let DidDecreasePlayerVelocityNotification = Notification.Name(rawValue: "didDecreasePlayerVelocityNotification")
    static let PlayerHasDiedNotification = Notification.Name(rawValue: "playerHasDiedNotification")
    static let PlayerContactedCoinNotification = Notification.Name(rawValue: "playerContactedCoinNotification")
    
  
    /**
    static let PlayerEnteredEnemyProximityNotification = Notification.Name(rawValue: "playerEnteredEnemyProximityNotification")
    
    static let PlayerExitedEnemyProximityNotification = Notification.Name("playerExitedEnemyProximityNotification")
    static let EnemyDidHitPlayerNotification = Notification.Name(rawValue: "enemyDidHitPlayerNotification")
    **/
    
}
