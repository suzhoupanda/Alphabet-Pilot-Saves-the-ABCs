//
//  Player+AnimationsDict.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/2/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

extension Player: ResourceLoadableType{
    
    //MARK: ******* Conformance to ResourceLoadableType protocol
    
    static let textureAtlasManager = TextureAtlasManager.sharedManager
    
    
    static var resourcesNeedLoading: Bool{
        return !Player.TextureAtlasNames.isEmpty
    }
    
    static func loadResources(withCompletionHandler completionHandler: @escaping () -> ()){
        
        SKTextureAtlas.preloadTextureAtlasesNamed(TextureAtlasNames, withCompletionHandler: {
        
            error, playerTextureAtlases in
            
            if error != nil{
                fatalError("Error: one or more texture atlases couldn't be loaded for the player entity")
            }
            
            textureAtlasManager.planeTextureAtlas = playerTextureAtlases[0]
            textureAtlasManager.regularExplosionTextureAtlas = playerTextureAtlases[1]
            
            completionHandler()
            
        })
    }

    static func purgeResoures(){
        textureAtlasManager.planeTextureAtlas = nil
        textureAtlasManager.regularExplosionTextureAtlas = nil
    }
    
    static func loadMiscellaneousAssets(){
        
    }
    
    static let TextureAtlasNames : [String] = [
        "Planes",
        "RegularExplosion"
    ]
    
    static func getPlaneAnimationsDict(forPlaneColor planeColor: PlaneColor) -> [String: SKAction]{
        
        switch planeColor{
            case .Blue:
                return AnimationsDictYellow
            case .Green:
                return AnimationsDictGreen
            case .Red:
                return AnimationsDictRed
            case .Yellow:
                return AnimationsDictYellow
        }
    }
    
    static let RegularExplosionAction: SKAction = SKAction.animate(with: [
        TextureAtlasManager.sharedManager.regularExplosionTextureAtlas!.textureNamed("regularExplosion00"),
        TextureAtlasManager.sharedManager.regularExplosionTextureAtlas!.textureNamed("regularExplosion01"),
        TextureAtlasManager.sharedManager.regularExplosionTextureAtlas!.textureNamed("regularExplosion02"),
        TextureAtlasManager.sharedManager.regularExplosionTextureAtlas!.textureNamed("regularExplosion03"),
        TextureAtlasManager.sharedManager.regularExplosionTextureAtlas!.textureNamed("regularExplosion04"),
        TextureAtlasManager.sharedManager.regularExplosionTextureAtlas!.textureNamed("regularExplosion05"),
        TextureAtlasManager.sharedManager.regularExplosionTextureAtlas!.textureNamed("regularExplosion06"),
        TextureAtlasManager.sharedManager.regularExplosionTextureAtlas!.textureNamed("regularExplosion07")
        ], timePerFrame: 0.10)
    
    
    static let RedPlaneTextures: [SKTexture] = [
        TextureAtlasManager.sharedManager.planeTextureAtlas!.textureNamed("planeRed1"),
        TextureAtlasManager.sharedManager.planeTextureAtlas!.textureNamed("planeRed2"),
        TextureAtlasManager.sharedManager.planeTextureAtlas!.textureNamed("planeRed3")
    ]
    
    static let YellowPlaneTextures: [SKTexture] = [
        TextureAtlasManager.sharedManager.planeTextureAtlas!.textureNamed("planeYellow1"),
        TextureAtlasManager.sharedManager.planeTextureAtlas!.textureNamed("planeYellow2"),
        TextureAtlasManager.sharedManager.planeTextureAtlas!.textureNamed("planeYellow3")
    ]
    
    static let BluePlaneTextures: [SKTexture] = [
        TextureAtlasManager.sharedManager.planeTextureAtlas!.textureNamed("planeBlue1"),
        TextureAtlasManager.sharedManager.planeTextureAtlas!.textureNamed("planeBlue2"),
        TextureAtlasManager.sharedManager.planeTextureAtlas!.textureNamed("planeBlue3")
    ]
    
