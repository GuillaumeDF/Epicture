//
//  ButtonSearchView.swift
//  DEV_epicture_2019
//
//  Created by Guillaume Djaider Fornari on 20/10/2019.
//  Copyright © 2019 Guillaume Djaider Fornari. All rights reserved.
//

import UIKit

class ButtonSearchView: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = self.frame.size.height / 10
        self.clipsToBounds = true
    }
}
