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
    
    
    var buttonLoadPreviousGame: UIImageView!
    var buttonStartGame: UIImageView!
    var buttonGameInfo: UIImageView!
    var buttonStackView: UIStackView!
    
    var gameTitleView: UIView!
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        view.backgroundColor = UIColor(colorLiteralRed: 2.0/255.0, green: 237.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        
       
        
        buttonLoadPreviousGame = UIImageView(image: #imageLiteral(resourceName: "blue_button00"))
        let loadPrevGameLabel = UILabel()
        loadPrevGameLabel.text = "Load Previous Game"
        loadPrevGameLabel.textAlignment = .center
        loadPrevGameLabel.textColor = UIColor.GetCustomColor(customColor: .StopSignRed)
        loadPrevGameLabel.font = UIFont(name: "Cochin-BoldItalic", size: 30.0)
        buttonLoadPreviousGame.addSubview(loadPrevGameLabel)
        
        buttonStartGame = UIImageView(image: #imageLiteral(resourceName: "blue_button00"))
        let startGameLabel = UILabel()
        startGameLabel.text = "Start Game"
        startGameLabel.font = UIFont(name: "Cochin-BoldItalic", size: 30.0)
        startGameLabel.textColor = UIColor.GetCustomColor(customColor: .StopSignRed)
        startGameLabel.textAlignment = .center
        buttonStartGame.addSubview(startGameLabel)
        
        buttonGameInfo = UIImageView(image: #imageLiteral(resourceName: "blue_button00"))
        let gameInfoLabel = UILabel()
        gameInfoLabel.text = "Game Information"
        gameInfoLabel.font = UIFont(name: "Cochin-BoldItalic", size: 30.0)
        gameInfoLabel.textAlignment = .center
        gameInfoLabel.textColor = UIColor.GetCustomColor(customColor: .StopSignRed)
        buttonGameInfo.addSubview(gameInfoLabel)
        
        buttonStackView = UIStackView(arrangedSubviews: [
            
            buttonLoadPreviousGame,
            buttonStartGame,
            buttonGameInfo
            ])
        
        
        
        gameTitleView = UIView()
        
        
        let cloudImage = UIImageView(image: #imageLiteral(resourceName: "cloud1_mixed_500"))
        cloudImage.contentMode = .scaleAspectFit
        gameTitleView.addSubview(cloudImage)
        
        let planeImage = UIImageView(image: #imageLiteral(resourceName: "planeBlue1"))
        planeImage.contentMode = .scaleAspectFit
        gameTitleView.addSubview(planeImage)
        
        cloudImage.translatesAutoresizingMaskIntoConstraints = false
        planeImage.translatesAutoresizingMaskIntoConstraints = false
        
        let gameTitle = UILabel()
        gameTitleView.addSubview(gameTitle)
        gameTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cloudImage.centerXAnchor.constraint(equalTo: gameTitleView.centerXAnchor),
            cloudImage.centerYAnchor.constraint(equalTo: gameTitleView.centerYAnchor),
            planeImage.topAnchor.constraint(equalTo: gameTitleView.topAnchor, constant: 30.0),
            planeImage.leftAnchor.constraint(equalTo: gameTitleView.leftAnchor, constant: 30.0),
            gameTitle.centerXAnchor.constraint(equalTo: gameTitleView.centerXAnchor),
            gameTitle.centerYAnchor.constraint(equalTo: gameTitleView.centerYAnchor)
            ])
        
        gameTitle.text = "Alphabet Pilot"
        gameTitle.textColor = UIColor.GetCustomColor(customColor: .StopSignRed)
        gameTitle.font = UIFont(name: "Cochin-BoldItalic", size: 40.0)
        gameTitle.textAlignment = .center
        
    
        buttonLoadPreviousGame.translatesAutoresizingMaskIntoConstraints = false
        buttonStartGame.translatesAutoresizingMaskIntoConstraints = false
        buttonGameInfo.translatesAutoresizingMaskIntoConstraints = false
        
        gameTitleView.translatesAutoresizingMaskIntoConstraints = false
        loadPrevGameLabel.translatesAutoresizingMaskIntoConstraints = false
        startGameLabel.translatesAutoresizingMaskIntoConstraints = false
        gameInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(gameTitleView)
        view.addSubview(buttonStackView)
        
        buttonStackView.alignment = .fill
        buttonStackView.axis = .vertical
        buttonStackView.distribution = .fillEqually
        
        NSLayoutConstraint.activate([
            
            gameInfoLabel.centerXAnchor.constraint(equalTo: buttonGameInfo.centerXAnchor),
            gameInfoLabel.centerYAnchor.constraint(equalTo: buttonGameInfo.centerYAnchor),
            gameInfoLabel.widthAnchor.constraint(equalTo: buttonGameInfo.widthAnchor, multiplier: 0.95),
            startGameLabel.centerYAnchor.constraint(equalTo: buttonStartGame.centerYAnchor),
            startGameLabel.centerXAnchor.constraint(equalTo: buttonStartGame.centerXAnchor),
            startGameLabel.widthAnchor.constraint(equalTo: buttonStartGame.widthAnchor, multiplier: 0.95),
            loadPrevGameLabel.centerXAnchor.constraint(equalTo: buttonLoadPreviousGame.centerXAnchor),
            loadPrevGameLabel.centerYAnchor.constraint(equalTo: buttonLoadPreviousGame.centerYAnchor),
            loadPrevGameLabel.widthAnchor.constraint(equalTo: buttonLoadPreviousGame.widthAnchor, multiplier: 0.95),
            
            buttonStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20.0),
            buttonStackView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 20.00),
            buttonStackView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -20.00),
            buttonStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.40),
            
            gameTitleView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20.0),
            gameTitleView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 30.0),
            gameTitleView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: 20.0),
            gameTitleView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.50)
            ])
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(GameViewController.transitionToLevelViewController(sender:)))
        
        buttonStackView.addGestureRecognizer(tapGestureRecognizer)
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        registerForNotifications()
   
        
        
        /**
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
        **/
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
   
        view.backgroundColor = UIColor(colorLiteralRed: Float(31/255), green: Float(103/255), blue: Float(108/255), alpha: 1.0)
        
        
   
        
    }
    
    func transitionToLevelViewController(sender: UITapGestureRecognizer){
        print("Transitioning to next level..")
        
        let touchPoint = sender.location(in: buttonStackView)
        
        
        if buttonStartGame.frame.contains(touchPoint){
        
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
                    
                
                    let screenSize = UIScreen.main.bounds.size
                    
                    /**
                     let planeScene1 = BaseScene(sksFileName: "PlaneScene1", size: screenSize)
                     let metalScene2 = BaseScene(sksFileName: "MetalScene2", size: screenSize)
                     **/
                
                    /**
                    let sceneName = levelSceneMetaData.sksFile
                    
                    let selectedScene = BaseScene(sksFileName: sceneName, size: screenSize)
                
                
                    let skView = self.view as! SKView
                    skView.presentScene(selectedScene)
                    **/
                
                    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                    var gscController = storyBoard.instantiateViewController(withIdentifier: "GameSceneControllerSB") as! GameSceneController
                
                    //let gscController = GameSceneController(nibName: nil, bundle: nil)
                    gscController.fileName = levelSceneMetaData.sksFile
                
                    self.present(gscController, animated: true, completion: nil)
                
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
