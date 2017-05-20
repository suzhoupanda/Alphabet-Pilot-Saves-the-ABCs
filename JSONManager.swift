//
//  JSONManager.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/20/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation


let kGameWinLossKey = "Game Win/Loss Conditions"
let kEnemiesInfoKey = "Enemies Information"
let kPlayerMovementInfoKey = "Player Movement Information"
let kOtherFAQKey = "Other Frequently Asked Questions"

class JSONManager{
    
    typealias QASet = [String: String]
    
    static let sharedHelper = JSONManager()
    
    private var helpTopics: [String]?
    
    private var enemyQASets: [QASet]?
    private var otherFAQSets: [QASet]?
    private var playerMovementQASets: [QASet]?
    private var gameWinLossQASets: [QASet]?
    
    
    private init(){
        loadJSONData()
        printJSONData()
    }
    
    func loadJSONData(){
        
        let jsonURL = Bundle.main.url(forResource: "HelpTopics", withExtension: "json")!
        let jsonData = NSData(contentsOf: jsonURL) as! Data
        
        do{
            let jsonDictionary = try JSONSerialization.jsonObject(with: jsonData, options: [.allowFragments,.mutableContainers]) as! [String:[AnyObject]]
            
            helpTopics = jsonDictionary.keys.flatMap{ return $0 }
            
            enemyQASets = jsonDictionary[kEnemiesInfoKey] as? [QASet]
            playerMovementQASets = jsonDictionary[kPlayerMovementInfoKey] as? [QASet]
            otherFAQSets = jsonDictionary[kOtherFAQKey] as? [QASet]
            gameWinLossQASets = jsonDictionary[kGameWinLossKey] as? [QASet]
            
        } catch let error as NSError{
            print("Error \(error),\(error.userInfo)")
        }
        
    }
    
    func printJSONData(){
        
        if let helpTopics = helpTopics{
            print("The help topics are: ")
            for helpTopic in helpTopics{
                print(helpTopic)
            }
        }
        
        if let enemyQASets = enemyQASets{
            printQASetInformation(questionAnswerSets: enemyQASets)
        }
        
        if let otherFAQSets = otherFAQSets{
            printQASetInformation(questionAnswerSets: otherFAQSets)
        }
        
        if let playerMovementQASets = playerMovementQASets{
            printQASetInformation(questionAnswerSets: playerMovementQASets)
        }
        
        if let gameWinLossQASets = gameWinLossQASets{
            printQASetInformation(questionAnswerSets: gameWinLossQASets)
        }
    }
    
    func printQASetInformation(questionAnswerSets: [QASet]){
        
        for questionAnswerSet in questionAnswerSets{
            
            let question = questionAnswerSet["Question"]
            let answer = questionAnswerSet["Answer"]
            
            print("Question: \(question)")
            print("Answer: \(answer)")
            
        }
    }
}
