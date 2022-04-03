//
//  DetailImageViewCell.swift
//  DEV_epicture_2019
//
//  Created by Guillaume Djaider Fornari on 19/10/2019.
//  Copyright © 2019 Guillaume Djaider Fornari. All rights reserved.
//

import UIKit

class DetailImageViewCell: UITableViewCell {

    @IBOutlet weak var key: UILabel!
    @IBOutlet weak var value: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setCellDetailImage(key: String, value: String) {
        self.key.text = key
        self.value.text = value
    }
    
}
