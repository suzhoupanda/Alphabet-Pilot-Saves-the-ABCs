//
//  SaveGameOperation.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/14/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import CoreData

class SaveGameOperation: Operation, ProgressReporting{
    
    
    //MARK: Properties
    
    let gameSessionData: [String: Any]
    
    let managedContext: NSManagedObjectContext
    
    var progress: Progress
    
    
    //MARK: Initialization
    
    init(gameSessionData: [String: Any], managedContext: NSManagedObjectContext){
        
        self.managedContext = managedContext
        self.gameSessionData = gameSessionData
        progress = Progress(totalUnitCount: 1)
        
        super.init()
    
    }
    
    override func start() {
    
        guard !isCancelled else { return }
        
        if progress.isCancelled {
            // Ensure the operation is marked as `cancelled`.
            cancel()
            return
        }
        
        let gameSession = NSEntityDescription.insertNewObject(forEntityName: "GameSession", into: managedContext) as! GameSession
        
      
        
        let bronzeCointCount = gameSessionData["playerBronzeCoinCount"] as! Int16
        let silverCoinCount = gameSessionData["playerSilverCointCount"] as! Int16
        let goldCoinCount = gameSessionData["playerGoldCoinCount"] as! Int16
        let healthLevel = gameSessionData["playerHealth"] as! Int16
        let planeColor = gameSessionData["playerPlaneColor"] as! String
        let sceneName = gameSessionData["playerSceneName"] as! String
        let letterName = gameSessionData["playerLetterTarget"] as! String
        let damageStatus = gameSessionData["playerDamageStatus"] as! Bool
        let currentDate = gameSessionData["playerDateSaved"] as! Date
        
        let playerXPos = gameSessionData["playerXPosition"] as! Double
        let playerYPos = gameSessionData["playerYPosition"] as! Double
        let playerXVelocity = gameSessionData["playerXVelocity"] as! Double
        let playerYVelocity = gameSessionData["playerYVelocity"] as! Double
        
        
        gameSession.bronzeCoinCount = bronzeCointCount
        gameSession.goldCoinCount = goldCoinCount
        gameSession.silverCoinCount = silverCoinCount
        gameSession.isDamaged = damageStatus
        
        gameSession.dateSaved = currentDate as NSDate?
        gameSession.letter = letterName
        gameSession.planeColor = planeColor
        gameSession.playerHealth = healthLevel
        
        gameSession.playerXVelocity = playerXVelocity
        gameSession.playerYVelocity = playerYVelocity
        gameSession.playerXPos = playerXPos
        gameSession.playerYPos = playerYPos
        
        gameSession.scene = sceneName
        
        do{
            try! managedContext.save()
            
        } catch let error as NSError{
            print("Error: Failed to save game \(error), \(error.localizedDescription)")
        }
        
    }

    
}
