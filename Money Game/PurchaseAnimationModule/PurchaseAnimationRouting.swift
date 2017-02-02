//
//  PurchaseAnimationRouting.swift
//  Money Game
//
//  Created by iMac on 01.02.17.
//  Copyright © 2017 iMac. All rights reserved.
//

import UIKit

class PurchaseAnimationRouting: NSObject {
    
    static func showPurchaseAnimationScreen(formVC: UIViewController) {
        let vc = UIStoryboard(name: "PurchaseAnimationStoryboard", bundle: nil).instantiateInitialViewController() as!
        PurchaseAnimationViewController
        formVC.present(vc, animated: true, completion: nil)
        
    }
    
    
}
