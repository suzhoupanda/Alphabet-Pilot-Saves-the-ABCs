//
//  PlayerVelocityRange.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/2/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation

enum PlayerVelocityCategory: Int{
    case None, Low, Medium, High
    
    //MARK: ********** Custom Initializer
    
    init(playerVelocityX: Int){
        
        self = PlayerVelocityCategory.getPlayerVelocityCategory(velocityX: playerVelocityX)
        
    }
    
    
    typealias VelocityRange = (min: Int, max: Int)
    
    //MARK: ******* Preconfigured Velocity Ranges
    
    static let lowVelocityRange: VelocityRange = (0, 20)
    static let mediumVelocityRange: VelocityRange = (20, 60)
    static let highVelocityRange: VelocityRange = (60, 1000)
    
    
    //MARK: ********* Helper Function for Calculating Velocity Range from Velocity(dx)
    
    static func getPlayerVelocityCategory(velocityX: Int) -> PlayerVelocityCategory{
        
        if(isLowVelocity(velocityX: velocityX)){
            return .Low
        }
        
        if(isMediumVelocity(velocityX: velocityX)){
            return .Medium
        }
        
        if(isHighVelocity(velocityX: velocityX)){
            return .High
        }
        
        return .None
    }
    
    //MARK: ********* Boolean Tests for Velocity Range
    
    static func isLowVelocity(velocityX: Int) -> Bool{
        return  velocityX >= PlayerVelocityCategory.lowVelocityRange.min &&
            velocityX < PlayerVelocityCategory.lowVelocityRange.max
    }
    
    static func isMediumVelocity(velocityX: Int) -> Bool{
        return  velocityX >= PlayerVelocityCategory.mediumVelocityRange.min &&
            velocityX < PlayerVelocityCategory.mediumVelocityRange.max
    }
    
    static func isHighVelocity(velocityX: Int) -> Bool{
        return  velocityX >= PlayerVelocityCategory.highVelocityRange.min &&
            velocityX < PlayerVelocityCategory.highVelocityRange.max
    }

    //MARK: ********* Overload Equivalence Operators
    
    static func ==(lhs: PlayerVelocityCategory, rhs: PlayerVelocityCategory) -> Bool{
    
        return lhs.rawValue == rhs.rawValue
    }
    
    static func !=(lhs: PlayerVelocityCategory, rhs: PlayerVelocityCategory) -> Bool{
        return !(lhs == rhs)
    
    }

}
