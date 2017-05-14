//
//  AppDelegate.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/1/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var gameSaveOperationQueue = OperationQueue()

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        guard let menuOptionsController = window?.rootViewController as? MenuOptionsViewController
            else { return true }
        
        menuOptionsController.managedContext = self.persistentContainer.viewContext
        
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.performSaveGameOperation(notification:)), name: Notification.Name.UserRequestedGameSaveNotification, object: nil)
     
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "GameSaver")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func performSaveGameOperation(notification: Notification){
        
        guard let userInfoDict = notification.userInfo as? [String: Any] else {
            print("Error: failed to load user info dictionary from notification")
            return
        }
        
        let saveGameOperation = SaveGameOperation(gameSessionData: userInfoDict, managedContext: self.persistentContainer.viewContext)
        
        gameSaveOperationQueue.addOperation(saveGameOperation)
        
    }
    
    

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}



/**
 NotificationCenter.default.addObserver(forName: Notification.Name.UserRequestedGameSaveNotification, object: BaseScene.self, queue: gameSaveOperationQueue, using: {
 
 [unowned self] notification in
 
 
 
 let gameSession = NSEntityDescription.insertNewObject(forEntityName: "GameSession", into: self.persistentContainer.viewContext) as! GameSession
 
 guard let userInfo = notification.userInfo else {
 print("Error: Failed to load user info dictionary from game save request notification")
 return
 }
 
 let bronzeCointCount = userInfo["playerBronzeCoinCount"] as! Int16
 let silverCoinCount = userInfo["playerSilverCointCount"] as! Int16
 let goldCoinCount = userInfo["playerGoldCoinCount"] as! Int16
 let healthLevel = userInfo["playerHealth"] as! Int16
 let planeColor = userInfo["playerPlaneColor"] as! String
 let sceneName = userInfo["playerSceneName"] as! String
 let letterName = userInfo["playerLetterTarget"] as! String
 let damageStatus = userInfo["playerDamageStatus"] as! Bool
 let currentDate = userInfo["playerDateSaved"] as! Date
 
 let playerXPos = userInfo["playerXPosition"] as! Double
 let playerYPos = userInfo["playerYPosition"] as! Double
 let playerXVelocity = userInfo["playerXVelocity"] as! Double
 let playerYVelocity = userInfo["playerYVelocity"] as! Double
 
 
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
 try! self.persistentContainer.viewContext.save()
 
 } catch let error as NSError{
 print("Error: Failed to save game \(error), \(error.localizedDescription)")
 }
 
 print("Game data saved!")
 
 })
 
 **/


