//
//  PurchaseAnimationViewController.swift
//  Money Game
//
//  Created by iMac on 01.02.17.
//  Copyright © 2017 iMac. All rights reserved.
//

import UIKit

class PurchaseAnimationViewController: UIViewController {
    
    @IBOutlet weak var bottleImage: UIImageView!
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        AudioPlayerUtility.shared.playAudioFile(fileName: "2stepVoice")
        animateGood()
    }
    
    func animateGood() {
        
        UIView.animate(withDuration: 3, animations: { 
            let newCenterPoint = CGPoint(x: self.view.center.x, y: self.view.frame.height - 150)
            self.bottleImage.center = newCenterPoint
            
        }) { (bool) in
           EnterPriceRouting.showEnterPriceScreen(fromVC: self)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func backButtonTouched(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
