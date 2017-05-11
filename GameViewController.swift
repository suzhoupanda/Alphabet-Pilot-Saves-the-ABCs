//
//  GameViewController.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/1/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    let mainMotionManager = MainMotionManager.sharedMotionManager
    
    
    var levelViewController: LevelViewController!
   
    var gameHasStarted: Bool = false
    var sksFileName: String!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        registerForNotifications()
        
        if !gameHasStarted{
            
            let levelViewLayout = UICollectionViewFlowLayout()
            levelViewLayout.scrollDirection = .horizontal
            levelViewLayout.itemSize = CGSize(width: view.bounds.width*0.30, height: view.bounds.height*0.90)
           // levelViewLayout.minimumInteritemSpacing = view.bounds.width*0.05
           // levelViewLayout.minimumLineSpacing = view.bounds.height*0.05
            
            levelViewController = LevelViewController(collectionViewLayout: levelViewLayout)
            levelViewController.view.backgroundColor = UIColor.GetCustomColor(customColor: .SharkFinWhite)
            levelViewController.collectionView?.backgroundColor = UIColor.GetCustomColor(customColor: .SharkFinWhite)
            
            present(levelViewController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
   
        view.backgroundColor = UIColor(colorLiteralRed: Float(31/255), green: Float(103/255), blue: Float(108/255), alpha: 1.0)
        
        
 
        
    }
    
    func registerForNotifications(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.startGame(notification:)), name: Notification.Name.LevelChosenNotification, object: nil)
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func startGame(notification: Notification){
        
        if let levelSceneMetaData = notification.object as? LevelSceneMetaData{
            
            levelViewController.dismiss(animated: true, completion: {
                
                
                    UIDevice.current.beginGeneratingDeviceOrientationNotifications()
                    
                    self.mainMotionManager.startDeviceMotionUpdates()
                    self.mainMotionManager.deviceMotionUpdateInterval = 0.50
                    
                    let skView = self.view as! SKView
                    
                    let screenSize = UIScreen.main.bounds.size
                    
                    /**
                     let planeScene1 = BaseScene(sksFileName: "PlaneScene1", size: screenSize)
                     let metalScene2 = BaseScene(sksFileName: "MetalScene2", size: screenSize)
                     **/
                    
                    let sceneName = levelSceneMetaData.sksFile
                    
                    let selectedScene = BaseScene(sksFileName: sceneName, size: screenSize)
                    skView.presentScene(selectedScene)

                
                
                
            
            })
            
            
            
        }
    }
   
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
