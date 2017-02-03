//
//  EnterPriceDataProvider.swift
//  Money Game
//
//  Created by iMac on 02.02.17.
//  Copyright © 2017 iMac. All rights reserved.
//

import UIKit

class EnterPriceDataProvider: NSObject {
    
    private let numbers:[String] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    private var userNumbers:[String] = ["_", "_", ".", "_", "_", "€"]
    
    private var moneyByPrice: [MoneySingleModel] = []
    
    private var priceArray:[String] = []
    
    
    // First step data methods
    func getCountOfNumbers(isUserData: Bool) -> Int {
        if isUserData {
            return userNumbers.count
        } else {
            return numbers.count
        }
    }
    
    func getNumberByIndex(index: Int, isUserData: Bool) -> String {
        if isUserData {
            return userNumbers[index]
        } else {
            return numbers[index]
        }
    }
    
    func changeValueByIndex(value: String, index: Int) {
        if index != 2 && index != 5 {
            userNumbers[index] = value
        }
    }
    
    func removeValueByIndex(index: Int) {
        if index != 2 && index != 5 {
            userNumbers[index] = "_"
        }
    }
    
    private func getPriceFromString() -> Double? {
        var priceString = ""
        
        for item in userNumbers {
            if item != "_" && item != "€" {
                priceString += item
            }
        }
        
        return Double(priceString)
    }
    
    func checkIsPriceEntered() -> Bool {
        if getPriceFromString() != nil && getPriceFromString() != 0 {
            return true
        }
        
        return false
    }
    
    func checkIsEnoughMoney() -> Bool {
        let usersMoney = MoneyUserDefaultsUtils.getUsersTotalMoney()
        
        if let price = getPriceFromString() {
            if price <= usersMoney {
                MoneyUserDefaultsUtils.setUserGoodPrice(price: price)
                return true
            }
        }
        
        return false
    }
    
    // Second step data methods
    
    func getCountOfUserMoneyItems() -> Int {
        return self.moneyByPrice.count
    }
    
    func getMoneyByIndex(index: Int) -> MoneySingleModel {
        return self.moneyByPrice[index]
    }
    
    func getCountOfPriceItems() -> Int {
        return self.priceArray.count
    }
    func getPriceItemByIndex(index: Int) -> String {
        return self.priceArray[index]
    }
    
    func calculateMoneyByEnteredPrice() {
        self.moneyByPrice = []
        
        var userMoney = self.getUserMoneyData()
        var price = MoneyUserDefaultsUtils.getUserGoodPrice()!
        
        while price > 0 {
            for (index, item) in userMoney.enumerated() {
                moneyByPrice.append(item)
                userMoney.remove(at: index)
                price -= item.value
                break
            }
        }
        
        setPriceArray()
    }
    
    private func setPriceArray() {
        self.priceArray = []
        
        let euros = Int(MoneyUserDefaultsUtils.getUserGoodPrice()!)
        let cents = Int((MoneyUserDefaultsUtils.getUserGoodPrice()! - Double(euros)) * 100)
        
        if euros > 9 {
            let eurosString = "\(euros)"
            priceArray.append("\(eurosString.characters.first!)")
            priceArray.append("\(eurosString.characters.last!)")
        } else {
            priceArray.append("")
            priceArray.append("\(euros)")
        }
        
        priceArray.append(".")
        
        if cents > 9 {
            let centsString = "\(cents)"
            priceArray.append("\(centsString.characters.first!)")
            priceArray.append("\(centsString.characters.last!)")
        } else {
            priceArray.append("0")
            priceArray.append("\(cents)")
        }
        
        
        priceArray.append("€")
        
    }
    
    private func getUserMoneyData() -> [MoneySingleModel] {
        var usersMoneyDictionary = MoneyUserDefaultsUtils.getUserCurrentMoney()!
        
        var usersMoney: [MoneySingleModel] = []
        
        for key in usersMoneyDictionary.keys {
            let moneyItem = MoneySingleModel(withValue: Double(key)!)
            for _ in 0 ..< usersMoneyDictionary[key]! {
                usersMoney.append(moneyItem)
            }
        }
        usersMoney.sort(by: { $0.value > $1.value})
        
        return usersMoney
    }
    
}
