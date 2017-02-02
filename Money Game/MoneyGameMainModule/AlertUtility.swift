//
//  AlertUtility.swift
//  Money Game
//
//  Created by iMac on 01.02.17.
//  Copyright © 2017 iMac. All rights reserved.
//

import UIKit

class AlertUtility: NSObject {

    static func showAlert(fromVC: UIViewController, alertText: String) {
        
        let alertVC = UIAlertController(title: nil, message: alertText, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        fromVC.present(alertVC, animated: true, completion: nil)
        
    }
}
