//
//  AccountViewCell.swift
//  DEV_epicture_2019
//
//  Created by Guillaume Djaider Fornari on 18/10/2019.
//  Copyright © 2019 Guillaume Djaider Fornari. All rights reserved.
//

import UIKit

class AccountViewCell: UICollectionViewCell {
    
    @IBOutlet weak var key: UILabel!
    @IBOutlet weak var value: UILabel!
    
    func setAccountCell(key: String, value: String) {
        self.key.text = key
        self.value.text = value
    }
}
