//
//  UploadImage.swift
//  DEV_epicture_2019
//
//  Created by Guillaume Djaider Fornari on 20/10/2019.
//  Copyright © 2019 Guillaume Djaider Fornari. All rights reserved.
//

import Foundation

struct ImageUpload: Codable {
    let data: InformationImages
}

class UploadImage: ApiProtocol, InfoClientProtocol, ImageProtocol {
    var accessToken: String = ""
    var session: URLSession = URLSession(configuration: .default)
    var task: URLSessionDataTask?
    var url: String = ""
    var request: URLRequest!
    var header: String = ""
    
    func createUrl() {
        guard let accessToken = self.accessToken else {
            self.url = ""
            self.header = ""
            return
        }
        self.url = "https://api.imgur.com/3/upload"
        self.header = "Bearer \(accessToken)"
    }
       
    func getResponseJSON(data: Data, completionHandler: @escaping (Bool, [DataJSON]?) -> Void) {
        do {
            let resultData: InformationImages = try JSONDecoder().decode(ImageUpload.self, from: data).data
            completionHandler(true, [ImagesRecover(data: resultData, image: self.recoverDataImage(urlImage: resultData.link ?? ""))])
        } catch {
            completionHandler(false, nil)
        }
    }
}
