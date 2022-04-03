//
//  GalleryViewCell.swift
//  DEV_epicture_2019
//
//  Created by Guillaume Djaider Fornari on 20/10/2019.
//  Copyright © 2019 Guillaume Djaider Fornari. All rights reserved.
//

import UIKit

class GalleryViewCell: UITableViewCell {

    @IBOutlet weak var imageGallery: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var view: UILabel!
    @IBOutlet weak var accountUrl: UILabel!
    @IBOutlet weak var addFavorite: UIButton!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = self.frame.size.height / 10
        self.clipsToBounds = true
    }

    func setGallery(galleryData: GalleryRecover) {
        self.imageGallery.image = galleryData.image.dataToUIImage
        self.title.text = galleryData.item.title
        self.view.text = "Views: \(String(galleryData.item.images?[0].views ?? 0))"
        self.accountUrl.text = galleryData.item.account_url
    }
}
