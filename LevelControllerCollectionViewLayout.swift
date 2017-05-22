//
//  LevelControllerCollectionViewLayout.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/21/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import UIKit



class LevelControllerCollectionViewLayout: UICollectionViewFlowLayout{
    
    
    // MARK: - Layout
    override func prepare() {
        
       
        let cvWidth = collectionView?.bounds.width ?? 1200
        let cvHeight = collectionView?.bounds.height ?? 800
        let aspectRatio = cvHeight/cvWidth
        
        let itemWidth = cvWidth*0.60
        let itemHeight = itemWidth*aspectRatio
        
        
        self.scrollDirection = .horizontal
        self.minimumInteritemSpacing = 20.00
        self.minimumLineSpacing = 1.00
        self.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        // cell size
        self.itemSize = CGSize(width: itemWidth, height: itemHeight)
        
        // Note: call super last if we set itemSize
        super.prepare()
    }

   

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func shouldInvalidateLayout(forPreferredLayoutAttributes preferredAttributes: UICollectionViewLayoutAttributes, withOriginalAttributes originalAttributes: UICollectionViewLayoutAttributes) -> Bool {
        
        return true 
    }
    
    
}
