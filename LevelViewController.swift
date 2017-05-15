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
import ReplayKit

class LevelViewController: UICollectionViewController{
    
    enum CellIdentifiers: String{
        case LevelCellReuseIdentifier
        case EnemyIntroCellReuseIdentifier
        
    }
    
    let mainMotionManager = MainMotionManager.sharedMotionManager
    
    var previewViewController: RPPreviewViewController?
    
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        
        
        guard let collectionView = collectionView else {
            fatalError("Error: collection view failed to initialize")
        }
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        collectionView.register(LevelCell.self, forCellWithReuseIdentifier: CellIdentifiers.LevelCellReuseIdentifier.rawValue)
        
        
        let toolBar = UIToolbar()
        view.addSubview(toolBar)
        
        
        let replayPreviewItem = UIBarButtonItem(title: "View Recorded Gameplay", style: .plain, target: self, action: #selector(LevelViewController.showPreviewViewController))
        
        toolBar.setItems([replayPreviewItem], animated: true)
        
        
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.80),
            toolBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            toolBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            toolBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            toolBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08)
            
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
                
                
                loadGame(levelSceneMetaData: gameMetaData)
                
                
                //Start preload the ResourceLoadableTypes corresponding to the onDemangdResource tags (including the sks file)
                
                //transition to a ProgressScene; call beginDownloadingResources on an NSBundleRequest, where its completion handler will involve presenting the scene whose resources have become fully available
            }
            break
        default:
            break
        }
        
        
        
    }
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    
    
    func loadGame(levelSceneMetaData: LevelSceneMetaData){
        
        
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        
        self.mainMotionManager.startDeviceMotionUpdates()
        self.mainMotionManager.deviceMotionUpdateInterval = 0.50
        
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let gscController = storyBoard.instantiateViewController(withIdentifier: "GameSceneControllerSB") as! GameSceneController
        
        //let gscController = GameSceneController(nibName: nil, bundle: nil)
        gscController.fileName = levelSceneMetaData.sksFile
        
        self.present(gscController, animated: true, completion: nil)
        
        
        
    }
    
    func reloadCurrentGame(notification: Notification){
        
        guard let presentedViewController = presentedViewController as? GameSceneController else {
            print("Error: There is no Game Scene controller currently being presented")
            return
        }
        
        let presentingView = presentedViewController.view as! SKView
        
        let sksFileName = presentedViewController.fileName
        
        let transition = SKTransition.crossFade(withDuration: 2.00)
        
        let baseScene = BaseScene(sksFileName: sksFileName!, size: UIScreen.main.bounds.size)
        
        presentingView.presentScene(baseScene, transition: transition)
        
        
        
        
        
    }
    
    
    func exitGame(notification: Notification){
        
        if let gameSceneViewController = presentedViewController as? GameSceneController{
            gameSceneViewController.dismiss(animated: true, completion: {
                
                //Once the Game Scene Controller is dismissed, it's no longer necessary to continue receiving motion updates for player position
                
                self.mainMotionManager.stopDeviceMotionUpdates()
                
                
                //Upon exiting game, deselect the game scene that is being loaded
                
                guard let collectionView = self.collectionView, let indexPaths = collectionView.indexPathsForSelectedItems  else {
                    print("Error: collection view unavailable for modification or no collection view items have been selected")
                    return
                }
                for indexPath in indexPaths{
                    collectionView.deselectItem(at: indexPath, animated: true)
                    print("Previously selected scenes have been deselected")
                }
                
            })
        }
        
    }
    
    func registerNotifications(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(LevelViewController.exitGame(notification:)), name: Notification.Name.ExitGameToLevelViewControllerNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(LevelViewController.reloadCurrentGame(notification:)), name: Notification.Name.ReloadCurrentGameNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(LevelViewController.startScreenRecording(notification:)), name: Notification.Name.StartRecordingGameplayNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(LevelViewController.stopScreenRecording(notification:withHandler:)), name: Notification.Name.StopRecordingGameplayNotification, object: nil)
        
        
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
