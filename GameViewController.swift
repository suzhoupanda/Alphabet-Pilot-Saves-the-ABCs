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
    
    var sksFileName: String!
    
    convenience init(sksFileName: String) {
        self.init(nibName: nil, bundle: nil)
        self.sksFileName = sksFileName

    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let levelViewLayout = UICollectionViewFlowLayout()
        
        let levelViewController = LevelViewController(collectionViewLayout: levelViewLayout)
        
        present(levelViewController, animated: true, completion: nil)
        
      
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
 
        
    }

    func startGame(){
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        
        mainMotionManager.startDeviceMotionUpdates()
        mainMotionManager.deviceMotionUpdateInterval = 0.50
        
        
        
        let skView = self.view as! SKView
        
        let screenSize = UIScreen.main.bounds.size
        
        
        let planeScene1 = BaseScene(sksFileName: "PlaneScene1", size: screenSize)
        let metalScene2 = BaseScene(sksFileName: "MetalScene2", size: screenSize)
        
        let selectedScene = BaseScene(sksFileName: sksFileName, size: screenSize)
        skView.presentScene(selectedScene)
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
