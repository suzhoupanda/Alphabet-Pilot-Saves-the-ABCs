//
//  HelpTopicsController.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/22/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import UIKit

class HelpTopicsController: UITableViewController{
    
    typealias QuestionAnswerSet = [[String:String]]
    
    let helpTopicsHelper = HelpTopicsHelper.shareHelper
    
    var selectedQuestionAnswerSet: QuestionAnswerSet?
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        return .portrait
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "HelpTopicCell")
    }
    
    
    
    
}


//MARK: Table data source methods

extension HelpTopicsController{
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let helpTopics = helpTopicsHelper.getHelpTopicsDictionary().keys
        
        return helpTopics.count
        
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HelpTopicCell")! as UITableViewCell
        
        let helpTopicKey = HelpTopicsHelper.HelpTopicsKey(rawValue: indexPath.row)
        
        
        cell.textLabel?.text = helpTopicKey?.getHelpTopicTitle()
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let helpTopicKey = HelpTopicsHelper.HelpTopicsKey(rawValue: indexPath.row)

        let questionAnswerSet = helpTopicsHelper.getQASet(forHelpTopicKey: helpTopicKey!)
        
        selectedQuestionAnswerSet = questionAnswerSet
        
        if let selectedQASet = selectedQuestionAnswerSet{
         
            let helpTopicsDetailController = HelpDetailController()
            helpTopicsDetailController.QASet = selectedQASet
            helpTopicsDetailController.modalPresentationStyle = .popover
            
            
            present(helpTopicsDetailController, animated: true, completion: nil)
            
        }

    }
    

   
    
    
}
