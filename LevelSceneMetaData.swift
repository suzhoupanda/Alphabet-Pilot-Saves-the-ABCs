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
        LevelSceneMetaData(sksFile: "PlaneScene1", previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter A", subTitleText: "A is for Alien", descriptionText: "Can you avoid the angry aliens?", onDemandResourceTags: nil),
        LevelSceneMetaData(sksFile: "PlaneScene2", previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter B", subTitleText: "B is for Bomb", descriptionText: "If you can't win, blame the bombs!", onDemandResourceTags: nil),
        LevelSceneMetaData(sksFile: "PlaneScene3", previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter C", subTitleText: "C is for Candy", descriptionText: "Try not to concentrate on the candy!", onDemandResourceTags: nil),
        LevelSceneMetaData(sksFile: "PlaneScene4", previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter D", subTitleText: "D is for Dog", descriptionText: "Can you defeat the deadly dogs?", onDemandResourceTags: nil),
        LevelSceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter E", subTitleText: "E is for Elephant", descriptionText: "Can you evade the eager elephant?", onDemandResourceTags: nil),
        LevelSceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter F", subTitleText: "F is for Forest", descriptionText: "Fly through the fantasy forest.", onDemandResourceTags: nil),
        LevelSceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter G", subTitleText: "G is for Ghost", descriptionText: "Get through the ghoulish ghosts.", onDemandResourceTags: nil),
        
        LevelSceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter H", subTitleText: "H is for Helicopter", descriptionText: "Don't hit the helicopter man!", onDemandResourceTags: nil),
        LevelSceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter I", subTitleText: "I is for Ice", descriptionText: "Too much ice is in the way!", onDemandResourceTags: nil),
        LevelSceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter J", subTitleText: "J is for Jack-o-Lantern", descriptionText: "Jack-o-Lanterns just don't want you to win.", onDemandResourceTags: nil),
        LevelSceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter K", subTitleText: "K is for Key", descriptionText: "The key is the key to winning!", onDemandResourceTags: nil),
        LevelSceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter L", subTitleText: "L is for Lollipop", descriptionText: "Lollipops like to lure you away.", onDemandResourceTags: nil),
        
        LevelSceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter M", subTitleText: "M is for Metal", descriptionText: "Metal can make your life very miserable!", onDemandResourceTags: nil),
        LevelSceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter N", subTitleText: "N is for Ninja", descriptionText: "Can you navigate past the ninjas?", onDemandResourceTags: nil),
        LevelSceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter O", subTitleText: "O is for Ocean", descriptionText: "Oh no! The ocean is such an obstalce!", onDemandResourceTags: nil),
        LevelSceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter P", subTitleText: "P is for Pyramid", descriptionText: "Can the plane fly past the pyramids?", onDemandResourceTags: nil),
        LevelSceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter Q", subTitleText: "Q is for Question Mark", descriptionText: "Find the letter A, don't hit any bombs along the way", onDemandResourceTags: nil),
        
        LevelSceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter R", subTitleText: "R is for Robot", descriptionText: "Remember to run away from evil robots!", onDemandResourceTags: nil),
        LevelSceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter S", subTitleText: "S is for Sun", descriptionText: "Find the letter A, don't hit any bombs along the way", onDemandResourceTags: nil),
        LevelSceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter T", subTitleText: "T is for Tree", descriptionText: "Find the letter A, don't hit any bombs along the way", onDemandResourceTags: nil),
        LevelSceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter U", subTitleText: "U is for UFO", descriptionText: "Find the letter A, don't hit any bombs along the way", onDemandResourceTags: nil),
        LevelSceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter V", subTitleText: "V is for Volcano", descriptionText: "Find the letter A, don't hit any bombs along the way", onDemandResourceTags: nil),
        
        LevelSceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter W", subTitleText: "W is for Worm", descriptionText: "Find the letter A, don't hit any bombs along the way", onDemandResourceTags: nil),
        LevelSceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter X", subTitleText: "X is for X-Ray", descriptionText: "Find the letter A, don't hit any bombs along the way", onDemandResourceTags: nil),
        LevelSceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter Y", subTitleText: "Y is for Yo-Yo", descriptionText: "Find the letter A, don't hit any bombs along the way", onDemandResourceTags: nil),

        LevelSceneMetaData(sksFile: "", previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter Z", subTitleText: "Z is for Zoo", descriptionText: "Find the letter A, don't hit any bombs along the way", onDemandResourceTags: nil)
        
    ]
}


