//
//  EnterPriceViewController.swift
//  Money Game
//
//  Created by iMac on 02.02.17.
//  Copyright © 2017 iMac. All rights reserved.
//

import UIKit

class EnterPriceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
      //MARK: - Buttons
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func soundButton(_ sender: Any) {
        AudioPlayerUtility.shared.playAudioFile(fileName: "3stepVoice")
    }
    @IBAction func donebuttonTouched(_ sender: Any) {
        PurchaseAnimationRouting.showPurchaseAnimationScreen(formVC: self)

    }
    

}
