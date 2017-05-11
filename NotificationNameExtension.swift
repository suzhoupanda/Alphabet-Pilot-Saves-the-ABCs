//
//  NotificationNameExtension.swift
//  AlphabetPilot
//
//  Created by Aleksander Makedonski on 4/22/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation


extension Notification.Name{
    
    /*  Use these constants with `NSNotificationCenter` to listen for events from the
        scene resource states.
     
        The `object` property of the notification will contain the `SceneLoader`.
     */
    
    public static let SceneLoaderDidCompleteNotification  = NSNotification.Name(rawValue: "SceneLoaderDidCompleteNotification")
    
    public static let SceneLoaderDidFailNotification  = NSNotification.Name(rawValue: "SceneLoaderDidFailNotification")
    
    //Gameplay-related Notifications
    
    static let PlayerDidMakeContactNotification = Notification.Name(rawValue: "didMakeContactNotification")
    static let PlayerDidEndContactNotification = Notification.Name(rawValue: "didEndContactNotification")
    static let PlayerEnteredPredefinedRange = Notification.Name(rawValue: "playerEnteredPredefinedRange")
    static let DidIncreasePlayerVelocityNotification = Notification.Name(rawValue: "didIncreasePlayerVelocityNotification")
    static let DidDecreasePlayerVelocityNotification = Notification.Name(rawValue: "didDecreasePlayerVelocityNotification")
    static let PlayerHasDiedNotification = Notification.Name(rawValue: "playerHasDiedNotification")
    static let PlayerContactedCoinNotification = Notification.Name(rawValue: "playerContactedCoinNotification")
    
    static let DidTouchPlayerNodeNotification = Notification.Name("didTouchPlayerNodeNotification")
    static let DidTouchScreenNotification = Notification.Name(rawValue: "didTouchScreenNotification")
    static let PlayerDidContactLetterNotification = Notification.Name(rawValue: "playerDidContactLetterNotification")
    static let PlayerStartedBarrierContactNotification = Notification.Name(rawValue: "playerStartedBarrierContactNotification")
    static let PlayerStoppedBarrierContactNotification = Notification.Name(rawValue: "playerStoppedBarrierContactNotification")
    static let PlayerDidTakeDamageNotification = Notification.Name(rawValue: "playerDidTakeDamageNotification")
    
    static let LevelChosenNotification = Notification.Name(rawValue: "levelChosenNotification")
    
  
    /**
    static let PlayerEnteredEnemyProximityNotification = Notification.Name(rawValue: "playerEnteredEnemyProximityNotification")
    
    static let PlayerExitedEnemyProximityNotification = Notification.Name("playerExitedEnemyProximityNotification")
    static let EnemyDidHitPlayerNotification = Notification.Name(rawValue: "enemyDidHitPlayerNotification")
    **/
    
}
