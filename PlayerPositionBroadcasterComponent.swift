//
//  PlayerPositionBroadcasterComponent.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/1/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

/** Certain enemies (e.g. falling rocks, gravity fields, turbulence and wind, etc.) will have handlers for player position notifications. When the player sends these notifications, enemies with the appropriate listeners are activated
 
 
 **/

class PlayerPositionBroadcasterComponent: GKComponent{
    
    var node: SKSpriteNode?
    var currentBroadcastRangeB: BroadcastRangeB = .NoRange(lower: -10, upper: -10)
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        guard let playerNode = self.node else {
            print("Error: PlayerNode must be available in order for position broadcasting to be enabled")
            return }
        
        let playerXPos = Int(playerNode.position.x)
        
        let checkedRangeB = BroadcastRangeB.getPositionRangeI(forPlayerPosition: playerXPos)
        print("The player is currently in the checked range with lower boundary: \(checkedRangeB.getLowerBoundary()), and with upper boundary: \(checkedRangeB.getUpperBoundary())")

        print("Comparing the player's current range with the previous range...")
        if(checkedRangeB != .NoRange(lower: -10, upper: -10) && checkedRangeB != currentBroadcastRangeB){
        
            
            //If the checked range is not .NoRange, it must have an upper and lower boundary
            let (minBoundary, maxBoundary) = BroadcastRangeB.getLowerAndUpperBoundariesForRangeI(rangeI: checkedRangeB)!
            
            let userInfo = ["minBoundary": minBoundary, "maxBoundary": maxBoundary]
        
            print("Sending player range notificaiton...")
            
            NotificationCenter.default.post(name: Notification.Name.PlayerEnteredPredefinedRange, object: nil, userInfo: userInfo)
        }
        
        currentBroadcastRangeB = checkedRangeB
    }
    
   
    
    override func didAddToEntity() {
        node = entity?.component(ofType: RenderComponent.self)?.node
    }
    
    override func willRemoveFromEntity() {
        node = nil
    }
}


//MARK: ************ Nested Types

extension PlayerPositionBroadcasterComponent{
    
    
    enum BroadcastingRangeA: Int{
        case Range1 = 0, Range2, Range3, Range4, Range5
        case Range6, Range7, Range8, Range9
        case Range10, Range11, Range12, Range13, Range14, Range15
        case Range16, Range17, Range18, Range19, Range20
        
        static let MaximumTotalDistance: Int = 4000
        
        static let allRanges: [BroadcastingRangeA] = [
            .Range1, .Range2, .Range3, .Range4, .Range5,
            .Range6, .Range7, .Range8, .Range9, .Range10,
            .Range11, .Range12, .Range13, .Range14, .Range15,
            .Range16, .Range17, .Range18, .Range19, .Range20
        ]
        
        
        func getUpperAndLowerBoundariesForRange(broadCastRangeA: BroadcastingRangeA) -> (min: Int, max: Int){
            
            let rangeSize = BroadcastingRangeA.MaximumTotalDistance/BroadcastingRangeA.allRanges.count
           
            let minBoundary = (broadCastRangeA.rawValue)*rangeSize
            let maxBoundary = (broadCastRangeA.rawValue)*rangeSize + rangeSize
            
            return (minBoundary, maxBoundary)
        }
    }
    
    enum BroadcastRangeB{
        case NoRange(lower: Int, upper: Int)
        case Range1(lower: Int, upper: Int)
        case Range2(lower: Int, upper: Int)
        case Range3(lower: Int, upper: Int)
        case Range4(lower: Int, upper: Int)
        case Range5(lower: Int, upper: Int)
        case Range6(lower: Int, upper: Int)
        case Range7(lower: Int, upper: Int)
        case Range8(lower: Int, upper: Int)
        case Range9(lower: Int, upper: Int)
        case Range10(lower: Int, upper: Int)
        
        
        func getLowerBoundary() -> Int{
            switch self{
                case .NoRange(let lower, _):
                    return lower
                case .Range1(let lower, _):
                    return lower
                case .Range2(let lower, _):
                    return lower
                case .Range3(let lower, _):
                return lower
                case .Range4(let lower, _):
                    return lower
                case .Range5(let lower, _):
                    return lower
                case .Range6(let lower,  _):
                    return lower
                case .Range7(let lower, _):
                    return lower
                case .Range8(let lower, _):
                    return lower
                case .Range9(let lower, _):
                    return lower
                case .Range10(let lower, _):
                    return lower
               
            }
        }
        
        
        func getUpperBoundary() -> Int{
            switch self{
            case .NoRange(_, let upper):
                return upper
            case .Range1(_ , let upper):
                return upper
            case .Range2(_ , let upper):
                return upper
            case .Range3(_ , let upper):
                return upper
            case .Range4(_ , let upper):
                return upper
            case .Range5(_ , let upper):
                return upper
            case .Range6(_ ,  let upper):
                return upper
            case .Range7(_ , let upper):
                return upper
            case .Range8(_, let upper):
                return upper
            case .Range9(_ , let upper):
                return upper
            case .Range10(_ , let upper):
                return upper
            }
        }
        
