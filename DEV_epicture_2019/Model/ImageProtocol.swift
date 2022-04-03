//
//  ImageProtocol.swift
//  DEV_epicture_2019
//
//  Created by Guillaume Djaider Fornari on 20/10/2019.
//  Copyright © 2019 Guillaume Djaider Fornari. All rights reserved.
//

import Foundation

protocol ImageProtocol: class {
    func recoverDataImage(urlImage: String) -> Data?
}

extension ImageProtocol {
    
    func recoverDataImage(urlImage: String) -> Data? {
        if URL(string: urlImage) != nil {
            return try? Data(contentsOf: URL(string: urlImage)!)
        }
        return nil
    }
}
