//
//  SceneFileCacheManager.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/26/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

//
//  SceneFileCacheHelper.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/26/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit


class SceneFileCacheManager{
    
    enum FileNameKeys: String{
        case PlaneScene1, PlaneScene2, PlaneScene3, PlaneScene4
        case SandScene1, SandScene2, SandScene3, SandScene4
        case ForestScene2, ForestScene3, ForestScene4
        case CandyScene1, CandyScene2, CandyScene3, CandyScene4, CandyScene5
        case CaveScene1, CaveScene2, CaveScene3
        case FireScene, FireScene2
        case SpaceScene1, SpaceScene2, SpaceScene3, SpaceScene4
        case MetalScene1, MetalScene2
        case IceScene, IceScene1, IceScene2, IceScene3
        
    }
    
    
    
    static let sharedHelper = SceneFileCacheManager()
    
    var sceneFileDictionary = [LetterScene: SKScene?]()
    
    private init(){
        DispatchQueue.global().async {
            
            for letterScene in LetterScene.allLetterScenes{
                let fileName = letterScene.getSKSFileName()
                self.sceneFileDictionary[letterScene] = SKScene(fileNamed: fileName)
            }
        }
    }
    
    
    func getScene(forLetterScene letterScene: LetterScene) -> SKScene?{
        guard let scene = sceneFileDictionary[letterScene] else {
            print("Error: scene could not be retreived from dictionary cache")
            return nil
        }
        
        return scene
    }
    
    func loadScene(forLetterScene letterScene: LetterScene, completionHandler: @escaping (Void) -> (Void) ){
        
    }
}
