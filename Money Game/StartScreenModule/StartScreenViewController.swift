//
//  StartScreenViewController.swift
//  Money Game
//
//  Created by iMac on 11.02.17.
//  Copyright © 2017 iMac. All rights reserved.
//

import UIKit

class StartScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: - Buttons
    
    @IBAction func playButtonTouched(_ sender: Any) {
        PickMoneyRouting.showPickMoneyScreen(fromVC: self)
    }
    
    @IBAction func infoButtonTouched(_ sender: Any) {
        AlertUtility.showAlert(fromVC: self, alertText: "Coming soon")
    }
    
    @IBAction func settingsButtonTouched(_ sender: Any) {
        AlertUtility.showAlert(fromVC: self, alertText: "Coming soon")
    }
    

}
