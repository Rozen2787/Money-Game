//
//  FinalRouting.swift
//  Money Game
//
//  Created by iMac on 03.02.17.
//  Copyright © 2017 iMac. All rights reserved.
//

import UIKit

class FinalRouting: NSObject {
    
    static func showFinalScreen(fromVC: UIViewController) {
        
        let vc = UIStoryboard(name: "FinalStoryboard", bundle: nil).instantiateInitialViewController() as! FinalViewController
        fromVC.present(vc, animated: true, completion: nil)
        
    }
    
}
