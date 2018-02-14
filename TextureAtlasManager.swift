//
//  TextureAtlasManager.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/8/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit


class TextureAtlasManager{
    
    enum TextureAtlasCategory: String{
        case Alien, Animal, BackgroundElements, Backgrounds, Barnacle, Bat, Beams, Bee
        case Blockman, Bomb, Candy, Cave, Coins, Collectibles, Fly, Ghost, Grass
        case HUD, Ice, Islands, Letter, LevelThumbnails, MenuAssets, MetalTiles
        case OnScreenControls, Planes, RecordButtons, RegularExplosion, Rocks, RockSpikeGround
        case RockSpikes, Sand, Spikeball, Spikeman, Spikes, Sun, Trees, UIButtonsBlue, Worm
    
    }
    
    enum TextureAtlasKind: Int{
        case Alien, Animal, BackgroundElements, Backgrounds, Barnacle, Bat, Beams, Bee
        case Blockman, Bomb, Candy, Cave, Coins, Collectibles, Fly, Ghost, Grass
        case HUD, Ice, Islands, Letter, LevelThumbnails, MenuAssets, MetalTiles
        case OnScreenControls, Planes, RecordButtons, RegularExplosion, Rocks, RockSpikeGround
        case RockSpikes, Sand, Spikeball, Spikeman, Spikes, Sun, Trees, UIButtonsBlue, Worm
        
    }
    
    static let sharedManager = TextureAtlasManager()
    
    var secondaryTexturesLoaded: Bool = false
    
    
    static let allTextureAtlasNames: [String] = [
        TextureAtlasCategory.Alien.rawValue,
        TextureAtlasCategory.Animal.rawValue,
        TextureAtlasCategory.BackgroundElements.rawValue,
        TextureAtlasCategory.Backgrounds.rawValue,
        TextureAtlasCategory.Barnacle.rawValue,
        TextureAtlasCategory.Bat.rawValue,
        TextureAtlasCategory.Beams.rawValue,
        TextureAtlasCategory.Bee.rawValue,
        TextureAtlasCategory.Blockman.rawValue,
        TextureAtlasCategory.Bomb.rawValue,
        TextureAtlasCategory.Candy.rawValue,
        TextureAtlasCategory.Cave.rawValue,
        TextureAtlasCategory.Coins.rawValue,
        TextureAtlasCategory.Collectibles.rawValue,
        TextureAtlasCategory.Fly.rawValue,
        TextureAtlasCategory.Ghost.rawValue,
        TextureAtlasCategory.Grass.rawValue,
        TextureAtlasCategory.HUD.rawValue,
        TextureAtlasCategory.Ice.rawValue,
        TextureAtlasCategory.Islands.rawValue,
        TextureAtlasCategory.Letter.rawValue,
        TextureAtlasCategory.LevelThumbnails.rawValue,
        TextureAtlasCategory.MenuAssets.rawValue,
        TextureAtlasCategory.MetalTiles.rawValue,
        TextureAtlasCategory.OnScreenControls.rawValue,
        TextureAtlasCategory.Planes.rawValue,
        TextureAtlasCategory.RecordButtons.rawValue,
        TextureAtlasCategory.RegularExplosion.rawValue,
        TextureAtlasCategory.Rocks.rawValue,
        TextureAtlasCategory.RockSpikeGround.rawValue,
        TextureAtlasCategory.RockSpikes.rawValue,
        TextureAtlasCategory.Sand.rawValue,
        TextureAtlasCategory.Spikeball.rawValue,
        TextureAtlasCategory.Spikeman.rawValue,
        TextureAtlasCategory.Spikes.rawValue,
        TextureAtlasCategory.Sun.rawValue,
        TextureAtlasCategory.Trees.rawValue,
        TextureAtlasCategory.UIButtonsBlue.rawValue,
        TextureAtlasCategory.Worm.rawValue
        
    ]
    
    static let commonTextureAtlases: [String] = [
        "Planes",
        "RegularExplosion",
        "Letter",
        "Coins"

    ]
    
    //MARK: ********* Texture atlases below are pre-loaded at the start of the app because of recurring usage throughout different scene-levels (i.e. UI texture atlas)
    
