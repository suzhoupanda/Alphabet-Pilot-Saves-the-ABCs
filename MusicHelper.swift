//
//  MusicHelper.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/21/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import AVFoundation

class MusicHelper {
    
    
    static let sharedHelper = MusicHelper()
    var audioPlayer: AVAudioPlayer?
    
    func playBackgroundMusic(musicFileName: String) {
        
        let musicResource = URL(fileURLWithPath: Bundle.main.path(forResource: musicFileName, ofType: "mp3")!)
        
       
        do {
            audioPlayer = try AVAudioPlayer(contentsOf:musicResource)
            audioPlayer!.numberOfLoops = -1
            audioPlayer!.prepareToPlay()
            audioPlayer!.play()
        } catch {
            print("Cannot play the file")
        }
    }
    
    func turnOffBackgroundMusic(){
        
        if let audioPlayer = audioPlayer{
            audioPlayer.stop()

        }
        
    }
}
