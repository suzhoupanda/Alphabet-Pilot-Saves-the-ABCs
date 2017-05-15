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
    
    
    var requestedBaseScene: BaseScene?
    
    var progressView: UIProgressView?
    
    var sceneLoadingQueue = OperationQueue()
    
    
   
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    
        
        guard let collectionView = collectionView else {
                fatalError("Error: collection view failed to initialize")
        }
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        collectionView.register(LevelCell.self, forCellWithReuseIdentifier: CellIdentifiers.LevelCellReuseIdentifier.rawValue)
    
        
        let replayPreviewButton = UIButton(type: .roundedRect)
        replayPreviewButton.titleLabel?.text = "View Recorded Gameplay"
        replayPreviewButton.contentEdgeInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
        replayPreviewButton.tintColor = UIColor.GetCustomColor(customColor: .GrassyGreen)
        
        view.addSubview(replayPreviewButton)
        
       
       
        replayPreviewButton.addTarget(self, action: #selector(LevelViewController.showPreviewViewController), for: .touchUpInside)
        
        
        replayPreviewButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.80),
            replayPreviewButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10.00),
            replayPreviewButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.40),
            replayPreviewButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 5.00),
            replayPreviewButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.10)
            
            ])
        
        
        progressView = UIProgressView(progressViewStyle: .bar)
        
        guard let progressView = progressView else {
            print("Error: Failed to instantiate progress view for level scene controller scene")
            return
        }
        progressView.progressTintColor = UIColor.GetCustomColor(customColor: .StopSignRed)
        progressView.trackTintColor = UIColor.GetCustomColor(customColor: .BluishGrey)
        view.addSubview(progressView)
        
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            progressView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 10.00),
            progressView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 5.00),
            progressView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.80),
            progressView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08)
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
        
        return 1
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
            
            cell.titleText = gameMetaData.subTitleText
            cell.subtitleText = "Incomplete"
            cell.descriptionText = gameMetaData.descriptionText
            cell.previewImage = gameMetaData.previewImage
            
            
            cell.backgroundColor =  UIColor.GetCustomColor(customColor: .GrassyGreen)
            
        }
        
        
        
        return cell
    }
}

extension LevelViewController{
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        guard indexPath.section == 0 else { return }
        
        
        if let gameMetaData = LevelCell.gameMetaDataForIndexPath(indexPath: indexPath) as? LevelSceneMetaData{
                    
                    
            loadGame(levelSceneMetaData: gameMetaData)
                        
                    
            //Start preload the ResourceLoadableTypes corresponding to the onDemangdResource tags (including the sks file)
                    
            //transition to a ProgressScene; call beginDownloadingResources on an NSBundleRequest, where its completion handler will involve presenting the scene whose resources have become fully available
        
        
       
        
        }
    
    }

    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    
    //MARK: Helper Functions called via NotificationCenter for loading, reloading, and exiting currently active games
    
    func loadGame(levelSceneMetaData: LevelSceneMetaData){
        
            
            UIDevice.current.beginGeneratingDeviceOrientationNotifications()
            
            self.mainMotionManager.startDeviceMotionUpdates()
            self.mainMotionManager.deviceMotionUpdateInterval = 0.50
        
            //Get the name of the SKS file need to load the background environment for the Base Scene
            let sksfileName = levelSceneMetaData.sksFile
        
            //Set up a Progress Object to act as the parent progress object encapsulating the progress made in loading all ResourceLoadableType relevant to the scene (as determined from the onDemangResourceTags) as well as the SKSFile itself
        
          //  let totalLoadingProgress = Progress(totalUnitCount: 5)
        
           // progressView?.observedProgress = totalLoadingProgress
        
            Operation.
            DispatchQueue.main.async {
                
                if levelSceneMetaData.onDemandResourceTags != nil, let onDemandResourceTags = levelSceneMetaData.onDemandResourceTags{
                    
                    for tag in onDemandResourceTags{
                        switch(tag){
                        case "Alien":
                            Alien.loadResources {
                                print("Finished loading alien textures")
                              //  totalLoadingProgress.completedUnitCount = 2
                            }
                            
                            break
                        case "BladeIsland": break
                        case "Bee": break
                        default:
                            break
                        }
                    }
                    
                }
                
                self.requestedBaseScene = BaseScene(sksFileName: sksfileName, size: UIScreen.main.bounds.size)
                
                
                //A notification is posted when the requested base scene is finished loading
                
                print("BaseScene finished loading...Posting notification...")
                
               // totalLoadingProgress.completedUnitCount = 5
                
                NotificationCenter.default.post(name: Notification.Name.BaseSceneFinishedLoadingNotification, object: nil)
            }
        
            //totalLoadingProgress.addChild(loadBaseSceneOperation.progress, withPendingUnitCount: 1)
        
            //Loop through all of the onDemandResource tags, add a corresponding load resource operation to the sceneLoadingQueue, as well as a corresponding child progress indicator to the ttoalLoadingProgress object
        
        
        
        
        
        
    }
    
    func presentGameSceneController(notification: Notification){
        
       print("BaseScene finished loading notification received...preparing to present the GameScene controller")
        
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let gscController = storyBoard.instantiateViewController(withIdentifier: "GameSceneControllerSB") as! GameSceneController
        
        if requestedBaseScene != nil{
            print("The requested base scene will now load.")
            
            gscController.baseScene = self.requestedBaseScene
            present(gscController, animated: true, completion: nil)
            
        } else {
            print("The requested base scene is nil")
        }
        
        

        
    }
    
    func reloadCurrentGame(notification: Notification){
        
        guard let presentedViewController = presentedViewController as? GameSceneController else {
            print("Error: There is no Game Scene controller currently being presented")
            return
        }
        
        let presentingView = presentedViewController.view as! SKView
        
        guard let currentBaseScene = presentedViewController.baseScene else {
            print("Error: current base scene could not be retrieved from game scene controller")
            return
        }
        
        let transition = SKTransition.crossFade(withDuration: 2.00)
        
        presentingView.presentScene(currentBaseScene, transition: transition)
        
        
        
        
        
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
    
    //MARK: Register Notifications (for exiting and reloading game, as well for starting and stopping gameplay recording)
    
    func registerNotifications(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(LevelViewController.exitGame(notification:)), name: Notification.Name.ExitGameToLevelViewControllerNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(LevelViewController.reloadCurrentGame(notification:)), name: Notification.Name.ReloadCurrentGameNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(LevelViewController.startScreenRecording(notification:)), name: Notification.Name.StartRecordingGameplayNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(LevelViewController.stopScreenRecording(notification:withHandler:)), name: Notification.Name.StopRecordingGameplayNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(LevelViewController.presentGameSceneController(notification:)), name: Notification.Name.BaseSceneFinishedLoadingNotification, object: nil)
       
    }

    //MARK: Disable portrait mode for the LevelViewController and GameSceneViewController
    /**
    override var supportedInterfaceOrientations:UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscapeLeft
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        return UIInterfaceOrientation.landscapeLeft
    }
    **/
    
}

//MARK: *********** UICollectionViewDelegate Methods


extension LevelViewController{
    
    

    /**
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let aspectRatio = collectionView.bounds.height/collectionView.bounds.width
        
        let availableWidth = (collectionView.bounds.width
            ) - (collectionView.contentInset.left + collectionView.contentInset.right)
        
        
        let itemWidth = availableWidth*0.50
        let itemHeight = aspectRatio*itemWidth
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
 
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
    
        return UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    }

    
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.00
    }
     **/
}
