//
//  LevelThumbnailCache.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/21/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class LevelThumbnailCache{
    
    static let sharedCache = LevelThumbnailCache()
    
    var levelThumbnailDict = [LetterScene : UIImage?]()
    
    private init(){
        
        for letterScene in LetterScene.allLetterScenes{
            levelThumbnailDict[letterScene] = nil
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name.UIApplicationDidReceiveMemoryWarning, object: nil, queue: OperationQueue.main, using: {
        
        
            notification in
            
            for letterScene in LetterScene.allLetterScenes{
                self.levelThumbnailDict[letterScene] = nil
            }
        
        })
    
    }
    
    func cachePercentageOccupied() -> Double{
        
        let numberKeysOccupied = LetterScene.allLetterScenes.filter{ return self.levelThumbnailDict[$0] != nil }.count
        
        return Double(numberKeysOccupied)/Double(LetterScene.allLetterScenes.count)
    }
    
    func clearCache(){
        for letterScene in LetterScene.allLetterScenes{
            self.levelThumbnailDict[letterScene] = nil
        }
    }
    
    func imageForLetterScene(letterScene: LetterScene) -> UIImage?{
        
        guard let image = levelThumbnailDict[letterScene] else {
            return nil
        }
        
        return image
    }
    
    
    func setImage(forLetterScene letterScene: LetterScene, completionHandler: @escaping (_ thumbnailImage: UIImage?)->(Void) ){
        
        levelThumbnailDict[letterScene] = UIImage(named: letterScene.rawValue)
        
        if let image = levelThumbnailDict[letterScene]{
            completionHandler(image)
        }
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIApplicationDidReceiveMemoryWarning, object: nil)
    }
}
