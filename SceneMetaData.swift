//
//  SceneMetaData.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/8/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import UIKit

struct SceneMetaData: GameMetaData{
    
    var sksFile: String
    
    var previewImage: UIImage
    var titleText: String
    var subTitleText: String
    var descriptionText: String?
    
}

extension SceneMetaData{
    
    static let allLevels: [SceneMetaData] = [
        SceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "letterA"), titleText: "Letter A", subTitleText: "A is for Alien", descriptionText: nil),
        SceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "letterB"), titleText: "Letter B", subTitleText: "B is for Bee", descriptionText: nil),
        SceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "letterC"), titleText: "Letter C", subTitleText: "C is for Castle", descriptionText: nil)
    ]
}


