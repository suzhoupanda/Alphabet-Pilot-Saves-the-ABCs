//
//  MenuOptionsViewController.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/13/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//


import Foundation
import UIKit
import SpriteKit
import CoreData
import CoreMotion
import ReplayKit

class MenuOptionsViewController: UIViewController{
    
   var textureAtlasManager = TextureAtlasManager.sharedManager
    var mainMotionManager = MainMotionManager.sharedMotionManager
    
    var canViewHelpContent: Bool = true
    var managedContext: NSManagedObjectContext!
    
  
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //Make sure the texture atlas manager singleton is instantiated
       // TextureAtlasManager.sharedManager
       // JSONManager.sharedHelper.printJSONData()
        
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        MusicHelper.sharedHelper.playBackgroundMusic(musicFileName: "Sad Town")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerForNotifications()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        MusicHelper.sharedHelper.turnOffBackgroundMusic()
    }
    
    @IBAction func loadLevelViewControllerFromPortraitMenu(_ sender: UIButton) {
        segueToLevelController()
    }
  
    @IBAction func loadLevelViewControllerFromLandscapeMenu(_ sender: UIBarButtonItem) {
        segueToLevelController()
    }
   
    func segueToLevelController(){
        
        //Set presentation style for LevelViewController
        
        modalPresentationStyle = .fullScreen
        
        //Configure LevelViewController layout properties (since the itemSize will be fixed, the layout delegate callback methods are not implemented for efficiency reasons
        
        
        let levelViewLayout = LevelControllerCollectionViewLayout()
        
        ///Initialize LevelViewController 
        
        let levelViewController = LevelViewController(collectionViewLayout: levelViewLayout)
        levelViewController.view.backgroundColor = UIColor.GetCustomColor(customColor: .SharkFinWhite)
        
        levelViewController.managedContext = managedContext
        levelViewController.collectionView?.backgroundColor = UIColor.GetCustomColor(customColor: .SharkFinWhite)
    
        present(levelViewController, animated: true, completion: nil)
    }
    
    
   
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "ShowGameHelpSegue"{
            
            guard canViewHelpContent else {
                //Alert user that help content cannot be viewed without special access rights
                
                let alertController = UIAlertController()
                alertController.message = "Game help content is only available to gold users who purchase all of the app's content"
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                present(alertController, animated: true, completion: nil)
                
                return false
            }
            
            
            return true
        }
        
        return true
    }
    
    @IBAction func unwindHelpViewController(unwindHelpSegue: UIStoryboardSegue){
        
        
        
    }
    
    @IBAction func returnToMainMenu(unwindSavedGameSegue: UIStoryboardSegue){
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowGameHelpSegue"{
            
            
        }
        
        if segue.identifier == "ShowSavedGameControllerSegue"{
            
            //Pass the managed object context to the saved game conroller 
            
            let navigationController = segue.destination as! UINavigationController
            
            let savedGameController = navigationController.viewControllers.first! as! SavedGameController
            
            savedGameController.managedContext = self.managedContext
            
            
           
            

            
        }
    }
    
    
    
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
            
            loadTexturesOperation.start()
            
            
            gscController.baseScene =  GameSceneController.GetSceneForLetterSceneType(letterScene: letterScene!, reloadData: nil)
            
            DispatchQueue.main.sync {
                self.present(gscController, animated: true, completion: nil)

            }
        
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
        
        
            
            let loadTexturesOperation = LoadSceneTexturesOperation(letterScene: reloadData.letterScene)
            
            loadTexturesOperation.start()
        
            //let gscController = GameSceneController(nibName: nil, bundle: nil)
            gscController.letterScene = reloadData.letterScene
            gscController.reloadData = reloadData
            
            gscController.baseScene =  GameSceneController.GetSceneForLetterSceneType(letterScene: reloadData.letterScene, reloadData: reloadData)
            
            DispatchQueue.main.sync {
            
                self.present(gscController, animated: true, completion: nil)
            }
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
                
                DispatchQueue.main.sync {
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
                
                //Once the Game Scene Controller is dismissed, it's no longer necessary to continue receiving motion updates for player position
                
                self.mainMotionManager.stopDeviceMotionUpdates()
                
                
            
                
            })
        }
        
    }

   
    func registerForNotifications(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(MenuOptionsViewController.loadGame(notification:)), name: Notification.Name.LevelChosenNotification, object: LevelViewController.self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MenuOptionsViewController.reloadCurrentGame(notification:)), name: Notification.Name.ReloadCurrentGameNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MenuOptionsViewController.reloadSavedGame(notification:)), name: Notification.Name.ReloadSavedGameNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MenuOptionsViewController.reloadSavedGame(notification:)), name: Notification.Name.ReloadSavedGameNotification, object: nil)
        
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .landscape
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        return .landscapeLeft
    }
    
}
