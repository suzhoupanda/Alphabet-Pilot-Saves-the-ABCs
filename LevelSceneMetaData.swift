//
//  SceneMetaData.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/8/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import UIKit

struct LevelSceneMetaData: GameMetaData{
    
    var sksFile: String
    
    var previewImage: UIImage
    var titleText: String
    var subTitleText: String
    var descriptionText: String?
    
}

extension LevelSceneMetaData{
    
    static let allLevels: [LevelSceneMetaData] = [
        LevelSceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "letterA"), titleText: "Letter A", subTitleText: "A is for Alien", descriptionText: nil),
        LevelSceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "letterB"), titleText: "Letter B", subTitleText: "B is for Bee", descriptionText: nil),
        LevelSceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "letterC"), titleText: "Letter C", subTitleText: "C is for Castle", descriptionText: nil)
    ]
}


