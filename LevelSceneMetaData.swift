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
    
    var onDemandResourceTags: Set<String>?
}

extension LevelSceneMetaData{
    
    static let allLevels: [LevelSceneMetaData] = [
        LevelSceneMetaData(sksFile: "PlaneScene1", previewImage: #imageLiteral(resourceName: "letterA"), titleText: "Letter A", subTitleText: "A is for Alien", descriptionText: nil, onDemandResourceTags: nil),
        LevelSceneMetaData(sksFile: "PlaneScene2", previewImage: #imageLiteral(resourceName: "letterB"), titleText: "Letter B", subTitleText: "B is for Bomb", descriptionText: nil, onDemandResourceTags: nil),
        LevelSceneMetaData(sksFile: "PlaneScene3", previewImage: #imageLiteral(resourceName: "letterC"), titleText: "Letter C", subTitleText: "C is for Candy", descriptionText: nil, onDemandResourceTags: nil),
        LevelSceneMetaData(sksFile: "PlaneScene4", previewImage: #imageLiteral(resourceName: "letterD"), titleText: "Letter D", subTitleText: "D is for Dog", descriptionText: nil, onDemandResourceTags: nil),
        LevelSceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "letterE"), titleText: "Letter E", subTitleText: "E is for Elephant", descriptionText: nil, onDemandResourceTags: nil),
        LevelSceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "letterF"), titleText: "Letter F", subTitleText: "F is for Forest", descriptionText: nil, onDemandResourceTags: nil),
        LevelSceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "letterG"), titleText: "Letter G", subTitleText: "G is for Ghost", descriptionText: nil, onDemandResourceTags: nil),
        
        LevelSceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "letterH"), titleText: "Letter H", subTitleText: "H is for Helicopter", descriptionText: nil, onDemandResourceTags: nil),
        LevelSceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "letterI"), titleText: "Letter I", subTitleText: "I is for Ice", descriptionText: nil, onDemandResourceTags: nil),
        LevelSceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "letterJ"), titleText: "Letter J", subTitleText: "J is for Jack-o-Lantern", descriptionText: nil, onDemandResourceTags: nil),
        LevelSceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "letterK"), titleText: "Letter K", subTitleText: "K is for Key", descriptionText: nil, onDemandResourceTags: nil),
        LevelSceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "letterL"), titleText: "Letter L", subTitleText: "L is for Lollipop", descriptionText: nil, onDemandResourceTags: nil),
        
        LevelSceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "letterM"), titleText: "Letter M", subTitleText: "M is for Metal", descriptionText: nil, onDemandResourceTags: nil),
        LevelSceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "letterN"), titleText: "Letter N", subTitleText: "N is for Ninja", descriptionText: nil, onDemandResourceTags: nil),
        LevelSceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "letterO"), titleText: "Letter O", subTitleText: "O is for Ocean", descriptionText: nil, onDemandResourceTags: nil),
        LevelSceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "letterP"), titleText: "Letter P", subTitleText: "P is for Pyramid", descriptionText: nil, onDemandResourceTags: nil),
        LevelSceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "letterQ"), titleText: "Letter Q", subTitleText: "Q is for Question Mark", descriptionText: nil, onDemandResourceTags: nil),
        
        LevelSceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "letterR"), titleText: "Letter R", subTitleText: "R is for Robot", descriptionText: nil, onDemandResourceTags: nil),
        LevelSceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "letterS"), titleText: "Letter S", subTitleText: "S is for Sun", descriptionText: nil, onDemandResourceTags: nil),
        LevelSceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "letterT"), titleText: "Letter T", subTitleText: "T is for Tree", descriptionText: nil, onDemandResourceTags: nil),
        LevelSceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "letterU"), titleText: "Letter U", subTitleText: "U is for UFO", descriptionText: nil, onDemandResourceTags: nil),
        LevelSceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "letterV"), titleText: "Letter V", subTitleText: "V is for Volcano", descriptionText: nil, onDemandResourceTags: nil),
        
        LevelSceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "letterW"), titleText: "Letter W", subTitleText: "W is for Worm", descriptionText: nil, onDemandResourceTags: nil),
        LevelSceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "letterX"), titleText: "Letter X", subTitleText: "X is for X-Ray", descriptionText: nil, onDemandResourceTags: nil),
        LevelSceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "letterY"), titleText: "Letter Y", subTitleText: "Y is for Yo-Yo", descriptionText: nil, onDemandResourceTags: nil),

        LevelSceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "letterZ"), titleText: "Letter Z", subTitleText: "Z is for Zoo", descriptionText: nil, onDemandResourceTags: nil)
        
    ]
}