    static let GreenPlaneTextures: [SKTexture] = [
        TextureAtlasManager.sharedManager.planeTextureAtlas!.textureNamed("planeGreen1"),
        TextureAtlasManager.sharedManager.planeTextureAtlas!.textureNamed("planeGreen2"),
        TextureAtlasManager.sharedManager.planeTextureAtlas!.textureNamed("planeGreen3")
    ]
    
    
    static let AnimationsDictYellow: [String: SKAction] = [
        
        "dead" : Player.RegularExplosionAction /** SKAction.sequence([
            SKAction.animate(with: [
                /**
                SKTexture(image: #imageLiteral(resourceName: "regularExplosion00")),
                SKTexture(image: #imageLiteral(resourceName: "regularExplosion01")),
                SKTexture(image: #imageLiteral(resourceName: "regularExplosion02")),
                SKTexture(image: #imageLiteral(resourceName: "regularExplosion03")),
                SKTexture(image: #imageLiteral(resourceName: "regularExplosion04")),
                SKTexture(image: #imageLiteral(resourceName: "regularExplosion05")),
                SKTexture(image: #imageLiteral(resourceName: "regularExplosion06")),
                SKTexture(image: #imageLiteral(resourceName: "regularExplosion07"))
                **/
                ], timePerFrame: 0.10),
            SKAction.removeFromParent()
            
            ]) **/,
        
        "damaged" : SKAction.sequence([
            SKAction.fadeAlpha(to: 0.60, duration: 0.50),
            SKAction.fadeAlpha(to: 0.80, duration: 0.50)
            ]),
        
        "lowVelocity" : SKAction.animate(with:
            Player.YellowPlaneTextures
            /**[
            SKTexture(image: #imageLiteral(resourceName: "planeYellow1")),
            SKTexture(image: #imageLiteral(resourceName: "planeYellow2")),
            SKTexture(image: #imageLiteral(resourceName: "planeYellow3"))
            ]**/, timePerFrame: 0.70),
        
        "mediumVelocity" : SKAction.animate(with:
            Player.YellowPlaneTextures
            /**[SKTexture(image: #imageLiteral(resourceName: "planeYellow1")),
            SKTexture(image: #imageLiteral(resourceName: "planeYellow2")),
            SKTexture(image: #imageLiteral(resourceName: "planeYellow3"))
            ]**/, timePerFrame: 0.50),
        
        "highVelocity" : SKAction.animate(with:
            Player.YellowPlaneTextures
            /**[
            SKTexture(image: #imageLiteral(resourceName: "planeYellow1")),
            SKTexture(image: #imageLiteral(resourceName: "planeYellow2")),
            SKTexture(image: #imageLiteral(resourceName: "planeYellow3"))
            ]**/, timePerFrame: 0.10)
        

    ]
    
    static let AnimationsDictGreen: [String: SKAction] = [
        
        "dead" : Player.RegularExplosionAction, /** SKAction.sequence([
            SKAction.animate(with: [
            
                /**
                SKTexture(image: #imageLiteral(resourceName: "regularExplosion00")),
                SKTexture(image: #imageLiteral(resourceName: "regularExplosion01")),
                SKTexture(image: #imageLiteral(resourceName: "regularExplosion02")),
                SKTexture(image: #imageLiteral(resourceName: "regularExplosion03")),
                SKTexture(image: #imageLiteral(resourceName: "regularExplosion04")),
                SKTexture(image: #imageLiteral(resourceName: "regularExplosion05")),
                SKTexture(image: #imageLiteral(resourceName: "regularExplosion06")),
                SKTexture(image: #imageLiteral(resourceName: "regularExplosion07"))
                **/
                ], timePerFrame: 0.10),
            SKAction.removeFromParent()
            
            ])**/
        
        "damaged" : SKAction.sequence([
            SKAction.fadeAlpha(to: 0.60, duration: 0.50),
            SKAction.fadeAlpha(to: 0.80, duration: 0.50)
            ]),
        
        "lowVelocity" : SKAction.animate(with:
            Player.GreenPlaneTextures
            /**[
            SKTexture(image: #imageLiteral(resourceName: "planeGreen1")),
            SKTexture(image: #imageLiteral(resourceName: "planeGreen2")),
            SKTexture(image: #imageLiteral(resourceName: "planeGreen3"))
            ]**/, timePerFrame: 0.70),
        
        "mediumVelocity" : SKAction.animate(with:
            Player.GreenPlaneTextures
            /**[
            SKTexture(image: #imageLiteral(resourceName: "planeGreen1")),
            SKTexture(image: #imageLiteral(resourceName: "planeGreen2")),
            SKTexture(image: #imageLiteral(resourceName: "planeGreen3"))
            ]**/, timePerFrame: 0.50),
        
        "highVelocity" : SKAction.animate(with:
            Player.GreenPlaneTextures
            /**[
            SKTexture(image: #imageLiteral(resourceName: "planeGreen1")),
            SKTexture(image: #imageLiteral(resourceName: "planeGreen2")),
            SKTexture(image: #imageLiteral(resourceName: "planeGreen3"))
            ]**/, timePerFrame: 0.10)
        

        
    ]
    
    static let AnimationsDictBlue: [String: SKAction] = [
        
        "dead" : Player.RegularExplosionAction,/**SKAction.sequence([
            SKAction.animate(with: [
 
                /**
                SKTexture(image: #imageLiteral(resourceName: "regularExplosion00")),
                SKTexture(image: #imageLiteral(resourceName: "regularExplosion01")),
                SKTexture(image: #imageLiteral(resourceName: "regularExplosion02")),
                SKTexture(image: #imageLiteral(resourceName: "regularExplosion03")),
                SKTexture(image: #imageLiteral(resourceName: "regularExplosion04")),
                SKTexture(image: #imageLiteral(resourceName: "regularExplosion05")),
                SKTexture(image: #imageLiteral(resourceName: "regularExplosion06")),
                SKTexture(image: #imageLiteral(resourceName: "regularExplosion07"))
                **/
                ], timePerFrame: 0.10),
            SKAction.removeFromParent()
            
            ]) **/
        
        "damaged" : SKAction.sequence([
            SKAction.fadeAlpha(to: 0.60, duration: 0.50),
            SKAction.fadeAlpha(to: 0.80, duration: 0.50)
            ]),
        
        "lowVelocity" : SKAction.animate(with:
            Player.BluePlaneTextures
            /**[
            SKTexture(image: #imageLiteral(resourceName: "planeBlue1")),
            SKTexture(image: #imageLiteral(resourceName: "planeBlue2")),
            SKTexture(image: #imageLiteral(resourceName: "planeBlue3"))
            ]**/, timePerFrame: 0.70),
        
        "mediumVelocity" : SKAction.animate(with:
            Player.BluePlaneTextures
            /**[
            SKTexture(image: #imageLiteral(resourceName: "planeBlue1")),
            SKTexture(image: #imageLiteral(resourceName: "planeBlue2")),
            SKTexture(image: #imageLiteral(resourceName: "planeBlue3"))
            ]**/, timePerFrame: 0.50),
        
        "highVelocity" : SKAction.animate(with:
            Player.BluePlaneTextures
            /** [
            SKTexture(image: #imageLiteral(resourceName: "planeBlue1")),
            SKTexture(image: #imageLiteral(resourceName: "planeBlue2")),
            SKTexture(image: #imageLiteral(resourceName: "planeBlue3"))
            ]**/, timePerFrame: 0.10)
        

    ]
    
    static let AnimationsDictRed: [String: SKAction] = [
        
        "dead" : Player.RegularExplosionAction,/** SKAction.sequence([
            SKAction.animate(with: [
        
                /**
                SKTexture(image: #imageLiteral(resourceName: "regularExplosion00")),
                SKTexture(image: #imageLiteral(resourceName: "regularExplosion01")),
                SKTexture(image: #imageLiteral(resourceName: "regularExplosion02")),
                SKTexture(image: #imageLiteral(resourceName: "regularExplosion03")),
                SKTexture(image: #imageLiteral(resourceName: "regularExplosion04")),
                SKTexture(image: #imageLiteral(resourceName: "regularExplosion05")),
                SKTexture(image: #imageLiteral(resourceName: "regularExplosion06")),
                SKTexture(image: #imageLiteral(resourceName: "regularExplosion07"))
                **/
                ], timePerFrame: 0.10),
            SKAction.removeFromParent()
            
            ])**/
        
        "damaged" : SKAction.sequence([
            SKAction.fadeAlpha(to: 0.60, duration: 0.50),
            SKAction.fadeAlpha(to: 0.80, duration: 0.50)
            ]),
        
        "lowVelocity" : SKAction.animate(with:
            Player.RedPlaneTextures
            /**
            [SKTexture(image: #imageLiteral(resourceName: "planeRed1")),
            SKTexture(image: #imageLiteral(resourceName: "planeRed2")),
            SKTexture(image: #imageLiteral(resourceName: "planeRed3"))]
            **/
            , timePerFrame: 0.70),
        
        "mediumVelocity" : SKAction.animate(with:
            Player.RedPlaneTextures
            /**
            SKTexture(image: #imageLiteral(resourceName: "planeRed1")),
            SKTexture(image: #imageLiteral(resourceName: "planeRed2")),
            SKTexture(image: #imageLiteral(resourceName: "planeRed3"))
            **/
            , timePerFrame: 0.50),
        
        "highVelocity" : SKAction.animate(with:
            Player.RedPlaneTextures
            /**
            [SKTexture(image: #imageLiteral(resourceName: "planeRed1")),
            SKTexture(image: #imageLiteral(resourceName: "planeRed2")),
            SKTexture(image: #imageLiteral(resourceName: "planeRed3"))]
            **/
            , timePerFrame: 0.10)
        
        
    ]
    
    
    static func getPlaneTexture(forPlaneColor planeColor: PlaneColor) -> SKTexture?{
        
        switch planeColor{
        case .Blue:
            return TextureAtlasManager.sharedManager.planeTextureAtlas!.textureNamed("planeBlue1") //SKTexture(image: #imageLiteral(resourceName: "planeBlue1"))
        case .Red:
            return TextureAtlasManager.sharedManager.planeTextureAtlas!.textureNamed("planeRed1")//SKTexture(image: #imageLiteral(resourceName: "planeRed1"))
        case .Yellow:
            return TextureAtlasManager.sharedManager.planeTextureAtlas!.textureNamed("planeYellow1")//SKTexture(image: #imageLiteral(resourceName: "planeYellow1"))
        case .Green:
            return TextureAtlasManager.sharedManager.planeTextureAtlas!.textureNamed("planeGreen1")//SKTexture(image: #imageLiteral(resourceName: "planeGreen1"))
     
        }
        
    }
    
}


