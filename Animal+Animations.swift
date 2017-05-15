//
//  Animal+Animations.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/15/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit

extension Animal{
    
    static let textureAtlasManager = TextureAtlasManager.sharedManager
    
    static let AnimationsDict = [String: SKAction]()
    
    static func getTexture(forAnimalType animalType: AnimalType) -> SKTexture?{
        switch animalType {
        case .Elephant:
            return textureAtlasManager.animalTextureAtlas?.textureNamed("elephant-1")
        case .Giraffe:
            return textureAtlasManager.animalTextureAtlas?.textureNamed("giraffe-1")
        case .Hippo:
            return textureAtlasManager.animalTextureAtlas?.textureNamed("hippo-1")
        case .Monkey:
            return textureAtlasManager.animalTextureAtlas?.textureNamed("monkey-1")
        case .Panda:
            return textureAtlasManager.animalTextureAtlas?.textureNamed("panda-1")
        case .Parrot:
            return textureAtlasManager.animalTextureAtlas?.textureNamed("parrot-1")
        case .Penguin:
            return textureAtlasManager.animalTextureAtlas?.textureNamed("penguin-1")
        case .Pig:
            return textureAtlasManager.animalTextureAtlas?.textureNamed("pig-1")
        case .Rabbit:
            return textureAtlasManager.animalTextureAtlas?.textureNamed("rabbit-1")
        case .Snake:
            return textureAtlasManager.animalTextureAtlas?.textureNamed("snake-1")

        }
    }
}
