//
//  EnterPriceSingleCollectionViewCell.swift
//  Money Game
//
//  Created by iMac on 02.02.17.
//  Copyright © 2017 iMac. All rights reserved.
//

import UIKit

class EnterPriceSingleCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    
    
    func customizeCell(value: String, fontSize: CGFloat) {
        self.priceLabel.text = value
        self.priceLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
    }

}
