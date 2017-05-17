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
    
    var letterScene: LetterScene?
    
    var screenRecorderHelper = ScreenRecorderHelper.sharedHelper
    
    var reloadData: ReloadData?
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        registerForNotifications()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        screenRecorderHelper.presentingViewController = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        screenRecorderHelper.presentingViewController = self
        
        if let skView = self.view as! SKView?, let letterScene = letterScene, let reloadData = reloadData{
            
            //Initialize the base scene based on the value of the letterScene property for the GameSceneView controller
            
            let baseScene: BaseScene = GameSceneController.GetSceneForLetterSceneType(letterScene: letterScene, reloadData: reloadData)
            

            skView.presentScene(baseScene)
        
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

extension GameSceneController{
    
    
    static func GetSceneForLetterSceneType(letterScene: LetterScene, reloadData: ReloadData?) -> BaseScene{
        
        let screenSize = UIScreen.main.bounds.size
        
        var baseScene: BaseScene = LetterA_Scene(size: screenSize, reloadData: reloadData)
        
        
        switch letterScene{
        case .LetterA_Scene:
            baseScene = LetterA_Scene(size: screenSize, reloadData: reloadData)
            break
        case .LetterB_Scene:
            baseScene = LetterB_Scene(size: screenSize, reloadData: reloadData)
            break
        case .LetterC_Scene:
            baseScene = LetterC_Scene(size: screenSize, reloadData: reloadData)
            break
        case .LetterD_Scene:
            baseScene = LetterD_Scene(size: screenSize, reloadData: reloadData)
            break
        case .LetterE_Scene:
            baseScene = LetterE_Scene(size: screenSize, reloadData: reloadData)
            break
        case .LetterF_Scene:
            baseScene = LetterF_Scene(size: screenSize, reloadData: reloadData)
            break
        case .LetterG_Scene:
            baseScene = LetterG_Scene(size: screenSize, reloadData: reloadData)
            break
        case .LetterH_Scene:
            baseScene = LetterH_Scene(size: screenSize, reloadData: reloadData)
            break
        case .LetterI_Scene:
            baseScene = LetterI_Scene(size: screenSize, reloadData: reloadData)
            break
        case .LetterJ_Scene:
            baseScene = LetterJ_Scene(size: screenSize, reloadData: reloadData)
            break
        case .LetterK_Scene:
            baseScene = LetterK_Scene(size: screenSize, reloadData: reloadData)
            break
        case .LetterL_Scene:
            baseScene = LetterL_Scene(size: screenSize, reloadData: reloadData)
            break
        case .LetterM_Scene:
            baseScene = LetterM_Scene(size: screenSize, reloadData: reloadData)
            break
        case .LetterN_Scene:
            baseScene = LetterN_Scene(size: screenSize, reloadData: reloadData)
            break
        case .LetterO_Scene:
            baseScene = LetterO_Scene(size: screenSize, reloadData: reloadData)
            break
        case .LetterP_Scene:
            baseScene = LetterP_Scene(size: screenSize, reloadData: reloadData)
            break
        case .LetterQ_Scene:
            baseScene = LetterQ_Scene(size: screenSize, reloadData: reloadData)
            break
        case .LetterR_Scene:
            baseScene = LetterR_Scene(size: screenSize, reloadData: reloadData)
            break
        case .LetterS_Scene:
            baseScene = LetterS_Scene(size: screenSize, reloadData: reloadData)
            break
        case .LetterT_Scene:
            baseScene = LetterT_Scene(size: screenSize, reloadData: reloadData)
            break
        case .LetterU_Scene:
            baseScene = LetterU_Scene(size: screenSize, reloadData: reloadData)
            break
        case .LetterV_Scene:
            baseScene = LetterV_Scene(size: screenSize, reloadData: reloadData)
            break
        case .LetterW_Scene:
            baseScene = LetterW_Scene(size: screenSize, reloadData: reloadData)
            break
        case .LetterX_Scene:
            baseScene = LetterX_Scene(size: screenSize, reloadData: reloadData)
            break
        case .LetterZ_Scene:
            baseScene = LetterZ_Scene(size: screenSize, reloadData: reloadData)
            break
            
        default:
            break
        }
        
        return baseScene
    }

    
}
