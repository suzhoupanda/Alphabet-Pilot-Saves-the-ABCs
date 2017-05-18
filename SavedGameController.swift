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
    
    var managedContext: NSManagedObjectContext!
    
    var savedGames = [GameSession]()
    
    @IBAction func returnToSavedGameMenu(savedGameSegue: UIStoryboardSegue){
        
        
    }
  
}


extension SavedGameController{
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return savedGames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "GameSessionCell", for: indexPath)
        
        let gameSession = savedGames[indexPath.row]
        
        configureTableViewCell(forTableViewCell: &cell, withGameSessionDataFrom: gameSession)
        
        return cell
    }
    
}



extension SavedGameController{
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        //Retrieve the GameSession information corresponding to the selected row 
        
        let gameSession = savedGames[indexPath.row]
        
        //Instantatied a SavedGameDetailViewController from the GameSession data
        
        let savedGameDetailVC = configureSavedGameDetailViewController(fromGameSession: gameSession)
        
    
        present(savedGameDetailVC, animated: false, completion: nil)
    }

    
    
    func configureTableViewCell(forTableViewCell cell: inout UITableViewCell, withGameSessionDataFrom gameSession: GameSession){
        
        cell.textLabel?.text = gameSession.scene
        
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
   
    override var supportedInterfaceOrientations:UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        return .portrait
    }
    
    override var shouldAutorotate: Bool{
        return false
    }
}
