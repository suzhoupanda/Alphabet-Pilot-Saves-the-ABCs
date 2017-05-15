//
//  GameSceneController.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/12/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class GameSceneController: UIViewController{
    
    var baseScene: BaseScene?
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        registerForNotifications()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let skView = self.view as! SKView?, baseScene != nil{
            
            skView.presentScene(baseScene!)
        
        }
    }
    
   
    
    override func didMove(toParentViewController parent: UIViewController?) {
        super.didMove(toParentViewController: parent)
        

        
        
    }
    
    func notifyPlayerOfGameSaveCompletion(notification: Notification){
        
        let alertViewController = UIAlertController(title: "Gamed Saved!", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertViewController.addAction(action)
        
        present(alertViewController, animated: false, completion: nil)
    }
    
    func registerForNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(GameSceneController.notifyPlayerOfGameSaveCompletion(notification:)), name: Notification.Name.UserRequestedGameSaveNotification, object: BaseScene.self)
        
       
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
