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
    
    var previewImageName: String
    var titleText: String
    var subTitleText: String
    var descriptionText: String?
    
}

extension EnemyMetaData{
    
    static let allEnemies: [EnemyMetaData] = []
}
