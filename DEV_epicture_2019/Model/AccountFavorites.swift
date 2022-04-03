//
//  AccountFavorites.swift
//  DEV_epicture_2019
//
//  Created by Guillaume Djaider Fornari on 20/10/2019.
//  Copyright © 2019 Guillaume Djaider Fornari. All rights reserved.
//

import Foundation

class AccountFavorites: ApiProtocol, InfoClientProtocol, ImageProtocol {
    var accessToken: String = ""
    var session: URLSession = URLSession(configuration: .default)
    var task: URLSessionDataTask?
    var url: String = ""
    var request: URLRequest!
    var header: String = ""
       
    func createUrl() {
        guard let username = self.accountUsername,
        let accessToken = self.accessToken else {
            self.url = ""
            self.header = ""
            return
        }
        self.url = "https://api.imgur.com/3/account/\(username)/favorites"
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
