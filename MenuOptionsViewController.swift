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
    
    
    var canViewHelpContent: Bool = true
    var managedContext: NSManagedObjectContext!
    
  
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
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
        
        //Configure LevelViewController layout object
        
        let levelViewLayout = UICollectionViewFlowLayout()
        levelViewLayout.scrollDirection = .horizontal
        levelViewLayout.itemSize = CGSize(width: view.bounds.width*0.30, height: view.bounds.height*0.90)
        
        /** Option: Configure other layout parameters for level view controller: 
         
            levelViewLayout.minimumInteritemSpacing = view.bounds.width*0.05
            levelViewLayout.minimumLineSpacing = view.bounds.height*0.05
         
        **/
        
        
        ///Initialize LevelViewController 
        
        let levelViewController = LevelViewController(collectionViewLayout: levelViewLayout)
        levelViewController.view.backgroundColor = UIColor.GetCustomColor(customColor: .SharkFinWhite)
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
            
            
            
            
            //Fetch all saved games prior to showing the saved game view controller
            
            do{
              
                let fetchRequest = NSFetchRequest<GameSession>(entityName: "GameSession")
                
                savedGameController.savedGames = try! managedContext.fetch(fetchRequest)
            } catch let error as NSError{
                print("Failed to load saved game: \(error),\(error.localizedDescription)")
            }
            
        }
    }
    
    
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        
        let CurrentSizeClassConfiguration = (newCollection.verticalSizeClass, newCollection.horizontalSizeClass)
        
        
        
        
        //Adjust the axis of the main stack view based on the new trait collection
        
        switch(CurrentSizeClassConfiguration){
            case (.regular,.compact),(.regular,.regular):   //all other iPhones in portrait mode
                break
            case (.compact,.regular):       //iPhone 7 Plus
                break
            case (.compact,.compact):       //All other iPhones in landscape mode
                break
            default:
                break
            
        }
        
        
        
    }
    
  
   
    
    
}
