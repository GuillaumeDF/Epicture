//
//  DetailImageView.swift
//  DEV_epicture_2019
//
//  Created by Guillaume Djaider Fornari on 19/10/2019.
//  Copyright © 2019 Guillaume Djaider Fornari. All rights reserved.
//

import UIKit

class DetailImageView: UIView {

    @IBOutlet weak var imageView: UIImageView!
    
    func setDetailImageView(image: Data?) {
        self.imageView.image = image.dataToUIImage
    }
}
