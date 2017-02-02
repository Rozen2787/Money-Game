//
//  PickMoneyRouting.swift
//  Money Game
//
//  Created by iMac on 01.02.17.
//  Copyright © 2017 iMac. All rights reserved.
//

import UIKit

class PickMoneyRouting: NSObject {
    
    static func showPickMoneyScreen(fromVC: UIViewController) {
        
        let vc = UIStoryboard(name: "PickMoneyStoryboard", bundle: nil).instantiateInitialViewController() as! PickMoneyViewController
        fromVC.present(vc, animated: true, completion: nil)
        
    }

}
