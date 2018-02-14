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
    
    static let allLetterScenes: [LetterScene] = [
    
        .LetterA_Scene, .LetterB_Scene, .LetterC_Scene, .LetterD_Scene, .LetterE_Scene,
        .LetterF_Scene, .LetterG_Scene, .LetterH_Scene, .LetterI_Scene, .LetterJ_Scene,
        .LetterK_Scene, .LetterL_Scene, .LetterM_Scene, .LetterN_Scene, .LetterO_Scene,
        .LetterP_Scene, .LetterQ_Scene, .LetterR_Scene, .LetterS_Scene, .LetterT_Scene,
        .LetterU_Scene, .LetterV_Scene, .LetterW_Scene, .LetterX_Scene, .LetterY_Scene,
        .LetterZ_Scene
    
    ]
    
    
    func getSKSFileName() -> String{
        switch self{
            case .LetterA_Scene:
                return "SpaceScene1"
            case .LetterB_Scene:
                return "CandyScene1"
            case .LetterC_Scene:
                return "CandyScene2"
            case .LetterD_Scene:
                return "CandyScene3"
            case .LetterE_Scene:
                return "CandyScene4"
            case .LetterF_Scene:
                return "SpaceScene2"
            case .LetterG_Scene:
                return "PlaneScene1"
            case .LetterH_Scene:
                return "PlaneScene2"
            case .LetterI_Scene:
                return "IceScene2"
            case .LetterJ_Scene:
                return "CaveScene1"
            case .LetterK_Scene:
                return "CaveScene2"
            case .LetterL_Scene:
                return "ForestScene3"
            case .LetterM_Scene:
                return "PlaneScene4"
            case .LetterN_Scene:
                return "SandScene3"
            case .LetterO_Scene:
                return "IceScene1"
            case .LetterP_Scene:
                return "SandScene2"
            case .LetterQ_Scene:
                return "CaveScene3"
            case .LetterR_Scene:
                return "SandScene4"
            case .LetterS_Scene:
                return "IceScene3"
            case .LetterT_Scene:
                return "ForestScene2"
            case .LetterU_Scene:
                return "FireScene"
            case .LetterV_Scene:
                return "FireScene2"
            case .LetterW_Scene:
                return "MetalScene2"
            case .LetterX_Scene:
                return "MetalScene2"
            case .LetterY_Scene:
                return "CandyScene5"
            case .LetterZ_Scene:
                return "PlaneScene1"

        }
    }
    
    func getBackGroundMusicFileName() -> String{
        switch self{
        case .LetterA_Scene:
            return BackgroundMusic.AlphaDance
        case .LetterB_Scene:
             return BackgroundMusic.CheerfulAnnoyance
        case .LetterC_Scene:
            return BackgroundMusic.DrummingSticks
        case .LetterD_Scene:
            return BackgroundMusic.FarmFrolics
        case .LetterE_Scene:
            return BackgroundMusic.FlowingRocks
        case .LetterF_Scene:
            return BackgroundMusic.GermanVirtue
        case .LetterG_Scene:
            return BackgroundMusic.TimeDriving
        case .LetterH_Scene:
            return BackgroundMusic.TimeDriving
        case .LetterI_Scene:
            return BackgroundMusic.TimeDriving
        case .LetterJ_Scene:
            return BackgroundMusic.MishiefStroll
        case .LetterK_Scene:
            return BackgroundMusic.MissionPlausible
        case .LetterL_Scene:
            return BackgroundMusic.NightAtTheBeach
        case .LetterM_Scene:
            return BackgroundMusic.PolkaTrain
        case .LetterN_Scene:
            return BackgroundMusic.PolkaTrain
        case .LetterO_Scene:
            return BackgroundMusic.SadTown
        case .LetterP_Scene:
            return BackgroundMusic.SpaceCadet
        case .LetterQ_Scene:
            return BackgroundMusic.SwingingPants
        case .LetterR_Scene:
            return BackgroundMusic.TimeDriving
        case .LetterS_Scene:
            return BackgroundMusic.WackyWaiting
        case .LetterT_Scene:
            return BackgroundMusic.AlphaDance
        case .LetterU_Scene:
            return BackgroundMusic.CheerfulAnnoyance
        case .LetterV_Scene:
            return BackgroundMusic.DrummingSticks
        case .LetterW_Scene:
            return BackgroundMusic.TimeDriving
        case .LetterX_Scene:
            return BackgroundMusic.WackyWaiting
        case .LetterY_Scene:
            return BackgroundMusic.SpaceCadet
        case .LetterZ_Scene:
            return BackgroundMusic.SadTown

        }
    }
    
    func loadSceneResources(){
        
        let resourceLoadableTypes = self.getResourceLoadableTypes()
        
        for resource in resourceLoadableTypes{
            resource.loadResources {
                print("Resources for Letter Scene: \(self.rawValue) have been loaded")
            }
        }
    }
    
    func purgeResources(){
        let resourceLoadableTypes = self.getResourceLoadableTypes()
        
        for resource in resourceLoadableTypes{
            resource.purgeResoures()
        }
    }
    
    func getResourceLoadableTypes() -> [ResourceLoadableType.Type]{
        
        switch self{
            case .LetterA_Scene:                        //SpaceScene1
                return [Alien.self, EvilSun.self, Bee.self, Spikeball.self, Bomb.self]
            case .LetterB_Scene:                        //CandyScene1
                return [Bee.self]
            case .LetterC_Scene:                        //CandyScene2
                return [BlockMan.self, Bomb.self]
            case .LetterD_Scene:                        //CandyScene3
                return [Alien.self, BlockMan.self, Bee.self]
            case .LetterE_Scene:                        //CandyScene4
                return [Bomb.self, Bee.self, Animal.self, BlockMan.self]
            case .LetterF_Scene:
                return [Alien.self, Bomb.self, Bee.self, BlockMan.self]
            case .LetterG_Scene:                        //Giraffe Scene
                return [Animal.self]
            case .LetterH_Scene:                        //Hippo Scene
                return [Animal.self]
            case .LetterI_Scene:                        //Ice Scene
                return [Animal.self, Bee.self]
            case .LetterJ_Scene:                        //CaveScene1
                return []
            case .LetterK_Scene:                        //CaveScene2
                return [Fly.self, Bee.self]
            case .LetterL_Scene:                        //ForestScene3
                return [Animal.self, Bee.self]
            case .LetterM_Scene:                        //PlaneScene4
                return [Fly.self, Animal.self]
            case .LetterN_Scene:                        //SandScene3
                return [Fly.self, Animal.self]
            case .LetterO_Scene:                        //IceScene1
                return [Animal.self, EvilSun.self, Spikeman.self]
            case .LetterP_Scene:                        //SandScene3
                return [BlockMan.self, EvilSun.self, Bee.self]
            case .LetterQ_Scene:                        //CaveScene3
                return [Bee.self]
            case .LetterR_Scene:                        //SandScene4
                return [Animal.self, Bee.self]
            case .LetterS_Scene:                        //IceScene3
                return [EvilSun.self, Spikeball.self]
            case .LetterT_Scene:                        //ForestScene2
                return [Spikeball.self, EvilSun.self, Spikeman.self]
            case .LetterU_Scene:                        //FireScene
                return [Animal.self, Spikeball.self, EvilSun.self]
            case .LetterV_Scene:                        //FireScene2
                return [BlockMan.self, EvilSun.self]
            case .LetterW_Scene:                        //MetalScene2
                return [Spikeman.self, BlockMan.self]
            case .LetterX_Scene:                        //MetalScene1
                return [Bee.self, BlockMan.self]
            case .LetterY_Scene:                        //CandySceen5
                return [Fly.self, Bee.self]
            case .LetterZ_Scene:                        //PlaneScene
                return [Animal.self]

        }
    }
}