    var uiButtonsTextureAtlas: SKTextureAtlas?
    var hudTextureAtlas: SKTextureAtlas?
    var planeTextureAtlas: SKTextureAtlas?
    var regularExplosionTextureAtlas: SKTextureAtlas?
    var letterTextureAtlas: SKTextureAtlas?
    var coinTextureAtlas: SKTextureAtlas?
    var collectiblesTextureAtlas: SKTextureAtlas?
    var levelThumbnailsAtlas: SKTextureAtlas?
    var recordButtonsAtlas: SKTextureAtlas?
    
    //MARK: ****** Texture atlases below are loaded dynamically per the resource-needs of the particular scene
    
    var alienTextureAtlas: SKTextureAtlas?
    var animalTextureAtlas: SKTextureAtlas?
    var backgroundsTextureAtlas: SKTextureAtlas?
    var backgroundElementsTextureAtlas: SKTextureAtlas?
    var barnacleTextureAtlas: SKTextureAtlas?
    var beeTextureAtlas: SKTextureAtlas?
    var batTextureAtlas: SKTextureAtlas?
    var beamsTextureAtlas: SKTextureAtlas?
    var blockmanTextureAtlas: SKTextureAtlas?
    var bombTextureAtlas: SKTextureAtlas?
    var candyTextureAtlas: SKTextureAtlas?
    var caveTextureAtlas: SKTextureAtlas?
    var flyTextureAtlas: SKTextureAtlas?
    var ghostTextureAtlas: SKTextureAtlas?
    var grassTextureAtlas: SKTextureAtlas?
    var iceTextureAtlas: SKTextureAtlas?
    var islandsTextureAtlas: SKTextureAtlas?
    var metalTilesTextureAtlas: SKTextureAtlas?
    var onScreenControlsTextureAtlas: SKTextureAtlas?
    var rocksTextureAtlas: SKTextureAtlas?
    var rockSpikeGroundTextureAtlas: SKTextureAtlas?
    var rockSpikesTextureAtlas: SKTextureAtlas?
    var sandTextureAtlas: SKTextureAtlas?
    var spikeballTextureAtlas: SKTextureAtlas?
    var spikemanTextureAtlas: SKTextureAtlas?
    var spikesTextureAtlas: SKTextureAtlas?
    var sunTextureAtlas: SKTextureAtlas?
    var treesTextureAtlas: SKTextureAtlas?
    var wormTextureAtlas: SKTextureAtlas?
    
    private init(){
        
        loadCommonTextureAtlases()
    }
    
