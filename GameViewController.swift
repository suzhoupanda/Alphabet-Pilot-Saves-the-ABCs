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

  
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    
       // view.backgroundColor = UIColor(colorLiteralRed: 2.0/255.0, green: 237.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        
       
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
   
        //view.backgroundColor = UIColor(colorLiteralRed: Float(31/255), green: Float(103/255), blue: Float(108/255), alpha: 1.0)
        
        
   
        
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