        static let allRangesI: [BroadcastRangeB] = [
            .NoRange(lower: -10, upper: -10),
            .Range1(lower: 0,upper: 300),
            .Range2(lower: 300,upper: 600),
            .Range3(lower: 600,upper: 900),
            .Range4(lower: 900, upper: 1200),
            .Range5(lower: 1200, upper: 1500),
            .Range6(lower: 1500, upper: 1800),
            .Range7(lower: 1800, upper: 2100),
            .Range8(lower: 2100, upper: 2400),
            .Range9(lower: 2400, upper: 2700),
            .Range10(lower: 2700, upper: 3000)
        ]
        
        static let allRangesII: [BroadcastRangeB] = [
            .NoRange(lower: -10, upper: -10),
            .Range1(lower: 0,upper: 100),
            .Range2(lower: 100,upper: 200),
            .Range3(lower: 200,upper: 300),
            .Range4(lower: 300, upper: 400),
            .Range5(lower: 400, upper: 500),
            .Range6(lower: 500, upper: 600),
            .Range7(lower: 600, upper: 700),
            .Range8(lower: 700, upper: 800),
            .Range9(lower: 800, upper: 900),
            .Range10(lower: 900, upper: 1000)
        ]
        
        
        
        static func getLowerAndUpperBoundariesForRangeI(rangeI: BroadcastRangeB) -> (lower: Int, upper: Int)?{
            
            for range in allRangesI{
                switch range{
                    case .Range1(let lower, let upper):
                        return (lower, upper)
                    case .Range2(let lower, let upper):
                        return (lower, upper)
                    case .Range3(let lower, let upper):
                        return (lower, upper)
                    case .Range4(let lower, let upper):
                        return (lower, upper)
                    case .Range5(let lower, let upper):
                        return (lower, upper)
                    case .Range6(let lower, let upper):
                        return (lower, upper)
                    case .Range7(let lower, let upper):
                    return (lower, upper)
                    case .Range8(let lower, let upper):
                        return (lower, upper)
                    case .Range9(let lower, let upper):
                        return (lower, upper)
                    case .Range10(let lower, let upper):
                        return (lower, upper)
                    case .NoRange:
                        return nil
                }
            }
            
            return nil
        }
        
        static func getPositionRangeI(forPlayerPosition position: Int) -> BroadcastRangeB{
            for range in BroadcastRangeB.allRangesI{
                
                switch(range){
                case .Range1(let lower, let upper):
                    if(positionIsWithinRange(testPosition: position, lower: lower, upper: upper)) { return range }
                    break
                case .Range2(let lower, let upper):
                    if(positionIsWithinRange(testPosition: position, lower: lower, upper: upper)) { return range }
                    break
                case .Range3(let lower, let upper):
                    if(positionIsWithinRange(testPosition: position, lower: lower, upper: upper)) { return range }
                    break
                case .Range4(let lower, let upper):
                    if(positionIsWithinRange(testPosition: position, lower: lower, upper: upper)) { return range }
                    break
                case .Range5(let lower, let upper):
                    if(positionIsWithinRange(testPosition: position, lower: lower, upper: upper)) { return range }
                    break
                case .Range6(let lower, let upper):
                    if(positionIsWithinRange(testPosition: position, lower: lower, upper: upper)) { return range }
                    break
                case .Range7(let lower, let upper):
                    if(positionIsWithinRange(testPosition: position, lower: lower, upper: upper)) { return range }
                    break
                case .Range8(let lower, let upper):
                    if(positionIsWithinRange(testPosition: position, lower: lower, upper: upper)) { return range }
                    break
                case .Range9(let lower, let upper):
                    if(positionIsWithinRange(testPosition: position, lower: lower, upper: upper)) { return range }
                    break
                case .Range10(let lower, let upper):
                    if(positionIsWithinRange(testPosition: position, lower: lower, upper: upper)) { return range }
                    break
                default:
                    return .NoRange(lower: -10 , upper: -10)
                }
            }
            
            return .NoRange(lower: -10, upper: -10)
        }
        
        
        //MARK: ****** HELPER FUNCTIONS *****************
        
        //MARK: Check wehther a certain position falls within a given range
        

        static private func positionIsWithinRange<T: Comparable>(testPosition: T, lower: T, upper: T) -> Bool{
            return testPosition >= lower && testPosition < upper
        }
        
        //MARK: Overload the equivalence operators for this enum, since it uses associated values and not raw values
        
        static func ==(lhs: BroadcastRangeB, rhs: BroadcastRangeB) -> Bool{
            return lhs.getLowerBoundary() == rhs.getLowerBoundary() && lhs.getUpperBoundary() == rhs.getUpperBoundary()
        }
        
        static func !=(lhs: BroadcastRangeB, rhs: BroadcastRangeB) -> Bool{
            return !(lhs == rhs)
        }
    }

}
