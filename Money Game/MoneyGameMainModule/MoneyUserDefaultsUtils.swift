//
//  MoneyUserDefaultsUtils.swift
//  Money Game
//
//  Created by iMac on 02.02.17.
//  Copyright © 2017 iMac. All rights reserved.
//

import UIKit

class MoneyUserDefaultsUtils: NSObject {

    static func setUserCurrentMoney(money: [String:Int]) { // value:count
        let defaults = UserDefaults.standard
        defaults.set(money, forKey: "USER_MONEY")
        defaults.synchronize()
    }
    
    static func getUserCurrentMoney() -> [String:Int]? {
        return UserDefaults.standard.value(forKey: "USER_MONEY") as? [String : Int]
    }
    
    static func getUsersTotalMoney() -> Double {
        var total: Double = 0
        if let money = self.getUserCurrentMoney() {
            for key in money.keys {
                total += Double(key)! * Double(money[key]!)
            }
        }
        
        return total
    }
    
    static func setUserGoodPrice(price: Double) {
        let defaults = UserDefaults.standard
        defaults.set(price, forKey: "GOOD_PRICE")
        defaults.synchronize()
    }
    
    static func getUserGoodPrice() -> Double? {
        return UserDefaults.standard.double(forKey: "GOOD_PRICE")
    }
    
}
