//
//  LevelViewController.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/8/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class LevelViewController: UICollectionViewController{
    
    enum CellIdentifiers: String{
        case LevelCellReuseIdentifier
        case EnemyIntroCellReuseIdentifier
        
    }
    
    let mainMotionManager = MainMotionManager.sharedMotionManager
  
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        
        
        guard let collectionView = collectionView else {
                fatalError("Error: collection view failed to initialize")
        }
        
     
        
        collectionView.register(LevelCell.self, forCellWithReuseIdentifier: CellIdentifiers.LevelCellReuseIdentifier.rawValue)
    
        NSLayoutConstraint.activate([
            collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.90),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.90)
            
            ])
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        registerNotifications()

    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        super.didMove(toParentViewController: parent)
        
        
    }
    

    
}

//MARK: ******** DataSource Methods

extension LevelViewController{
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return LevelCell.metaDataDictionary.keys.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let levelCellSection = LevelCell.Section(rawValue: section), let gameMetaDataArray = LevelCell.metaDataDictionary[levelCellSection] else {
            print("Error: failed to initialize the LevelCell.Section nested enum type")
            return 0
        }
        
        return gameMetaDataArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.LevelCellReuseIdentifier.rawValue, for: indexPath) as! LevelCell
        
        if let gameMetaData = LevelCell.gameMetaDataForIndexPath(indexPath: indexPath){
            
            cell.titleText = gameMetaData.titleText
            cell.subtitleText = gameMetaData.subTitleText
            cell.descriptionText = gameMetaData.descriptionText
            cell.previewImage = gameMetaData.previewImage
            
            
            cell.backgroundColor =  UIColor.GetCustomColor(customColor: .GrassyGreen)
            
        }
        
        
        
        return cell
    }
}

extension LevelViewController{
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch(indexPath.section){
            case 0:
                if let gameMetaData = LevelCell.gameMetaDataForIndexPath(indexPath: indexPath) as? LevelSceneMetaData{
                    
                    
                
                    
                        print("Loading game scene view controller...")
                    
                        loadGame(levelSceneMetaData: gameMetaData)
                        
                    
                    //Start preload the ResourceLoadableTypes corresponding to the onDemangdResource tags (including the sks file) 
                    
                    //transition to a ProgressScene; call beginDownloadingResources on an NSBundleRequest, where its completion handler will involve presenting the scene whose resources have become fully available
                }
                break
            case 1: break
            default: break
            }
        
       
        
        }
    


    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    
    
    func loadGame(levelSceneMetaData: LevelSceneMetaData){
        
            
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
            let gscController = storyBoard.instantiateViewController(withIdentifier: "GameSceneControllerSB") as! GameSceneController
            
            //let gscController = GameSceneController(nibName: nil, bundle: nil)
            gscController.fileName = levelSceneMetaData.sksFile
            
            self.present(gscController, animated: true, completion: nil)
            
    
        
    }
    
    
    func exitGame(notification: Notification){
        
        if let gameSceneViewController = presentedViewController as? GameSceneController{
            gameSceneViewController.dismiss(animated: true, completion: nil)
        }
        
    }
    
    func registerNotifications(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(LevelViewController.exitGame(notification:)), name: Notification.Name.ExitGameToLevelViewControllerNotification, object: nil)
    }

    
    override var supportedInterfaceOrientations:UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }
}

//MARK: *********** UICollectionViewDelegate Methods


extension LevelViewController{
    
    
    /**
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
     

        return CGSize(width: 200, height: 200)
    }
    **/
    
    /**
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
    
        return UIEdgeInsets(top: 0.0, left: 30.0, bottom: 0.0, right: 30.0)
    }
    **/
    
    
    /**
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.00
    }
    **/
}
