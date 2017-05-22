//
//  HelpTopicsHelper.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/22/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation


class HelpTopicsHelper{
    
    typealias QuestionAnswerSet = [String:String]
    
    enum HelpTopicsKey: Int{
        case Collectibles = 0
        case Enemies
        case Player
        case GameRules
        
        
        init(fromString stringEquivalent: String){
            
            switch stringEquivalent{
                case "Coins and Collectibles":
                    self = .Collectibles
                    break
                case "Enemies":
                    self = .Enemies
                case "Game Rules":
                    self = .GameRules
                case "Player Information":
                    self = .Player
                default:
                    self = .GameRules
            }
            
           
            
            
            
        }
        
        func getHelpTopicTitle() -> String{
            
            switch self{
                case .Collectibles:
                    return "Coins and Collectibles"
                case .Enemies:
                    return "Enemies"
                case .GameRules:
                    return "Game Rules"
                case .Player:
                    return "Player Information"
                
            }
        }
        
    }
    
    static let shareHelper = HelpTopicsHelper()
    
    private var helpTopicsDict = [String: [[String:String]]]()
    
    private var modifiedHelpTopicsDict = [HelpTopicsKey: [QuestionAnswerSet]]()
    
    private init(){
        let path = Bundle.main.path(forResource: "HelpTopics", ofType: "plist")!
        
        if let dict = NSDictionary(contentsOfFile: path) as? [String: [[String:String]]]{
            helpTopicsDict = dict
            
            for (key,value) in dict{
                let helpTopicKey = HelpTopicsKey(fromString: key)
                modifiedHelpTopicsDict[helpTopicKey] = value
                
            }
        }
    }
    
    func getHelpTopicsDictionary() -> [String: [[String:String]]]{
        return helpTopicsDict
    }
    
    func getQASet(forHelpTopicKey helpTopicKey: HelpTopicsKey) -> [QuestionAnswerSet]{
        
    
        return modifiedHelpTopicsDict[helpTopicKey]!
        
    }
}