    private func loadAllTextureAtlases(){
        SKTextureAtlas.preloadTextureAtlasesNamed(TextureAtlasManager.allTextureAtlasNames, withCompletionHandler: { error, allTextureAtlases in
        
            self.uiButtonsTextureAtlas = allTextureAtlases[TextureAtlasKind.UIButtonsBlue.rawValue]
             self.planeTextureAtlas = allTextureAtlases[TextureAtlasKind.Planes.rawValue]
             self.regularExplosionTextureAtlas = allTextureAtlases[TextureAtlasKind.RegularExplosion.rawValue]
             self.letterTextureAtlas = allTextureAtlases[TextureAtlasKind.Letter.rawValue]
             self.coinTextureAtlas = allTextureAtlases[TextureAtlasKind.Coins.rawValue]
             self.collectiblesTextureAtlas = allTextureAtlases[TextureAtlasKind.Collectibles.rawValue]
             self.levelThumbnailsAtlas = allTextureAtlases[TextureAtlasKind.LevelThumbnails.rawValue]
             self.recordButtonsAtlas = allTextureAtlases[TextureAtlasKind.RecordButtons.rawValue]
    
            
             self.alienTextureAtlas = allTextureAtlases[TextureAtlasKind.Alien.rawValue]
             self.animalTextureAtlas = allTextureAtlases[TextureAtlasKind.Animal.rawValue]
             self.backgroundsTextureAtlas = allTextureAtlases[TextureAtlasKind.Backgrounds.rawValue]
            self.backgroundElementsTextureAtlas = allTextureAtlases[TextureAtlasKind.BackgroundElements.rawValue]
             self.beeTextureAtlas = allTextureAtlases[TextureAtlasKind.Bee.rawValue]
             self.batTextureAtlas = allTextureAtlases[TextureAtlasKind.Bat.rawValue]
             self.beamsTextureAtlas = allTextureAtlases[TextureAtlasKind.Beams.rawValue]
             self.blockmanTextureAtlas = allTextureAtlases[TextureAtlasKind.Blockman.rawValue]
             self.bombTextureAtlas = allTextureAtlases[TextureAtlasKind.Bomb.rawValue]
             self.candyTextureAtlas = allTextureAtlases[TextureAtlasKind.Candy.rawValue]
             self.caveTextureAtlas = allTextureAtlases[TextureAtlasKind.Cave.rawValue]
             self.flyTextureAtlas = allTextureAtlases[TextureAtlasKind.Fly.rawValue]
             self.ghostTextureAtlas = allTextureAtlases[TextureAtlasKind.Ghost.rawValue]
             self.grassTextureAtlas = allTextureAtlases[TextureAtlasKind.Grass.rawValue]
             self.hudTextureAtlas = allTextureAtlases[TextureAtlasKind.HUD.rawValue]

             self.iceTextureAtlas = allTextureAtlases[TextureAtlasKind.Ice.rawValue]
             self.islandsTextureAtlas = allTextureAtlases[TextureAtlasKind.Islands.rawValue]
             self.metalTilesTextureAtlas = allTextureAtlases[TextureAtlasKind.MetalTiles.rawValue]
             self.onScreenControlsTextureAtlas = allTextureAtlases[TextureAtlasKind.OnScreenControls.rawValue]
             self.rocksTextureAtlas = allTextureAtlases[TextureAtlasKind.Rocks.rawValue]
             self.rockSpikeGroundTextureAtlas = allTextureAtlases[TextureAtlasKind.RockSpikeGround.rawValue]
             self.rockSpikesTextureAtlas = allTextureAtlases[TextureAtlasKind.RockSpikes.rawValue]
             self.sandTextureAtlas = allTextureAtlases[TextureAtlasKind.Sand.rawValue]
             self.spikeballTextureAtlas = allTextureAtlases[TextureAtlasKind.Spikeball.rawValue]
             self.spikemanTextureAtlas = allTextureAtlases[TextureAtlasKind.Spikeman.rawValue]
             self.spikesTextureAtlas = allTextureAtlases[TextureAtlasKind.Spikes.rawValue]
             self.sunTextureAtlas = allTextureAtlases[TextureAtlasKind.Sun.rawValue]
             self.treesTextureAtlas = allTextureAtlases[TextureAtlasKind.Trees.rawValue]
             self.wormTextureAtlas = allTextureAtlases[TextureAtlasKind.Worm.rawValue]
            
            print("From TextureAtlasManagerSingleton...Loading animal texture atlas \(self.animalTextureAtlas), Index for Animal Atlas: \(TextureAtlasKind.Animal.rawValue), Atlas at animal index in allTexture: \(allTextureAtlases[TextureAtlasKind.Animal.rawValue])")
        })
        
    }
    
    
    
     func loadCommonTextureAtlases(){
        print("Loading common texture atlases...")
        
        
        self.planeTextureAtlas = SKTextureAtlas(named: "Planes")
        self.regularExplosionTextureAtlas = SKTextureAtlas(named: "RegularExplosion")
        self.letterTextureAtlas = SKTextureAtlas(named: "Letter")
        self.coinTextureAtlas = SKTextureAtlas(named: "Coins")
        
        /**
        SKTextureAtlas.preloadTextureAtlasesNamed(TextureAtlasManager.commonTextureAtlases, withCompletionHandler: {
        
            error, commonTextureAtlases in
            
            if error != nil{
                print("Error: error occurred while preloading common texture atlases \(error?.localizedDescription)")
            }
            
            self.planeTextureAtlas = commonTextureAtlases[0]
            self.regularExplosionTextureAtlas = commonTextureAtlases[1]
            self.letterTextureAtlas = commonTextureAtlases[2]
            self.coinTextureAtlas = commonTextureAtlases[3]
           
        })
    
        **/

        print("Common texture atlases loaded!")
    }
    
    func loadSecondaryTextureAtlases(){
        
        if !secondaryTexturesLoaded{
            
            self.beeTextureAtlas = SKTextureAtlas(named: "Bee")
            self.bombTextureAtlas = SKTextureAtlas(named: "Bomb")
            self.beamsTextureAtlas = SKTextureAtlas(named: "Beams")
            self.wormTextureAtlas = SKTextureAtlas(named: "Worm")
            self.rocksTextureAtlas = SKTextureAtlas(named: "Rocks")
            self.flyTextureAtlas = SKTextureAtlas(named: "Fly")
            
            
            secondaryTexturesLoaded = true
        }
    }
    
}
