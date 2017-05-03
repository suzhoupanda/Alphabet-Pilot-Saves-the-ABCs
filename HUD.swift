//
//  HUD.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/3/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

/** HUD singleton manages the HUD, which consists of a collection of full and half-full hearts representing the player's health level
 
 **/

class HUD{
    
    static let main = HUD()
    
    private var heartDisplay: SKSpriteNode?
    
    init(){
        
        if let sksHeartDisplay = SKScene(fileNamed: "OverlayButtons")?.childNode(withName: "HeartDisplay") as? SKSpriteNode {
        
            heartDisplay = sksHeartDisplay
        }
        
    }
    
    
}
