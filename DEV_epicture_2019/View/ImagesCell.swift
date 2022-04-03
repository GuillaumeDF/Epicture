//
//  ImagesCell.swift
//  DEV_epicture_2019
//
//  Created by Guillaume Djaider Fornari on 18/10/2019.
//  Copyright © 2019 Guillaume Djaider Fornari. All rights reserved.
//

import UIKit

class ImagesCell: UITableViewCell {

    @IBOutlet weak var imageFavorite: UIImageView!
    @IBOutlet weak var imageUploaded: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = self.frame.size.height / 10
        self.clipsToBounds = true
    }
    
    func setImageCell(image: Data?) {
        self.imageUploaded.image = image.dataToUIImage
    }
    
    func setFavoriteCell(image: Data?) {
        self.imageFavorite.image = image.dataToUIImage
    }
}
