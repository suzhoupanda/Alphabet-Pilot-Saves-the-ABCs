//
//  SceneMetaData.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/8/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//


/** Read the GroundBotAttack state, Taskbot behavior, also the GKAgent delegate methods for the Taskbot and PlayerBot entities to see how Agent/Goal behavior is implemented
 
    See the entities themsleves to see how textures are pre-loaded (since entities are resource loadable types); try implementing it for teh current game
 
    GKRuleSystem and GK rules behavior still needs to be considered...
 
 **/


import Foundation
import SpriteKit
import GameplayKit

struct SceneMetaData{
    
    //MARK: Properties 
    
    //The base file name to use when loading the scene and related resources
    
    let fileName: String
    
    //The type to use when loading the scene ('EndScene' or 'LevelScene')
    
    let sceneType: BaseScene.Type
    
    //The list of types with resources that should be preloaded for this scene 
    
    let loadableTypes: [ResourceLoadableType.Type]
    
    //All on demand resource tags that pertain to this scene
    
    let onDemandResourceTags: Set<String>
    
    
    //A flag indicating whether the scene requires on demand resources in  order to load
    
    var requiresOnDemandResources: Bool{
        return !onDemandResourceTags.isEmpty
    }
    
    
    //MARK: **** Initializers 
    
    //Initializes a new 'SceneMetadata' instance from a dictionary  
    
    init(sceneConfiguration: [String: AnyObject]){
        
        fileName = sceneConfiguration["fileName"] as! String
        
        let typeIdentifier = sceneConfiguration["sceneType"] as! String
        
        switch typeIdentifier{
            case "LevelScene":
                sceneType = BaseScene.self
            case "HomeEndScene":
                sceneType = HomeEndScene.self
            case "TransitionScene":
                sceneType = TransitionScene.self
            default:
                fatalError("Unidentified scene type requested")
        }
        
        var loadableTypesForScene = [ResourceLoadableType.Type]()
        
        if let tags = sceneConfiguration["onDemandResourceTags"] as? [String]{
            onDemandResourceTags = Set(tags)
            
            
            
            loadableTypesForScene += tags.flatMap{ tag in
                //TODO: NOT YET IMPLEMENTED
                switch(tag){
                        case "Bomb": break
                         //   return Bomb.Type
                        case "Alien": break
                         //   return Alien.Type
                        default:
                            return nil
                    }
                
                    return nil
                }
            
            
        } else {
            onDemandResourceTags = []
        }
        
        if sceneType == BaseScene.self{
            loadableTypesForScene = loadableTypesForScene + [Player.self]
        }
        
        loadableTypes = loadableTypesForScene
    }
}

//MARK: ***** Provide an implementation of the hashValue variables so that SceneMetaData instances can act as dictionary keys that maps to SceneLoader instances, which is used by the Scene Manager to load the scene; In order to conform to Hashable, SceneMetaData must also conform to Equatable, therefore equality operator must be overloaded so that SceneMetaData conforms to Equatable

extension SceneMetaData: Hashable{
    
    var hashValue: Int {
        return fileName.hashValue
    }
    
    static func ==(lhs: SceneMetaData, rhs: SceneMetaData) -> Bool{
        return lhs.hashValue == rhs.hashValue
    }
}
