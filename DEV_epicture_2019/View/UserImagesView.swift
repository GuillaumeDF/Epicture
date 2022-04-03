//
//  UserImagesView.swift
//  DEV_epicture_2019
//
//  Created by Guillaume Djaider Fornari on 17/10/2019.
//  Copyright © 2019 Guillaume Djaider Fornari. All rights reserved.
//

import UIKit

class UserImagesView: UIView {

    @IBOutlet weak var uploadImageButton: UIButton!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var uploadImage: UIButton!
    @IBOutlet weak var backgroundUser: UIImageView!
    
    func settUserImagesView(avatar: Data?, cover: Data?) {
        userImage.image = avatar.dataToUIImage
        backgroundUser.image = cover.dataToUIImage
        userImage.layer.cornerRadius = userImage.frame.height/2
        userImage.clipsToBounds = true
        uploadImage.layer.cornerRadius = uploadImage.frame.size.height / 10
        uploadImage.clipsToBounds = true
    }
}
