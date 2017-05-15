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
    
    static let sharedManager = TextureAtlasManager()
    
    static let commonTextureAtlases: [String] = [
        "UIButtonsBlue",
        "HUD",
        "Planes",
        "RegularExplosion",
        "Letter",
        "Coins",
        "Collectibles",
        "LevelThumbnails",
        "RecordButtons"
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
    var backgroundsTextureAtlas: SKTextureAtlas?
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
    
    
    private func loadCommonTextureAtlases(){
        SKTextureAtlas.preloadTextureAtlasesNamed(TextureAtlasManager.commonTextureAtlases, withCompletionHandler: {
        
            error, commonTextureAtlases in
            
            if error != nil{
                print("Error: error occurred while preloading common texture atlases \(error?.localizedDescription)")
            }
            
            self.uiButtonsTextureAtlas = commonTextureAtlases[0]
            self.hudTextureAtlas = commonTextureAtlases[1]
            self.planeTextureAtlas = commonTextureAtlases[2]
            self.regularExplosionTextureAtlas = commonTextureAtlases[3]
            self.letterTextureAtlas = commonTextureAtlases[4]
            self.coinTextureAtlas = commonTextureAtlases[5]
            self.collectiblesTextureAtlas = commonTextureAtlases[6]
            self.levelThumbnailsAtlas = commonTextureAtlases[7]
            self.recordButtonsAtlas = commonTextureAtlases[8]
        })
        
    }
}