struct LevelSceneMetaData: GameMetaData{
    
    var letterScene: LetterScene
    var titleText: String
    var subTitleText: String
    var descriptionText: String?
    var onDemandResourceTags: Set<String>?

}

extension LevelSceneMetaData{

    static let allLevels: [LevelSceneMetaData] = [
        LevelSceneMetaData(letterScene: .LetterA_Scene, titleText: "Letter A", subTitleText: "A is for Alien", descriptionText: "Can you avoid the angry aliens?", onDemandResourceTags: ["LetterA_Scene","Alien","Sun","Bee","Rockspikes","RockspikeGround","Spikeball","Islands","Bomb"]),
        LevelSceneMetaData(letterScene: .LetterB_Scene, titleText: "Letter B", subTitleText: "B is for Bee", descriptionText: "If you can't win, blame the bee!", onDemandResourceTags: nil),
        LevelSceneMetaData(letterScene: .LetterC_Scene, titleText: "Letter C", subTitleText: "C is for Candy", descriptionText: "Try not to concentrate on the candy!", onDemandResourceTags: nil),
        LevelSceneMetaData(letterScene: .LetterD_Scene, titleText: "Letter D", subTitleText: "D is for Deadly Laser", descriptionText: "Can you defeat the deadly laser guns?", onDemandResourceTags: nil),
        LevelSceneMetaData(letterScene: .LetterE_Scene, titleText: "Letter E", subTitleText: "E is for Elephant", descriptionText: "Can you evade the eager elephant?", onDemandResourceTags: nil),
        LevelSceneMetaData(letterScene: .LetterF_Scene, titleText: "Letter F", subTitleText: "F is for Floating Spikes", descriptionText: "Fly through the floating spikes.", onDemandResourceTags: nil),
        LevelSceneMetaData(letterScene: .LetterG_Scene, titleText: "Letter G", subTitleText: "G is for Giraffe", descriptionText: "Get through the giant giraffe heads.", onDemandResourceTags: nil),
        
        LevelSceneMetaData(letterScene: .LetterH_Scene, titleText: "Letter H", subTitleText: "H is for Helicopter", descriptionText: "Don't hit the hippo heads!", onDemandResourceTags: nil),
        LevelSceneMetaData(letterScene: .LetterI_Scene, titleText: "Letter I", subTitleText: "I is for Ice", descriptionText: "Too much ice is in the way!", onDemandResourceTags: nil),
        LevelSceneMetaData(letterScene: .LetterJ_Scene, titleText: "Letter J", subTitleText: "J is for Jagged Rocks", descriptionText: "Jagged rocks stand between you and winning!", onDemandResourceTags: nil),
        LevelSceneMetaData(letterScene: .LetterK_Scene, titleText: "Letter K", subTitleText: "K is for Killer Fly", descriptionText: "Killer flies will do anything to keep you away from the letter K!", onDemandResourceTags: nil),
        LevelSceneMetaData(letterScene: .LetterL_Scene, titleText: "Letter L", subTitleText: "L is for Large Panda Heads", descriptionText: "Large panda heads will try to stop you from getting to the Letter L.", onDemandResourceTags: nil),
        
        LevelSceneMetaData(letterScene: .LetterM_Scene, titleText: "Letter M", subTitleText: "M is for Monkey", descriptionText: "Fly through the clouds, but beware of the Monkey heads!", onDemandResourceTags: nil),
        LevelSceneMetaData(letterScene: .LetterN_Scene, titleText: "Letter N", subTitleText: "N is for Nefarious Snake", descriptionText: "Can you navigate past the nasty, nefarious desert snakes?", onDemandResourceTags: nil),
        LevelSceneMetaData(letterScene: .LetterO_Scene, titleText: "Letter O", subTitleText: "O is for Obnoxious Penguin", descriptionText: "Oh no! The obnoxious penguins are such obstalces!", onDemandResourceTags: nil),
        LevelSceneMetaData(letterScene: .LetterP_Scene, titleText: "Letter P", subTitleText: "P is for Pyramid", descriptionText: "Can the plane fly past the pyramids?", onDemandResourceTags: nil),
        LevelSceneMetaData(letterScene: .LetterQ_Scene, titleText: "Letter Q", subTitleText: "Q is for Queen Bees", descriptionText: "These are not just your ordinary bees, they're Queen Bees!", onDemandResourceTags: nil),
        
        LevelSceneMetaData(letterScene: .LetterR_Scene, titleText: "Letter R", subTitleText: "R is for Rabbit", descriptionText: "Remember to run away from rampant rabbits!", onDemandResourceTags: nil),
        LevelSceneMetaData(letterScene: .LetterS_Scene, titleText: "Letter S", subTitleText: "S is for Snow", descriptionText: "Find the letter S, try to fly through the snow", onDemandResourceTags: nil),
        LevelSceneMetaData(letterScene: .LetterT_Scene, titleText: "Letter T", subTitleText: "T is for Tree", descriptionText: "Find the letter T, don't hit any sharp tree tops.", onDemandResourceTags: nil),
        LevelSceneMetaData(letterScene: .LetterU_Scene, titleText: "Letter U", subTitleText: "U is for Underground Snake", descriptionText: "Find the letter U, but beware of the snakes underground...", onDemandResourceTags: nil),
        LevelSceneMetaData(letterScene: .LetterV_Scene, titleText: "Letter V", subTitleText: "V is for Volcano", descriptionText: "Find the letter V, try to get past the vicious volcanoes", onDemandResourceTags: nil),
        
        LevelSceneMetaData(letterScene: .LetterW_Scene, titleText: "Letter W", subTitleText: "W is for Walking Spike", descriptionText: "Find the letter W, but watch out for the walking spike!", onDemandResourceTags: nil),
        LevelSceneMetaData(letterScene: .LetterX_Scene, titleText: "Letter X", subTitleText: "X is for X-Ray Gun", descriptionText: "Watch out for deadly X-Ray guns that stand in your way", onDemandResourceTags: nil),
        LevelSceneMetaData(letterScene: .LetterY_Scene, titleText: "Letter Y", subTitleText: "Y is for Yummy Ice Cream", descriptionText: "Find the letter Y, try not to let the yummy ice cream tempt you", onDemandResourceTags: nil),

        LevelSceneMetaData(letterScene: .LetterZ_Scene, titleText: "Letter Z", subTitleText: "Z is for Zoo Animals", descriptionText: "Find the letter Z, but watch out for all the zoo animals!", onDemandResourceTags: nil)
        
    ]
}


