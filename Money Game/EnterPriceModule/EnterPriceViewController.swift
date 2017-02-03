//
//  EnterPriceViewController.swift
//  Money Game
//
//  Created by iMac on 02.02.17.
//  Copyright © 2017 iMac. All rights reserved.
//

import UIKit

class EnterPriceViewController: UIViewController, KDDragAndDropCollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var priceSourceCollectionView: KDDragAndDropCollectionView!
    @IBOutlet weak var userPriceCollectionView: KDDragAndDropCollectionView!
    
    @IBOutlet weak var helperHand: UIImageView!
    @IBOutlet weak var helperArrow: UIImageView!
    
    private let dataProvider = EnterPriceDataProvider()
    
    private var dragAndDropManager : KDDragAndDropManager?
    
    var isPriceEntered = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBlurToCollectionView()
        
        priceSourceCollectionView.isSourceCollectionView = true
        priceSourceCollectionView.isNeedToInserRows = false
        userPriceCollectionView.isSourceCollectionView = false
        userPriceCollectionView.isNeedToInserRows = false
        
        dragAndDropManager = KDDragAndDropManager(canvas: self.view, collectionViews: [priceSourceCollectionView, userPriceCollectionView])
        
        priceSourceCollectionView.dataSource = self
        priceSourceCollectionView.delegate = self
        
        priceSourceCollectionView.register(UINib(nibName: "EnterPriceSingleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EnterPriceSingleCollectionViewCell")
        priceSourceCollectionView.register(UINib(nibName: "PickMoneyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PickMoneyCollectionViewCell")
        
        userPriceCollectionView.dataSource = self
        userPriceCollectionView.delegate = self
        
        userPriceCollectionView.register(UINib(nibName: "EnterPriceSingleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EnterPriceSingleCollectionViewCell")
        
        if isPriceEntered {
            helperHand.isHidden = true
            helperArrow.isHidden = true
            priceSourceCollectionView.isUserInteractionEnabled = false
            userPriceCollectionView.isUserInteractionEnabled = false
            dataProvider.calculateMoneyByEnteredPrice()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if isPriceEntered {
            AudioPlayerUtility.shared.playAudioFile(fileName: "4stepVoice")
        } else {
            AudioPlayerUtility.shared.playAudioFile(fileName: "3stepVoice")
            anumateHelpers()
        }
    }
    
    func addBlurToCollectionView() {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = priceSourceCollectionView.frame
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.layer.cornerRadius = 10
        blurEffectView.layer.masksToBounds = true
        self.view.insertSubview(blurEffectView, at: 1)
    }
    
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
    
    // MARK: - KDDragAndDropCollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if isPriceEntered {
            if collectionView.isEqual(userPriceCollectionView) {
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EnterPriceSingleCollectionViewCell", for: indexPath) as! EnterPriceSingleCollectionViewCell
                
                cell.customizeCell(value: dataProvider.getPriceItemByIndex(index: indexPath.row), fontSize: 80)
                cell.isHidden = false
                return cell
                
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PickMoneyCollectionViewCell", for: indexPath) as! PickMoneyCollectionViewCell
                cell.customizeCell(image: dataProvider.getMoneyByIndex(index: indexPath.row).image)
                cell.isHidden = false
                return cell
            }
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EnterPriceSingleCollectionViewCell", for: indexPath) as! EnterPriceSingleCollectionViewCell
            
            var fontSize: CGFloat = 110
            
            if collectionView.isEqual(userPriceCollectionView) {
                fontSize = 80
            }
            
            cell.customizeCell(value: dataProvider.getNumberByIndex(index: indexPath.item, isUserData: collectionView.isEqual(userPriceCollectionView)), fontSize: fontSize)
            
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
    }
    
    // MARK : KDDragAndDropCollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, dataItemForIndexPath indexPath: IndexPath) -> AnyObject {
        return dataProvider.getNumberByIndex(index: indexPath.item, isUserData: collectionView.isEqual(userPriceCollectionView)) as AnyObject
    }
    
    func collectionView(_ collectionView: UICollectionView, insertDataItem dataItem : AnyObject, atIndexPath indexPath: IndexPath) -> Void {
        if collectionView.isEqual(priceSourceCollectionView) {
            return
        }
        dataProvider.changeValueByIndex(value: dataItem as! String, index: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, deleteDataItemAtIndexPath indexPath : IndexPath, item: AnyObject) -> Void {
        if !collectionView.isEqual(priceSourceCollectionView) {
            return
        }
        for cell in userPriceCollectionView.visibleCells {
            if cell.isHidden {
                let indexPath = userPriceCollectionView.indexPath(for: cell)
                dataProvider.removeValueByIndex(index: (indexPath?.item)!)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, moveDataItemFromIndexPath from: IndexPath, toIndexPath to : IndexPath) -> Void {
    }
    
    func collectionView(_ collectionView: UICollectionView, indexPathForDataItem dataItem: AnyObject) -> IndexPath? {
        return nil
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isPriceEntered {
            if collectionView.isEqual(userPriceCollectionView) {
                return dataProvider.getCountOfPriceItems()
            } else {
                return dataProvider.getCountOfUserMoneyItems()
            }
        }
        return dataProvider.getCountOfNumbers(isUserData: collectionView.isEqual(userPriceCollectionView))
    }
    
    // MARK: - UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.isEqual(userPriceCollectionView) {
            return CGSize(width: userPriceCollectionView.frame.width / 7, height: 110)
        } else if isPriceEntered {
            if dataProvider.getMoneyByIndex(index: indexPath.row).isCoin {
                return CGSize(width: 80, height: 80)
            } else {
                return CGSize(width: 200, height: 100)
            }
        }
        return CGSize(width: priceSourceCollectionView.frame.width / 6, height: priceSourceCollectionView.frame.width / 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if isPriceEntered {
            return 10
        } else {
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if isPriceEntered {
            return 10
        } else {
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if isPriceEntered && collectionView.isEqual(priceSourceCollectionView) {
            return UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        }
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    // MARK: - Buttons
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func soundButton(_ sender: Any) {
        if isPriceEntered {
            AudioPlayerUtility.shared.playAudioFile(fileName: "4stepVoice")
        } else {
            AudioPlayerUtility.shared.playAudioFile(fileName: "3stepVoice")
        }
    }
    
    @IBAction func donebuttonTouched(_ sender: Any) {
        if isPriceEntered {
            
        } else {
            if !dataProvider.checkIsPriceEntered() {
                AlertUtility.showAlert(fromVC: self, alertText: "Enter price please")
            } else {
                if !dataProvider.checkIsEnoughMoney() {
                    AlertUtility.showAlert(fromVC: self, alertText: "You don't have enough money")
                } else {
                    EnterPriceRouting.showEnterPriceSecondStepScreenScreen(fromVC: self)
                }
            }
        }
    }
    
    
}
