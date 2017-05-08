//
//  EnemyMetaData.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/8/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import UIKit

struct EnemyMetaData: GameMetaData{
    
    var sksFile: String
    
    var previewImage: UIImage
    var titleText: String
    var subTitleText: String
    var descriptionText: String?
    
}

extension EnemyMetaData{
    
    static let allEnemies: [EnemyMetaData] = [
        EnemyMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "spikeMan_stand"), titleText: "Spikeman", subTitleText: "A is for Alien", descriptionText: nil),
        EnemyMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "sun1"), titleText: "Evil Sun", subTitleText: "B", descriptionText: nil),
        EnemyMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "shipPink_manned"), titleText: "Alien Chaser", subTitleText: "", descriptionText: nil)
    ]
}
