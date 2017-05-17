//
//  SaveLevelTrackerOperation.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/17/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//


import Foundation
import CoreData

class SaveLevelInformationOperation: Operation, ProgressReporting{
    
    
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
        
        let levelInformation = NSEntityDescription.insertNewObject(forEntityName: "LevelInformation", into: managedContext) as! LevelInformation
        
        
        
        let goldCoins = gameSessionData["goldCoinCount"] as! Int16
        let silverCoins = gameSessionData["silverCoinCount"] as! Int16
        let bronzeCoins = gameSessionData["bronzeCoinCount"] as! Int16
        let letterSceneName = gameSessionData["letterSceneName"] as! String
        let dateSaved = gameSessionData["dateSaved"] as! Date
        
        
        levelInformation.dateCompleted = dateSaved as NSDate?
        levelInformation.goldCoins = goldCoins
        levelInformation.silverCoins = silverCoins
        levelInformation.bronzeCoins = bronzeCoins
        levelInformation.levelScene = letterSceneName
        levelInformation.completed = true
        
        
        do{
            try managedContext.save()
            
        } catch let error as NSError{
            print("Error: Failed to save game \(error), \(error.localizedDescription)")
        }
        
    }
    
    
}

/**
 userInfo["goldCoinCount"] as! Int16
 userInfo["silverCoinCount"] as! Int16
 userInfo["bronzeCoinCount"] as! Int16
 userInfo["letterSceneName"] as! String
 userInfo["dateSaved"] as! Date
 ]
 
        **/
