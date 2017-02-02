//
//  MoneySingleModel.swift
//  Money Game
//
//  Created by iMac on 01.02.17.
//  Copyright © 2017 iMac. All rights reserved.
//

import UIKit

class MoneySingleModel: Equatable {

    var id: String!
    var image: UIImage!
    var value: Double!
    var isCoin = false
    
    init(withValue: Double) {
        self.value = withValue
    
        isCoin = withValue <= 2
        
        if value >= 1 {
            let intValue = Int(withValue)
            image = UIImage(named: "\(intValue)euro")
        } else {
            let intValue = Int(withValue * 100)
            image = UIImage(named: "\(intValue)cents")
        }
    }
    
}

func ==(lhs: MoneySingleModel, rhs: MoneySingleModel) -> Bool {
    return false
}

