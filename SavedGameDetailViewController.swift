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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadSaveGameInformation()
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        super.didMove(toParentViewController: parent)
        
        
    }
    
    
    func loadSaveGameInformation(){
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
