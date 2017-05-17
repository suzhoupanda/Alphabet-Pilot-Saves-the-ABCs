//
//  SavedGameDetailViewController.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/13/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import UIKit


class SavedGameDetailViewController: UIViewController{
    
    
    
    //MARK: ******** Scene Name
    
    @IBOutlet weak var sceneNameLabel: UILabel!
   
    
    //MARK: ******* Date Saved Info
    
    @IBOutlet weak var datePicker: UIDatePicker!
   
    
    //MARK: ******** Plane Type
    
    @IBOutlet weak var planeColorSegmentedControl: UISegmentedControl!
    
    
    //MARK: ****** Player Coin Count Information
    
    @IBOutlet weak var bronzeCountLabel: UILabel!
    
    @IBOutlet weak var silverCountLabel: UILabel!
    
    @IBOutlet weak var goldCountLabel: UILabel!
    
    //MARK: ****** Player Health State Information
    
  
    @IBOutlet weak var damageStatusSwitch: UISwitch!
    
    
    @IBOutlet weak var healthSegmentedControl: UISegmentedControl!
    
    
    //MARK: ****** Player Position Information
    
    @IBOutlet weak var xPositionLabel: UILabel!
 
    @IBOutlet weak var yPositionLabel: UILabel!
    
    @IBAction func loadSavedGame(_ sender: UIBarButtonItem) {
        
        let currentVerticalSizeClass = traitCollection.verticalSizeClass
        
        let longSide = currentVerticalSizeClass == .compact ? view.bounds.size.width : view.bounds.size.height
        
        let shortSide = currentVerticalSizeClass == .compact ? view.bounds.size.height : view.bounds.size.height
        
        let aspectRatio = shortSide/longSide
        
        let itemWidth = longSide*0.50
        let itemHeight = itemWidth*aspectRatio*1.5
        
        let levelViewLayout = UICollectionViewFlowLayout()
        levelViewLayout.scrollDirection = .horizontal
        levelViewLayout.sectionInset = UIEdgeInsets(top: 0.00, left: 20.00, bottom: 0.00, right: 20.00)
        levelViewLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        
        
        ///Initialize LevelViewController
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let levelViewController = LevelViewController(collectionViewLayout: levelViewLayout)
        
        levelViewController.view.backgroundColor = UIColor.GetCustomColor(customColor: .SharkFinWhite)
        
        levelViewController.managedContext = managedContext
        levelViewController.collectionView?.backgroundColor = UIColor.GetCustomColor(customColor: .SharkFinWhite)
        
        let reloadData = ReloadData(letterScene: .LetterA_Scene, planeColor: .Blue, playerXPos: 4000.00, playerYPos: -200.0, playerXVelocity: 50.0, playerYVelocity: 12.0, playerHealth: 3, playerGoldCoins: 1, playerSilverCoins: 1, playerBronzeCoins: 1)
        
        present(levelViewController, animated: true, completion: {
            
            
            levelViewController.reloadSavedGame(reloadData: reloadData)
            
        })
        
       /**
        if let goldCoinCount = goldCoinCount, let silverCoinCount = silverCoinCount, let bronzeCoinCount = bronzeCoinCount, let xVelocity = xVelocityValue, let yVelocity = yVelocityValue, let xPos = xPosValue, let yPos = yPosValue, let sceneLabelText = sceneLabelText,  let letterScene = LetterScene(rawValue: sceneLabelText), let planeColorString = planeColor, let playerPlaneColor = Player.PlaneColor(rawValue: planeColorString), let healthLevel = healthLevel{
            
            
            let reloadData = ReloadData(letterScene: letterScene, planeColor: playerPlaneColor, playerXPos: xPos, playerYPos: yPos, playerXVelocity: xVelocity, playerYVelocity: yVelocity, playerHealth: healthLevel, playerGoldCoins: goldCoinCount, playerSilverCoins: silverCoinCount, playerBronzeCoins: bronzeCoinCount)
            
            present(levelViewController, animated: true, completion: {
                
                
                levelViewController.reloadSavedGame(reloadData: reloadData)
                
                })
            
        }
        **/
     
        
    }
    
    //MARK: ******* Player Velocity Information
    
    @IBOutlet weak var xVelocity: UILabel!
 
    @IBOutlet weak var yVelocity: UILabel!
    
    
    //Optional variables for storing data used to populate corresponding UIElements on the storyboard file
    
    var sceneLabelText: String?
    var planeColor: String?
    
    var saveDate: Date?
    
    var goldCoinCount: Int?
    var silverCoinCount: Int?
    var bronzeCoinCount: Int?
    
    var damageStatus: Bool?
    
    var healthLevel: Int?
    var planeColorText: String?
    
    var xPositionText: String?
    var yPositionText: String?
    
    var xVelocityText: String?
    var yVelocityText: String?
    
    var xVelocityValue: Double?
    var yVelocityValue: Double?
    var xPosValue: Double?
    var yPosValue: Double?
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadSavedGameInformation()
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        super.didMove(toParentViewController: parent)
        
        
    }
    
    
    func loadSavedGameInformation(){
        if let sceneLabelText = sceneLabelText{
            sceneNameLabel.text = sceneLabelText
        }
        
        if let planeColorText = planeColorText{
            for index in 0..<planeColorSegmentedControl.numberOfSegments{
                
                if planeColorSegmentedControl.titleForSegment(at: index) == planeColorText{
                    planeColorSegmentedControl.selectedSegmentIndex = index
                }
            }
        }
        
        if let saveDate = saveDate{
            datePicker.date = saveDate
        }
        
        
        if let bronzeCoinCount = bronzeCoinCount, let silverCoinCount = silverCoinCount, let goldCoinCount = goldCoinCount{
            
            bronzeCountLabel.text = "Bronze: \(bronzeCoinCount)"
            silverCountLabel.text = "Silver: \(silverCoinCount)"
            goldCountLabel.text = "Gold: \(goldCoinCount)"
            
        }
        
        
        if let damageStatus = damageStatus{
            damageStatusSwitch.isOn = damageStatus
            
        }
        
        if let yVelocityText = yVelocityText, let xVelocityText = xVelocityText{
            
            xVelocity.text = xVelocityText
            yVelocity.text = yVelocityText
        }
        
        if let xPositionText = xPositionText, let yPositionText = yPositionText{
            xPositionLabel.text = xPositionText
            yPositionLabel.text = yPositionText
        }
        
        
        if let healthLevel = healthLevel{
            healthSegmentedControl.selectedSegmentIndex = healthLevel
        }
        
    }
    
    
}
