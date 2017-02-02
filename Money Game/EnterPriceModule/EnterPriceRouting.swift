//
//  EnterPriceRouting.swift
//  Money Game
//
//  Created by iMac on 02.02.17.
//  Copyright © 2017 iMac. All rights reserved.
//

import UIKit

class EnterPriceRouting: NSObject {
    static func showEnterPriceScreen(fromVC:UIViewController){
        let storyboard = UIStoryboard(name: "EnterPriceStoryboard", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! EnterPriceViewController
        fromVC.present(vc, animated: true, completion: nil)
    }
}



