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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameSessionCell", for: indexPath)
        
        let gameSession = savedGames[indexPath.row]
        
        cell.textLabel?.text = gameSession.scene
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        let dateString = dateFormatter.string(from: gameSession.dateSaved as! Date)
        
        cell.detailTextLabel?.text = dateString
    
        
        return cell
    }
    
}



extension SavedGameController{
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let gameSession = savedGames[indexPath.row]
        
        let gameSaverStoryboard = UIStoryboard(name: "GameSaver", bundle: nil)
        
        let savedGameDetailVC = gameSaverStoryboard.instantiateInitialViewController() as! SavedGameDetailViewController
        
        print("You are about to see detail information for the scene: \(gameSession.scene)")
        
        
        savedGameDetailVC.sceneLabelText = gameSession.scene
        
        savedGameDetailVC.bronzeCoinCount = Int(gameSession.bronzeCoinCount)
        savedGameDetailVC.silverCoinCount = Int(gameSession.silverCoinCount)
        savedGameDetailVC.goldCoinCount = Int(gameSession.goldCoinCount)
        
        
        savedGameDetailVC.saveDate = gameSession.dateSaved as Date?
        savedGameDetailVC.healthLevel = Int(gameSession.playerHealth)
        
        savedGameDetailVC.planeColorText = gameSession.planeColor
    
        
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 2
        
        let positionX = gameSession.playerXPos 
        let positionY = gameSession.playerYPos
        
        let formattedPositionX = numberFormatter.string(from: NSNumber(value: positionX))!
        let formattedPositionY = numberFormatter.string(from: NSNumber(value: positionY))!
        
        savedGameDetailVC.xPositionText = "X-Position \(formattedPositionX)"
        savedGameDetailVC.yPositionText = "Y-Position: \(formattedPositionY)"
        
        let velocityX = gameSession.playerXVelocity
        let velocityY = gameSession.playerYVelocity
        
        let formattedVelocityX = numberFormatter.string(from: NSNumber(value: velocityX))!
        let formattedVelocityY = numberFormatter.string(from: NSNumber(value: velocityY))!
        
        savedGameDetailVC.xVelocityText = "X-Velocity: \(formattedVelocityX)"
        savedGameDetailVC.yVelocityText = "Y-Velocity: \(formattedVelocityY)"
        
        savedGameDetailVC.damageStatus = gameSession.isDamaged
        
    
        present(savedGameDetailVC, animated: false, completion: nil)
    }

    
   
    
}
