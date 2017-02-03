//
//  PickMoneyDataProvider.swift
//  Money Game
//
//  Created by iMac on 01.02.17.
//  Copyright © 2017 iMac. All rights reserved.
//

import UIKit

class PickMoneyDataProvider: NSObject {

    private var moneyData:[MoneySingleModel] = []
    
    private var userMoneyData:[MoneySingleModel] = []

    func loadData() {
        
        let moneyValues: [Double] = [200, 100, 50, 20, 10, 5, 2, 1, 0.20, 0.10, 0.05, 0.02, 0.01]
        
        for item in moneyValues {
            let euroModel = MoneySingleModel(withValue: item)
            moneyData.append(euroModel)
        }
    }
    
    func addMoneyToUser(money: MoneySingleModel) {
        let moneyWithId = money
        moneyWithId.id = String(describing: NSDate())
        userMoneyData.append(moneyWithId)
    }
    
    func deleteMoneyFromUser(money: MoneySingleModel) {
        for (index, item) in userMoneyData.enumerated() {
            if item.id == money.id {
                userMoneyData.remove(at: index)
                return
            }
        }
    }
    
    func getCountOfMoney(isUserData: Bool) -> Int {
        if isUserData {
            return self.userMoneyData.count
        }
        return self.moneyData.count
    }
    
    func getMoneyByIndex(index: Int, isUserData: Bool) -> MoneySingleModel {
        if isUserData {
            return userMoneyData[index]
        }
        return moneyData[index]
    }
    
    func saveUsersMoney() {
        MoneyUserDefaultsUtils.setUserCurrentMoney(money: self.calculateMoney())
    }
    
    func calculateMoney() -> [String:Int] {
        var money: [Double:Int] = [:]
        
        for item in self.userMoneyData {
            if money.keys.contains(item.value) {
                let previousValue = money[item.value]
                money.updateValue(previousValue! + 1, forKey: item.value)
            } else {
                money.updateValue(1, forKey: item.value)
            }
        }
        
        var moneyDictionary: [String:Int] = [:]
        for key in money.keys {
            moneyDictionary.updateValue(money[key]!, forKey: String(key))
        }
        return moneyDictionary
    }
}
