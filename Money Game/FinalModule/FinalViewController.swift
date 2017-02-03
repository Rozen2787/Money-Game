//
//  FinalViewController.swift
//  Money Game
//
//  Created by iMac on 03.02.17.
//  Copyright © 2017 iMac. All rights reserved.
//

import UIKit

class FinalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        AudioPlayerUtility.shared.playAudioFile(fileName: "5stepVoice")
    }

    // MARK: - Buttons
    
    @IBAction func backButtonTouched(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func playSoundButtonTouched(_ sender: Any) {
        AudioPlayerUtility.shared.playAudioFile(fileName: "5stepVoice")
    }
    
    
    @IBAction func doneButtonTouched(_ sender: Any) {
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}
