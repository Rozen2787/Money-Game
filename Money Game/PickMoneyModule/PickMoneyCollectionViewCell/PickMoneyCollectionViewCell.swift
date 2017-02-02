//
//  PickMoneyCollectionViewCell.swift
//  Money Game
//
//  Created by iMac on 01.02.17.
//  Copyright © 2017 iMac. All rights reserved.
//

import UIKit

class PickMoneyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var moneyImage: UIImageView!
    
    func customizeCell(image: UIImage) {
        moneyImage.image = image
    }

}
