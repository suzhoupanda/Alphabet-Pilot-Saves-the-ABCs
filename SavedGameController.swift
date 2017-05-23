//
//  SavedGameController.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/13/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class SavedGameController: UITableViewController{
    
    
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    
    var managedContext: NSManagedObjectContext!
    
    var fetchedResultsController: NSFetchedResultsController<GameSession>!
    
    @IBAction func searchForSavedGame(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func deleteSavedGame(_ sender: UIBarButtonItem) {
        
        tableView.isEditing = !tableView.isEditing
    }
    
    @IBAction func returnToSavedGameMenu(savedGameSegue: UIStoryboardSegue){
        
        
    
    }
  
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
      
        
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        let fetchRequest: NSFetchRequest<GameSession> = GameSession.fetchRequest()
        
        let levelSort = NSSortDescriptor(key: #keyPath(GameSession.scene), ascending: true)
        
        let dateSort = NSSortDescriptor(key: #keyPath(GameSession.dateSaved), ascending: true)
        
        fetchRequest.sortDescriptors = [levelSort,dateSort]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedContext, sectionNameKeyPath: #keyPath(GameSession.scene), cacheName: "savedGames")
        
        fetchedResultsController.delegate = self
        
        do{
            try fetchedResultsController.performFetch()
        } catch let error as NSError{
            print("Fetching error: \(error), \(error.userInfo)")
        }
 
    
    }
    
    func reloadSaveGame(notification: Notification){
        
        guard let reloadData = notification.userInfo?["reloadData"] as? ReloadData, let menuOptionsController = presentingViewController as? MenuOptionsViewController else {
            print("Error: failed to retrieve reloadData from the ReloadSavedGame notification dictionary")
            return
        }
        
        
        dismiss(animated: true, completion: {
            
            menuOptionsController.reloadSavedGame(reloadData: reloadData)
            
        })
    }
    
    
   
}




extension SavedGameController{
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        guard let sections = fetchedResultsController.sections else {
            return 0
        }
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let sectionInfo = fetchedResultsController.sections?[section] else {
            return 0
        }
        
        return sectionInfo.numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "GameSessionCell", for: indexPath)
        
        let gameSession = fetchedResultsController.object(at: indexPath)
        
        configureTableViewCell(forTableViewCell: &cell, withGameSessionDataFrom: gameSession)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let sectionInfo = fetchedResultsController.sections?[section]
        
        return sectionInfo?.name
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            
            
            /**
            
            var shouldDelete = true
            
            let alertController = UIAlertController(title: "Delete Saved Game", message: "Are you want to delete the saved game?", preferredStyle: .alert)
            
            let confirmAction = UIAlertAction(title: "Confirm", style: .default, handler: nil)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
                
                _ in
                
                shouldDelete = false
                
            })
            
            alertController.addAction(confirmAction)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: {
            
                if shouldDelete {
                    
                    //Row-deletion code
                    
                }
            
            
            })
            **/
            
            tableView.endUpdates()
            
            DispatchQueue.global().async {
                
            
            
                let objectToDelete = self.fetchedResultsController.object(at: indexPath)
                self.managedContext.delete(objectToDelete)
            
                do{
                    try self.managedContext.save()
                } catch let error as NSError{
                    print("Error occurred while saving fetched results controller data after deletion.  \(error), \(error.userInfo)")
                }
                
                DispatchQueue.main.sync {
                    self.tableView.reloadData()
                }
            }
            
            
        }
    }
    
   
    
    
}



extension SavedGameController{
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        //Retrieve the GameSession information corresponding to the selected row 
        
        let gameSession = fetchedResultsController.object(at: indexPath)
        
        //Instantatied a SavedGameDetailViewController from the GameSession data
        
        let savedGameDetailVC = configureSavedGameDetailViewController(fromGameSession: gameSession)
        
    
        present(savedGameDetailVC, animated: false, completion: nil)
    }

    
    
    func configureTableViewCell(forTableViewCell cell: inout UITableViewCell, withGameSessionDataFrom gameSession: GameSession){
        
        
        let planeColorText = gameSession.planeColor ?? "Red"
        
        cell.textLabel?.text = "Player Color: \(planeColorText)"


        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        let dateString = dateFormatter.string(from: gameSession.dateSaved as! Date)
        
        cell.detailTextLabel?.text = dateString
        
        
    }
    
    //MARK: ******** Helper Function for instantiating and configuring a SavedGameDetail ViewController
    
    
    func configureSavedGameDetailViewController(fromGameSession gameSession: GameSession) -> SavedGameDetailViewController{
        
        //Instantatied a SavedGameDetailViewController from the GameSaver storyboard
        
        let gameSaverStoryboard = UIStoryboard(name: "GameSaver", bundle: nil)
        
        let savedGameDetailVC = gameSaverStoryboard.instantiateInitialViewController() as! SavedGameDetailViewController
        
        
        //Configure a ReloadData configuraton object in order to pass the saved game data to the saved game detail view controller
        
        let reloadData = getReloadData(fromGameSession: gameSession)
        
        savedGameDetailVC.reloadData = reloadData
        savedGameDetailVC.saveDate = gameSession.dateSaved as Date?
        
        return savedGameDetailVC
    }
    
    /** Return a ReloadData configuration object for a given GameSession **/
    
    func getReloadData(fromGameSession gameSession: GameSession) -> ReloadData?{
        guard let sceneName = gameSession.scene, let letterScene = LetterScene(rawValue: sceneName) else {
            print("Error: no scene name set for the game session at the selected row")
            return nil
        }
        
        guard let planeColorString = gameSession.planeColor, let planeColor = Player.PlaneColor(rawValue: planeColorString) else {
            print("Error: failed to instantiated a plane color enum object for the given plane color string")
            return nil
        }
        
        let bronzeCoinCount = Int(gameSession.bronzeCoinCount)
        let silverCoinCount = Int(gameSession.silverCoinCount)
        let goldCoinCount = Int(gameSession.goldCoinCount)
        let healthLevel = Int(gameSession.playerHealth)
        
        let positionX = gameSession.playerXPos
        let positionY = gameSession.playerYPos
        
        let velocityX = gameSession.playerXVelocity
        let velocityY = gameSession.playerYVelocity
        
        let damageStatus = gameSession.isDamaged
        
        return ReloadData(letterScene: letterScene, planeColor: planeColor, playerXPos: positionX, playerYPos: positionY, playerXVelocity: velocityX, playerYVelocity: velocityY, playerHealth: healthLevel, playerGoldCoins: goldCoinCount, playerSilverCoins: silverCoinCount, playerBronzeCoins: bronzeCoinCount, isDamaged: damageStatus)
        
    }
   
    //MARK::    ********** Restrictions on User-Interface Orientations (restrict the SaveGameController to portrait mode)
    
    
    override var supportedInterfaceOrientations:UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        return .portrait
    }
    
    
}


//MARK: ******** NSFetchedResultsControllerDelegate

extension SavedGameController: NSFetchedResultsControllerDelegate{
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type{
        case .delete:
            let alertController = UIAlertController(title: "Game Deleted", message: "The previously saved game has been deleted", preferredStyle: .actionSheet)
            
            let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
            
            alertController.addAction(okayAction)
            
            present(alertController, animated: true, completion: nil)
            
            break
        default:
            break
        }
    }
    
    
    
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
