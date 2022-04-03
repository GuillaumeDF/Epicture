//
//  DeleteImage.swift
//  DEV_epicture_2019
//
//  Created by Guillaume Djaider Fornari on 20/10/2019.
//  Copyright © 2019 Guillaume Djaider Fornari. All rights reserved.
//

import Foundation

class DeleteImage: ApiProtocol, InfoClientProtocol {
    var accessToken: String = ""
    var session: URLSession = URLSession(configuration: .default)
    var task: URLSessionDataTask?
    var url: String = ""
    var request: URLRequest!
    var header: String = ""
    var deleteHash: String
       
    init (deleteHash: String) {
        self.deleteHash = deleteHash
    }
    
    func createUrl() {
        guard let username = self.accountUsername,
            let accessToken = self.accessToken else {
                self.url = ""
                self.header = ""
                return
            }
        self.url = "https://api.imgur.com/3/account/\(username)/image/\(self.deleteHash)"
        self.header = "Bearer \(accessToken)"
    }
       
    func getResponseJSON(data: Data, completionHandler: @escaping (Bool, [DataJSON]?) -> Void) {
        completionHandler(true, nil)
    }
}
