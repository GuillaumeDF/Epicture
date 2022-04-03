//
//  UserImages.swift
//  DEV_epicture_2019
//
//  Created by Guillaume Djaider Fornari on 17/10/2019.
//  Copyright © 2019 Guillaume Djaider Fornari. All rights reserved.
//

import Foundation

struct InformationImages: DataJSON {
    let id: String?
    let title: String?
    let description: String?
    let datetime: Int?
    let type: String?
    let views: Int?
    let vote: String?
    let link: String?
    let deletehash: String?
}

struct Images: Codable {
    let data: [InformationImages]
}

struct ImagesRecover: DataJSON {
    let data: InformationImages
    let image: Data?
}

class UserImages: ApiProtocol, InfoClientProtocol, ImageProtocol {
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
        self.url = "https://api.imgur.com/3/account/me/images"
        self.header = "Bearer \(accessToken)"
    }
       
    func getResponseJSON(data: Data, completionHandler: @escaping (Bool, [DataJSON]?) -> Void) {
        do {
            var resultRecover: [ImagesRecover] = []
            let resultData: [DataJSON] = try JSONDecoder().decode(Images.self, from: data).data
            
            for image in resultData as! [InformationImages] {
                resultRecover.append(ImagesRecover(data: image, image: self.recoverDataImage(urlImage: image.link ?? "")))
            }
            completionHandler(true, resultRecover)
        } catch {
            completionHandler(false, nil)
        }
    }
}
