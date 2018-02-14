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
    
   var textureAtlasManagevar = TextureAtlasManager.sharedManager
    var mainMotionManager = MainMotionManager.sharedMotionManager
    
    var canViewHelpContent: Bool = true
    var managedContext: NSManagedObjectContext!
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        //Clear the level-preview thumbnail cache in case it still contains loaded thumbnails
        
        LevelThumbnailCache.sharedCache.clearCache()
        
        
        //If a game is currently running, dismiss the GameSceneController and perform all the  operations related to exiting the game...
        
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
    
  

    //MARK: ********* App LifeCycle Functions
    
    override func viewWillLayoutSubviews() {
        
        super.viewWillLayoutSubviews()
        
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        super.viewWillAppear(animated)
        
        MusicHelper.sharedHelper.playBackgroundMusic(musicFileName: "Sad Town")
    
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
    }

    
    override func didMove(toParentViewController parent: UIViewController?) {
        super.didMove(toParentViewController: parent)
        
       
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerForNotifications()
        
      
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        MusicHelper.sharedHelper.turnOffBackgroundMusic()
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        

    }
    
    //MARK: ******** Segue-Related Methods
    
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
        
        
        DispatchQueue.global().async {
            
            TextureAtlasManager.sharedManager.loadSecondaryTextureAtlases()
            
            DispatchQueue.main.async {
                self.present(levelViewController, animated: true, completion: nil)

            }
        }
    
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
    
  

    //MARK: ******* Register for notificaitons
   
    func registerForNotifications(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(MenuOptionsViewController.loadGame(notification:)), name: Notification.Name.LevelChosenNotification, object: LevelViewController.self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MenuOptionsViewController.reloadCurrentGame(notification:)), name: Notification.Name.ReloadCurrentGameNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MenuOptionsViewController.reloadSavedGame(notification:)), name: Notification.Name.ReloadSavedGameNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MenuOptionsViewController.reloadSavedGame(notification:)), name: Notification.Name.ReloadSavedGameNotification, object: nil)
        
    }
    
    //MARK: ******* Override variables device orientation variables
    

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .landscape
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        return .landscapeLeft
    }

}
