//
//  AudioPlayerUtility.swift
//  Money Game
//
//  Created by iMac on 01.02.17.
//  Copyright © 2017 iMac. All rights reserved.
//

import UIKit
import AVFoundation

class AudioPlayerUtility: NSObject {

    private var audioPlayer = AVAudioPlayer()

    func playAudioFile(fileName: String) {

        let soundUrl = URL(fileURLWithPath: Bundle.main.path(forResource: fileName, ofType: "mp3")!)
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            try audioPlayer = AVAudioPlayer(contentsOf: soundUrl)
            audioPlayer.stop()
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } catch {
            print(error)
        }
    }
    
    static let shared = AudioPlayerUtility()

}
