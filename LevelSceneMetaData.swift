//
//  SceneMetaData.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/8/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import UIKit

enum LetterScene: String{
    case LetterA_Scene, LetterB_Scene, LetterC_Scene, LetterD_Scene, LetterE_Scene
    case LetterF_Scene, LetterG_Scene, LetterH_Scene, LetterI_Scene, LetterJ_Scene
    case LetterK_Scene, LetterL_Scene, LetterM_Scene, LetterN_Scene, LetterO_Scene
    case LetterP_Scene, LetterQ_Scene, LetterR_Scene, LetterS_Scene, LetterT_Scene
    case LetterU_Scene, LetterV_Scene, LetterW_Scene, LetterX_Scene, LetterY_Scene
    case LetterZ_Scene
    
    
}

struct LevelSceneMetaData: GameMetaData{
    
    var letterScene: LetterScene
    var previewImage: UIImage
    var titleText: String
    var subTitleText: String
    var descriptionText: String?
    
    var onDemandResourceTags: Set<String>?
    
}

extension LevelSceneMetaData{
    
    static let allLevels: [LevelSceneMetaData] = [
        LevelSceneMetaData(letterScene: .LetterA_Scene, previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter A", subTitleText: "A is for Alien", descriptionText: "Can you avoid the angry aliens?", onDemandResourceTags: nil),
        LevelSceneMetaData(letterScene: .LetterB_Scene, previewImage: #imageLiteral(resourceName: "LetterB_Scene"), titleText: "Letter B", subTitleText: "B is for Bomb", descriptionText: "If you can't win, blame the bombs!", onDemandResourceTags: nil),
        LevelSceneMetaData(letterScene: .LetterC_Scene, previewImage: #imageLiteral(resourceName: "LetterC_Scene"), titleText: "Letter C", subTitleText: "C is for Candy", descriptionText: "Try not to concentrate on the candy!", onDemandResourceTags: nil),
        LevelSceneMetaData(letterScene: .LetterD_Scene, previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter D", subTitleText: "D is for Dog", descriptionText: "Can you defeat the deadly dogs?", onDemandResourceTags: nil),
        LevelSceneMetaData(letterScene: .LetterE_Scene, previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter E", subTitleText: "E is for Elephant", descriptionText: "Can you evade the eager elephant?", onDemandResourceTags: nil),
        LevelSceneMetaData(letterScene: .LetterF_Scene, previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter F", subTitleText: "F is for Forest", descriptionText: "Fly through the fantasy forest.", onDemandResourceTags: nil),
        LevelSceneMetaData(letterScene: .LetterG_Scene, previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter G", subTitleText: "G is for Ghost", descriptionText: "Get through the ghoulish ghosts.", onDemandResourceTags: nil),
        
        LevelSceneMetaData(letterScene: .LetterG_Scene, previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter H", subTitleText: "H is for Helicopter", descriptionText: "Don't hit the helicopter man!", onDemandResourceTags: nil),
        LevelSceneMetaData(letterScene: .LetterI_Scene, previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter I", subTitleText: "I is for Ice", descriptionText: "Too much ice is in the way!", onDemandResourceTags: nil),
        LevelSceneMetaData(letterScene: .LetterJ_Scene, previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter J", subTitleText: "J is for Jack-o-Lantern", descriptionText: "Jack-o-Lanterns just don't want you to win.", onDemandResourceTags: nil),
        LevelSceneMetaData(letterScene: .LetterK_Scene, previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter K", subTitleText: "K is for Key", descriptionText: "The key is the key to winning!", onDemandResourceTags: nil),
        LevelSceneMetaData(letterScene: .LetterL_Scene, previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter L", subTitleText: "L is for Lollipop", descriptionText: "Lollipops like to lure you away.", onDemandResourceTags: nil),
        
        LevelSceneMetaData(letterScene: .LetterM_Scene, previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter M", subTitleText: "M is for Metal", descriptionText: "Metal can make your life very miserable!", onDemandResourceTags: nil),
        LevelSceneMetaData(letterScene: .LetterN_Scene, previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter N", subTitleText: "N is for Ninja", descriptionText: "Can you navigate past the ninjas?", onDemandResourceTags: nil),
        LevelSceneMetaData(letterScene: .LetterO_Scene, previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter O", subTitleText: "O is for Ocean", descriptionText: "Oh no! The ocean is such an obstalce!", onDemandResourceTags: nil),
        LevelSceneMetaData(letterScene: .LetterP_Scene, previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter P", subTitleText: "P is for Pyramid", descriptionText: "Can the plane fly past the pyramids?", onDemandResourceTags: nil),
        LevelSceneMetaData(letterScene: .LetterQ_Scene, previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter Q", subTitleText: "Q is for Question Mark", descriptionText: "Find the letter A, don't hit any bombs along the way", onDemandResourceTags: nil),
        
        LevelSceneMetaData(letterScene: .LetterR_Scene, previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter R", subTitleText: "R is for Robot", descriptionText: "Remember to run away from evil robots!", onDemandResourceTags: nil),
        LevelSceneMetaData(letterScene: .LetterS_Scene, previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter S", subTitleText: "S is for Sun", descriptionText: "Find the letter A, don't hit any bombs along the way", onDemandResourceTags: nil),
        LevelSceneMetaData(letterScene: .LetterT_Scene, previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter T", subTitleText: "T is for Tree", descriptionText: "Find the letter A, don't hit any bombs along the way", onDemandResourceTags: nil),
        LevelSceneMetaData(letterScene: .LetterU_Scene, previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter U", subTitleText: "U is for UFO", descriptionText: "Find the letter A, don't hit any bombs along the way", onDemandResourceTags: nil),
        LevelSceneMetaData(letterScene: .LetterV_Scene, previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter V", subTitleText: "V is for Volcano", descriptionText: "Find the letter A, don't hit any bombs along the way", onDemandResourceTags: nil),
        
        LevelSceneMetaData(letterScene: .LetterW_Scene, previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter W", subTitleText: "W is for Worm", descriptionText: "Find the letter A, don't hit any bombs along the way", onDemandResourceTags: nil),
        LevelSceneMetaData(letterScene: .LetterX_Scene, previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter X", subTitleText: "X is for X-Ray", descriptionText: "Find the letter A, don't hit any bombs along the way", onDemandResourceTags: nil),
        LevelSceneMetaData(letterScene: .LetterY_Scene, previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter Y", subTitleText: "Y is for Yo-Yo", descriptionText: "Find the letter A, don't hit any bombs along the way", onDemandResourceTags: nil),

        LevelSceneMetaData(letterScene: .LetterZ_Scene, previewImage: #imageLiteral(resourceName: "PreviewSample"), titleText: "Letter Z", subTitleText: "Z is for Zoo", descriptionText: "Find the letter A, don't hit any bombs along the way", onDemandResourceTags: nil)
        
    ]
}


