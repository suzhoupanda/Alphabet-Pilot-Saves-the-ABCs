//
//  PlayerData.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/14/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation

let kPlayerVelocityXKey = "playerVelocityXKey"
let kPlayerVelocityYKey = "playerVelocityYKey"

let kPlayerPositionXKey = "playerPositionXKey"
let kPlayerPositionYKey = "playerPositionYKey"

class PlayerVelocity: NSObject, NSCoding{
    
    let playerVelocityX: Double
    let playerVelocityY: Double
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(playerVelocityX, forKey: kPlayerVelocityXKey)
        aCoder.encode(playerVelocityY, forKey: kPlayerVelocityYKey)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.playerVelocityX = aDecoder.decodeDouble(forKey: kPlayerVelocityXKey)
        self.playerVelocityY = aDecoder.decodeDouble(forKey: kPlayerVelocityYKey)
    }
    
    init(xVelocity: Double, yVelocity: Double){
        playerVelocityY = yVelocity
        playerVelocityX = xVelocity
    }
}


class PlayerPosition: NSObject, NSCoding{
    
    let playerPositionX: Double
    let playerPositionY: Double
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(playerPositionX, forKey: kPlayerPositionXKey)
        aCoder.encode(playerPositionY, forKey: kPlayerVelocityYKey)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.playerPositionX = aDecoder.decodeDouble(forKey: kPlayerPositionXKey)
        self.playerPositionY = aDecoder.decodeDouble(forKey: kPlayerPositionYKey)
    }
    
    init(xPosition: Double, yPosition: Double){
        playerPositionY = yPosition
        playerPositionX = xPosition
    }
}
