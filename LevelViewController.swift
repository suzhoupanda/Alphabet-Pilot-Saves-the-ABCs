//
//  LevelViewController.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/8/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import UIKit


class LevelViewController: UICollectionViewController{
    
    enum CellIdentifiers: String{
        case LevelCellReuseIdentifier
        case EnemyIntroCellReuseIdentifier
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        super.didMove(toParentViewController: parent)
        
        collectionView?.register(LevelCell.self, forCellWithReuseIdentifier: CellIdentifiers.LevelCellReuseIdentifier.rawValue)
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
        
        let gameMetaData = LevelCell.gameMetaDataForIndexPath(indexPath: indexPath)
        return cell
    }
}

extension LevelViewController{
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
}

//MARK: *********** UICollectionViewDelegate Methods


extension LevelViewController{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets()
    }
}
