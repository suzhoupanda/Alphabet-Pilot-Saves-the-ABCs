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
                    
                    
                    let gameViewController = presentingViewController as! GameViewController
                    gameViewController.gameHasStarted = true
                
                    
                    NotificationCenter.default.post(name: Notification.Name.LevelChosenNotification, object: gameMetaData)
                    
                    /**
                    let sksFileName = gameMetaData.sksFile
                    let onDemandResourceTags = gameMetaData.onDemandResourceTags
                    
                    let gameViewController = presentingViewController as! GameViewController
                    gameViewController.sksFileName = sksFileName
                    
                    dismiss(animated: true, completion: {
                    
                        gameViewController.startGame()
                    })
                    **/
                    
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
