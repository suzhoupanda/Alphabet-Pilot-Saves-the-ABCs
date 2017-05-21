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

class MenuOptionsViewController: UIViewController{
    
   var textureAtlasManager = TextureAtlasManager.sharedManager
    
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
    
        
       // if let containerViewController = presentingViewController{
       //     containerViewController.setOverrideTraitCollection(UITraitCollection(verticalSizeClass: .compact), forChildViewController: levelViewController)
       // }
        
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
    
    
   
    
  
   
    
    
}
