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
import CoreData

class LevelViewController: UICollectionViewController{
    
    enum CellIdentifiers: String{
        case LevelCellReuseIdentifier
        case EnemyIntroCellReuseIdentifier
        
    }
    
    let mainMotionManager = MainMotionManager.sharedMotionManager
    
    var screenRecorderHelper = ScreenRecorderHelper.sharedHelper
    
    var levelInformationArray = [LevelInformation]()
    
    var completedLevels: [LevelInformation]{
        get{
            return levelInformationArray.filter{ $0.completed }
        }
    }
    
    
    var managedContext: NSManagedObjectContext?
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        screenRecorderHelper.presentingViewController = nil
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        screenRecorderHelper.presentingViewController = self
        
        if let managedContext = managedContext{
            
            do{
                
                let fetchRequest = NSFetchRequest<LevelInformation>(entityName: "LevelInformation")
                
                levelInformationArray = try managedContext.fetch(fetchRequest)
                
            } catch let error as NSError{
                
            }
            
        }
        
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        
      
     
        guard let collectionView = collectionView else {
            fatalError("Error: collection view failed to initialize")
        }
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        collectionView.register(GameItemCell.self, forCellWithReuseIdentifier: CellIdentifiers.LevelCellReuseIdentifier.rawValue)
        
        
        let toolBar = UIToolbar()
        view.addSubview(toolBar)
        
        
        let replayPreviewItem = UIBarButtonItem(title: "View Recorded Gameplay", style: .plain, target: self, action: #selector(LevelViewController.showPreviewViewController))
        
        let returnToMainMenuItem = UIBarButtonItem(title: "Return to Main Menu", style: .plain, target: self, action: #selector(LevelViewController.returnToMainMenu))
        
        let uiOffset1 = UIOffset(horizontal: 50.00, vertical: 0.00)
        
        returnToMainMenuItem.setTitlePositionAdjustment(uiOffset1, for: .default)
        
        toolBar.setItems([replayPreviewItem, returnToMainMenuItem], animated: true)
        
        
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.80),
            toolBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            toolBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            toolBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            toolBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08)
            
            ])
        
        
    }
    
    func returnToMainMenu(){
        
        dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        registerNotifications()
        
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        super.didMove(toParentViewController: parent)
        
        
    }
    
    
    func showPreviewViewController(){
        screenRecorderHelper.showPreviewViewController()
    }
    
}

//MARK: ******** DataSource Methods

extension LevelViewController{
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return GameItemCell.metaDataDictionary.keys.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let levelCellSection = GameItemCell.Section(rawValue: section), let levelMetaDataArray = GameItemCell.metaDataDictionary[levelCellSection] else {
            print("Error: failed to initialize the LevelCell.Section nested enum type")
            return 0
        }
        
        return levelMetaDataArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.LevelCellReuseIdentifier.rawValue, for: indexPath) as! GameItemCell
        
        if let levelSceneMetaData = GameItemCell.gameMetaDataForIndexPath(indexPath: indexPath) as? LevelSceneMetaData{
            
            cell.titleText = levelSceneMetaData.titleText
            
            
            let subTitleText = completedLevels.filter{ $0.levelScene == levelSceneMetaData.letterScene.rawValue}.isEmpty ? "INCOMPLETE" : "COMPLETED"
                

            
            cell.subtitleText = subTitleText
            cell.descriptionText = levelSceneMetaData.descriptionText
            cell.previewImage = levelSceneMetaData.previewImage
            
            
            cell.backgroundColor =  UIColor.GetCustomColor(customColor: .GrassyGreen)
            
        }
        
        
        
        return cell
    }
}

extension LevelViewController{
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        //LevelViewController only presents a collection of level thumbnails,all of which are stored as the first entry in a dictionary
        
        guard indexPath.section == 0 else { return }
        
     
        if let gameMetaData = GameItemCell.gameMetaDataForIndexPath(indexPath: indexPath) as? LevelSceneMetaData{
                
            
            print("Cell selected. Loading game..")
            
            loadGame(levelSceneMetaData: gameMetaData)
                
                
            //Start preload the ResourceLoadableTypes corresponding to the onDemangdResource tags (including the sks file)
                
            //transition to a ProgressScene; call beginDownloadingResources on an NSBundleRequest, where its completion handler will involve presenting the scene whose resources have become fully available
        }
    
    }
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    
    
    
    func loadGame(levelSceneMetaData: LevelSceneMetaData){
        
        print("Starting to load game...")
        
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        
        self.mainMotionManager.startDeviceMotionUpdates()
        self.mainMotionManager.deviceMotionUpdateInterval = 0.50
        
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let gscController = storyBoard.instantiateViewController(withIdentifier: "GameSceneControllerSB") as! GameSceneController
        
        //let gscController = GameSceneController(nibName: nil, bundle: nil)
        gscController.letterScene = levelSceneMetaData.letterScene
        
        self.present(gscController, animated: true, completion: nil)
          
        
        
    }
    
    
    func reloadSavedGame(reloadData: ReloadData){
        
        
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        
        self.mainMotionManager.startDeviceMotionUpdates()
        self.mainMotionManager.deviceMotionUpdateInterval = 0.50
        
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let gscController = storyBoard.instantiateViewController(withIdentifier: "GameSceneControllerSB") as! GameSceneController
        
        //let gscController = GameSceneController(nibName: nil, bundle: nil)
        gscController.letterScene = reloadData.letterScene
        gscController.reloadData = reloadData
        
        self.present(gscController, animated: true, completion: nil)
        
        
        
    }
    
    func reloadCurrentGame(notification: Notification){
        
        guard let presentedViewController = presentedViewController as? GameSceneController else {
            print("Error: There is no Game Scene controller currently being presented")
            return
        }
        
        let presentingView = presentedViewController.view as! SKView
        
        
        let transition = SKTransition.crossFade(withDuration: 2.00)
        
        
        if let letterScene = presentedViewController.letterScene{
       
            let baseScene = GameSceneController.GetSceneForLetterSceneType(letterScene: letterScene, reloadData: nil)
        
            presentingView.presentScene(baseScene, transition: transition)
        
        }
        
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
        
        
    }
    
    
    override var supportedInterfaceOrientations:UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        return .landscapeLeft
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
