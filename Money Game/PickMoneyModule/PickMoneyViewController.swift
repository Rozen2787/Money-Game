//
//  PickMoneyViewController.swift
//  Money Game
//
//  Created by iMac on 01.02.17.
//  Copyright © 2017 iMac. All rights reserved.
//

import UIKit

class PickMoneyViewController: UIViewController, KDDragAndDropCollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var moneyCollectionView: KDDragAndDropCollectionView!
    
    @IBOutlet weak var userMoneyCollectionView: KDDragAndDropCollectionView!
    
    @IBOutlet weak var helperArrow: UIImageView!
    @IBOutlet weak var helperHand: UIImageView!
    
    
    
    let dataProvider = PickMoneyDataProvider()
    
    var dragAndDropManager : KDDragAndDropManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moneyCollectionView.isSourceCollectionView = true
        userMoneyCollectionView.isSourceCollectionView = false
        
        moneyCollectionView.dataSource = self
        moneyCollectionView.delegate = self
        
        userMoneyCollectionView.dataSource = self
        userMoneyCollectionView.delegate = self
        
        moneyCollectionView.register(UINib(nibName: "PickMoneyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PickMoneyCollectionViewCell")
        
        userMoneyCollectionView.register(UINib(nibName: "PickMoneyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PickMoneyCollectionViewCell")
        
        
        dragAndDropManager = KDDragAndDropManager(canvas: self.view, collectionViews: [moneyCollectionView, userMoneyCollectionView])
        dataProvider.loadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        AudioPlayerUtility.shared.playAudioFile(fileName: "1stepVoice")
        self.anumateHelpers()
        helperHand.isHidden = false
        helperArrow.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        helperHand.isHidden = true
        helperArrow.isHidden = true
    }
    
    // MARK: - KDDragAndDropCollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PickMoneyCollectionViewCell", for: indexPath) as! PickMoneyCollectionViewCell
        cell.customizeCell(image: dataProvider.getMoneyByIndex(index: indexPath.row, isUserData: collectionView.isEqual(userMoneyCollectionView)).image)
        
        cell.isHidden = false
        
        if let kdCollectionView = collectionView as? KDDragAndDropCollectionView {
            
            if let draggingPathOfCellBeingDragged = kdCollectionView.draggingPathOfCellBeingDragged {
                
                if draggingPathOfCellBeingDragged.item == indexPath.item {
                    
                    cell.isHidden = true
                    
                }
            }
        }
        
        return cell
    }
    
    // MARK : KDDragAndDropCollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, dataItemForIndexPath indexPath: IndexPath) -> AnyObject {
        return dataProvider.getMoneyByIndex(index: indexPath.item, isUserData: collectionView.isEqual(userMoneyCollectionView)) as AnyObject
    }
    func collectionView(_ collectionView: UICollectionView, insertDataItem dataItem : AnyObject, atIndexPath indexPath: IndexPath) -> Void {
        if !collectionView.isEqual(userMoneyCollectionView) {
            return
        }
        dataProvider.addMoneyToUser(money: dataItem as! MoneySingleModel)
    }
    
    func collectionView(_ collectionView: UICollectionView, deleteDataItemAtIndexPath indexPath : IndexPath, item: AnyObject) -> Void {
        dataProvider.deleteMoneyFromUser(money: item as! MoneySingleModel)
    }
    
    func collectionView(_ collectionView: UICollectionView, moveDataItemFromIndexPath from: IndexPath, toIndexPath to : IndexPath) -> Void {
    }
    
    func collectionView(_ collectionView: UICollectionView, indexPathForDataItem dataItem: AnyObject) -> IndexPath? {
        return nil
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataProvider.getCountOfMoney(isUserData: collectionView.isEqual(userMoneyCollectionView))
    }
    
    // MARK: - UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if dataProvider.getMoneyByIndex(index: indexPath.row, isUserData: collectionView.isEqual(userMoneyCollectionView)).isCoin {
            return CGSize(width: 80, height: 80)
        } else {
            return CGSize(width: 200, height: 100)
        }
    }
    
    
    // MARK: - Helpers
    
    func anumateHelpers() {
        self.helperArrow.alpha = 1
        self.helperHand.alpha = 1
        self.view.isUserInteractionEnabled = false
        var newCenterPoint = helperArrow.center
        newCenterPoint.y += 200
        
        UIView.animate(withDuration: 3, animations: {
            self.helperHand.center = newCenterPoint
        }) { (Bool) in
            UIView.animate(withDuration: 0.3, animations: {
                self.helperArrow.alpha = 0
                self.helperHand.alpha = 0
                self.view.isUserInteractionEnabled = true
            })
        }
    }
    
    
    // MARK: - Buttons
    
    @IBAction func backButtonTouched(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func playSoundButtonTouched(_ sender: Any) {
        AudioPlayerUtility.shared.playAudioFile(fileName: "1stepVoice")
    }
    
    
    @IBAction func doneButtonTouched(_ sender: Any) {
        if dataProvider.getCountOfMoney(isUserData: true) != 0 {
            dataProvider.saveUsersMoney()
            PurchaseAnimationRouting.showPurchaseAnimationScreen(formVC: self)
        } else {
            AlertUtility.showAlert(fromVC: self, alertText: "Enter your money please")
        }
    }
    
    
}
