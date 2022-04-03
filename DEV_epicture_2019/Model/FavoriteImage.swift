//
//  FavoriteImage.swift
//  DEV_epicture_2019
//
//  Created by Guillaume Djaider Fornari on 20/10/2019.
//  Copyright © 2019 Guillaume Djaider Fornari. All rights reserved.
//

import Foundation

class FavoriteImage: ApiProtocol, InfoClientProtocol, ImageProtocol {
    var accessToken: String = ""
    var session: URLSession = URLSession(configuration: .default)
    var task: URLSessionDataTask?
    var url: String = ""
    var request: URLRequest!
    var header: String = ""
    var imageHash: String
    
    init(imageHash: String) {
        self.imageHash = imageHash
    }
    
    func createUrl() {
        guard let accessToken = self.accessToken else {
            self.url = ""
            self.header = ""
            return
        }
        self.url = "https://api.imgur.com/3/image/\(self.imageHash)/favorite"
        self.header = "Bearer \(accessToken)"
    }
       
    func getResponseJSON(data: Data, completionHandler: @escaping (Bool, [DataJSON]?) -> Void) {
        do {
            let resultData: InformationAccount = try JSONDecoder().decode(Account.self, from: data).data
            completionHandler(true, [AccountRecover(data: resultData, avatar: self.recoverDataImage(urlImage: resultData.avatar ?? ""), cover: self.recoverDataImage(urlImage: resultData.cover ?? ""))])
        } catch {
            completionHandler(false, nil)
        }
    }
}
