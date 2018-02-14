//
//  MenuOptions+GameLoadingUtilityFunctions.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/26/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit


extension MenuOptionsViewController{
    //MARK: ********* Helper function related to loading, reloading, and exiting game
    
    
    func loadGame(notification: Notification){
        
        print("Starting to load game...")
        
        
        guard let letterSceneString = notification.userInfo?["letterScene"] as? String else {
            print("Error: letter scene for selected level could not be retrieved from the LevelChosenNotification userInfo dictionary")
            return
        }
        
        
        //Clear the level thumbnail cache, since user is not likely to be scrolling through collection view thumbnails while gameplay is in progress
        
        DispatchQueue.global().async {
            
            
            UIDevice.current.beginGeneratingDeviceOrientationNotifications()
            
            self.mainMotionManager.startDeviceMotionUpdates()
            self.mainMotionManager.deviceMotionUpdateInterval = 0.50
            
            
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let gscController = storyBoard.instantiateViewController(withIdentifier: "GameSceneControllerSB") as! GameSceneController
            
            //let gscController = GameSceneController(nibName: nil, bundle: nil)
            
            let letterScene = LetterScene(rawValue: letterSceneString)
            
            gscController.letterScene = letterScene
            
            let loadTexturesOperation = LoadSceneTexturesOperation(letterScene: letterScene!)

        

            DispatchQueue.global().async{
                
                loadTexturesOperation.start()
                
                gscController.baseScene =  GameSceneController.GetSceneForLetterSceneType(letterScene: letterScene!, reloadData: nil)
                
                DispatchQueue.main.async {
                    
                    self.present(gscController, animated: true, completion: nil)
                    
                }
                
            }
            
        
            
            /**
            gscController.bundleResourceRequest = NSBundleResourceRequest(tags: [letterScene!.rawValue])
            
            gscController.bundleResourceRequest!.loadingPriority = NSBundleResourceRequestLoadingPriorityUrgent
            
            gscController.bundleResourceRequest!.beginAccessingResources(completionHandler: {
                
                error in
                
                if error != nil{
                    print("Error: an error occurred while downloading on-demand resources for letter scene \(letterScene!.rawValue), error description: \(error.debugDescription)")
                }
                
                let loadTexturesOperation = LoadSceneTexturesOperation(letterScene: letterScene!)
                
                
                loadTexturesOperation.completionBlock = {
                    
                    gscController.baseScene =  GameSceneController.GetSceneForLetterSceneType(letterScene: letterScene!, reloadData: nil)
                    
                    DispatchQueue.main.async {
                        
                        self.present(gscController, animated: true, completion: nil)
                        
                    }
                    
                }
                
                loadTexturesOperation.start()
                
                
            })
            
            **/
            
        }
        
        
    }
    
    
    func reloadSavedGame(notification: Notification){
        
        
        if presentedViewController != nil{
            presentedViewController?.dismiss(animated: true, completion: nil)
        }
        
        guard let reloadData = notification.userInfo?["reloadData"] as? ReloadData else {
            print("Error: failed to retrieved reloadData from the ReloadSaveGameNotification's userInfo dict")
            return
        }
        
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let gscController = storyBoard.instantiateViewController(withIdentifier: "GameSceneControllerSB") as! GameSceneController
        
        DispatchQueue.global().async {
            
            
            UIDevice.current.beginGeneratingDeviceOrientationNotifications()
            
            self.mainMotionManager.startDeviceMotionUpdates()
            self.mainMotionManager.deviceMotionUpdateInterval = 0.50
            
            //let gscController = GameSceneController(nibName: nil, bundle: nil)
            gscController.letterScene = reloadData.letterScene
            gscController.reloadData = reloadData
            
            
            let loadTexturesOperation = LoadSceneTexturesOperation(letterScene: reloadData.letterScene)
            
            loadTexturesOperation.start()
            
            
            gscController.baseScene =  GameSceneController.GetSceneForLetterSceneType(letterScene: reloadData.letterScene, reloadData: reloadData)
                
            DispatchQueue.main.async {
                    
                    self.present(gscController, animated: true, completion: nil)
            }
            
            
            /**
            
            gscController.bundleResourceRequest = NSBundleResourceRequest(tags: [reloadData.letterScene.rawValue])
            
            gscController.bundleResourceRequest!.loadingPriority = NSBundleResourceRequestLoadingPriorityUrgent
            
            gscController.bundleResourceRequest!.beginAccessingResources(completionHandler: {
                
                error in
                
                if error != nil{
                    print("Error: an error occurred while downloading the on-demand resources for the requested scene")
                }
                
                
                let loadTexturesOperation = LoadSceneTexturesOperation(letterScene: reloadData.letterScene)
                
                loadTexturesOperation.completionBlock = {
                    
                    gscController.baseScene =  GameSceneController.GetSceneForLetterSceneType(letterScene: reloadData.letterScene, reloadData: reloadData)
                    
                    DispatchQueue.main.async {
                        
                        self.present(gscController, animated: true, completion: nil)
                    }
                    
                }
                
                loadTexturesOperation.start()
                
            })
            **/
            
            
        }
        
        
        
    }
    
    
    func reloadSavedGame(reloadData: ReloadData){
        
        
        
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        
        self.mainMotionManager.startDeviceMotionUpdates()
        self.mainMotionManager.deviceMotionUpdateInterval = 0.50
        
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let gscController = storyBoard.instantiateViewController(withIdentifier: "GameSceneControllerSB") as! GameSceneController
        
        //let gscController = GameSceneController(nibName: nil, bundle: nil)
        gscController.letterScene = reloadData.letterScene
        gscController.reloadData = reloadData
        
        self.present(gscController, animated: true, completion: nil)
        
        
        
    }
    
    
    
    
    
    func reloadCurrentGame(notification: Notification){
        
        guard let presentedViewController = presentedViewController as? GameSceneController else {
            print("Error: There is no Game Scene controller currently being presented")
            return
        }
        
        let presentingView = presentedViewController.view as! SKView
        
        
        let transition = SKTransition.crossFade(withDuration: 2.00)
        
        
        if let letterScene = presentedViewController.letterScene{
            
            
            
            DispatchQueue.global().async {
                
                
                presentedViewController.baseScene = nil
                
                
                let baseScene = GameSceneController.GetSceneForLetterSceneType(letterScene: letterScene, reloadData: nil)
                
                DispatchQueue.main.async {
                    presentingView.presentScene(baseScene, transition: transition)
                    
                }
            }
            
            
        }
        
    }
    
    
    
    
    func exitGame(notification: Notification){
        
        
        if let gameSceneViewController = presentedViewController as? GameSceneController{
            
            gameSceneViewController.dismiss(animated: true, completion: {
                
                
                //Release the GameScene controller's view from memory and purge the currently-running base scene from memory cache, as well as the ReloadData (if any) and LevelScene configuration data used to initialize the Base Scene
                
                gameSceneViewController.view = nil
                
                
                gameSceneViewController.baseScene = nil
                
            
                gameSceneViewController.letterScene = nil
                
                gameSceneViewController.reloadData = nil
                
                /**
                if let bundleResourceRequest = gameSceneViewController.bundleResourceRequest{
                    
                    bundleResourceRequest.endAccessingResources()
                    
                }
                **/
                
                //Once the Game Scene Controller is dismissed, it's no longer necessary to continue receiving motion updates for player position
                
                self.mainMotionManager.stopDeviceMotionUpdates()
                
               
                
                
            })
        }
        
    }
    

    
    
}
