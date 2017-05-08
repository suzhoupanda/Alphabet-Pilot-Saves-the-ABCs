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

extension Player{
  
    
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
    
    static let AnimationsDictYellow: [String: SKAction] = [
        
        "dead" : Player.RegularExplosionAction,
        
        "damaged" : SKAction.sequence([
            SKAction.fadeAlpha(to: 0.60, duration: 0.50),
            SKAction.fadeAlpha(to: 0.80, duration: 0.50)
            ]),
        
        "lowVelocity" : SKAction.animate(with: Player.YellowPlaneTextures, timePerFrame: 0.70),
        
        "mediumVelocity" : SKAction.animate(with: Player.YellowPlaneTextures, timePerFrame: 0.50),
        
        "highVelocity" : SKAction.animate(with:
            Player.YellowPlaneTextures , timePerFrame: 0.10)
        
        ]
    
    static let AnimationsDictGreen: [String: SKAction] = [
        
        "dead" : Player.RegularExplosionAction,
        
        "damaged" : SKAction.sequence([
            SKAction.fadeAlpha(to: 0.60, duration: 0.50),
            SKAction.fadeAlpha(to: 0.80, duration: 0.50)
            ]),
        
        "lowVelocity" : SKAction.animate(with:
            Player.GreenPlaneTextures, timePerFrame: 0.70),
        
        "mediumVelocity" : SKAction.animate(with:
            Player.GreenPlaneTextures, timePerFrame: 0.50),
        
        "highVelocity" : SKAction.animate(with:
            Player.GreenPlaneTextures, timePerFrame: 0.10)
        

    ]
    
    static let AnimationsDictBlue: [String: SKAction] = [
        
        "dead" : Player.RegularExplosionAction,
        
        "damaged" : SKAction.sequence([
            SKAction.fadeAlpha(to: 0.60, duration: 0.50),
            SKAction.fadeAlpha(to: 0.80, duration: 0.50)
            ]),
        
        "lowVelocity" : SKAction.animate(with:
            Player.BluePlaneTextures, timePerFrame: 0.70),
        
        "mediumVelocity" : SKAction.animate(with:
            Player.BluePlaneTextures, timePerFrame: 0.50),
        
        "highVelocity" : SKAction.animate(with:
            Player.BluePlaneTextures, timePerFrame: 0.10)
        

    ]
    
    static let AnimationsDictRed: [String: SKAction] = [
        
        "dead" : Player.RegularExplosionAction,
        
        "damaged" : SKAction.sequence([
            SKAction.fadeAlpha(to: 0.60, duration: 0.50),
            SKAction.fadeAlpha(to: 0.80, duration: 0.50)
            ]),
        
        "lowVelocity" : SKAction.animate(with: Player.RedPlaneTextures, timePerFrame: 0.70),
        
        "mediumVelocity" : SKAction.animate(with: Player.RedPlaneTextures, timePerFrame: 0.50),
        
        "highVelocity" : SKAction.animate(with: Player.RedPlaneTextures, timePerFrame: 0.10)
        
        
    ]
    
    
    static func getPlaneTexture(forPlaneColor planeColor: PlaneColor) -> SKTexture?{
        
        switch planeColor{
        case .Blue:
            return TextureAtlasManager.sharedManager.planeTextureAtlas!.textureNamed("planeBlue1")
        case .Red:
            return TextureAtlasManager.sharedManager.planeTextureAtlas!.textureNamed("planeRed1")
        case .Yellow:
            return TextureAtlasManager.sharedManager.planeTextureAtlas!.textureNamed("planeYellow1")
        case .Green:
            return TextureAtlasManager.sharedManager.planeTextureAtlas!.textureNamed("planeGreen1")
        }
        
    }
    
    
    //MARK: ********** Stored references to repeated texture sequences required for player-class texture-based animations
    
    private static let RegularExplosionAction: SKAction = SKAction.animate(with: [
        TextureAtlasManager.sharedManager.regularExplosionTextureAtlas!.textureNamed("regularExplosion00"),
        TextureAtlasManager.sharedManager.regularExplosionTextureAtlas!.textureNamed("regularExplosion01"),
        TextureAtlasManager.sharedManager.regularExplosionTextureAtlas!.textureNamed("regularExplosion02"),
        TextureAtlasManager.sharedManager.regularExplosionTextureAtlas!.textureNamed("regularExplosion03"),
        TextureAtlasManager.sharedManager.regularExplosionTextureAtlas!.textureNamed("regularExplosion04"),
        TextureAtlasManager.sharedManager.regularExplosionTextureAtlas!.textureNamed("regularExplosion05"),
        TextureAtlasManager.sharedManager.regularExplosionTextureAtlas!.textureNamed("regularExplosion06"),
        TextureAtlasManager.sharedManager.regularExplosionTextureAtlas!.textureNamed("regularExplosion07")
        ], timePerFrame: 0.10)
    
    
    private static let RedPlaneTextures: [SKTexture] = [
        TextureAtlasManager.sharedManager.planeTextureAtlas!.textureNamed("planeRed1"),
        TextureAtlasManager.sharedManager.planeTextureAtlas!.textureNamed("planeRed2"),
        TextureAtlasManager.sharedManager.planeTextureAtlas!.textureNamed("planeRed3")
    ]
    
    private static let YellowPlaneTextures: [SKTexture] = [
        TextureAtlasManager.sharedManager.planeTextureAtlas!.textureNamed("planeYellow1"),
        TextureAtlasManager.sharedManager.planeTextureAtlas!.textureNamed("planeYellow2"),
        TextureAtlasManager.sharedManager.planeTextureAtlas!.textureNamed("planeYellow3")
    ]
    
    private static let BluePlaneTextures: [SKTexture] = [
        TextureAtlasManager.sharedManager.planeTextureAtlas!.textureNamed("planeBlue1"),
        TextureAtlasManager.sharedManager.planeTextureAtlas!.textureNamed("planeBlue2"),
        TextureAtlasManager.sharedManager.planeTextureAtlas!.textureNamed("planeBlue3")
    ]
    
    private static let GreenPlaneTextures: [SKTexture] = [
        TextureAtlasManager.sharedManager.planeTextureAtlas!.textureNamed("planeGreen1"),
        TextureAtlasManager.sharedManager.planeTextureAtlas!.textureNamed("planeGreen2"),
        TextureAtlasManager.sharedManager.planeTextureAtlas!.textureNamed("planeGreen3")
    ]
    

}


