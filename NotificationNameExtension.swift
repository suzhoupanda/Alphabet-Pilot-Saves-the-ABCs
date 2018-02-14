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
    
    static let UserRequestedGameSaveNotification = Notification.Name(rawValue: "userRequestedGameSaveNotification")
    
    static let ExitGameToLevelViewControllerNotification = Notification.Name(rawValue: "exitGameToLevelViewControllerNotification")
    static let ExitGameToMainMenuNotification = Notification.Name(rawValue: "exitGameToMainMenuNotification")
    static let ReloadSavedGameNotification = Notification.Name(rawValue: "reloadSavedGameNotification")
    
    static let ReloadCurrentGameNotification = Notification.Name(rawValue: "reloadCurrentGameNotification")
    
    static let StartRecordingGameplayNotification = Notification.Name(rawValue: "startRecordingGameplayNotification")
    static let StopRecordingGameplayNotification = Notification.Name(rawValue: "stopRecordingGameplayNotification")
    static let ShowRecordedGameplayNotification = Notification.Name(rawValue: "showRecordedGameplayNotification")
  
    static let BaseSceneFinishedLoadingNotification = Notification.Name(rawValue: "baseSceneFinishedLoadingNotification")
    
    static let LevelCompletedNotification = Notification.Name(rawValue: "levelCompletedNotification")
    static let GameFinishedSavingNotification = Notification.Name(rawValue: "gameFinishedSavingNotification")
    
    /**
    static let PlayerEnteredEnemyProximityNotification = Notification.Name(rawValue: "playerEnteredEnemyProximityNotification")
    
    static let PlayerExitedEnemyProximityNotification = Notification.Name("playerExitedEnemyProximityNotification")
    static let EnemyDidHitPlayerNotification = Notification.Name(rawValue: "enemyDidHitPlayerNotification")
    **/
    
}
