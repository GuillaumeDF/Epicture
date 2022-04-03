//
//  GalleryTags.swift
//  DEV_epicture_2019
//
//  Created by Guillaume Djaider Fornari on 20/10/2019.
//  Copyright © 2019 Guillaume Djaider Fornari. All rights reserved.
//

import Foundation

struct Tags: DataJSON {
    let name: String?
    let display_name: String?
}

struct GallaryData: Codable {
    let tags: [Tags]
}

struct Gallery: Codable {
    let data: GallaryData
}

class GalleryTags: ApiProtocol, InfoClientProtocol {
    var accessToken: String = ""
    var session: URLSession = URLSession(configuration: .default)
    var task: URLSessionDataTask?
    var url: String = ""
    var request: URLRequest!
    var header: String = ""
       
    func createUrl() {
        self.url = "https://api.imgur.com/3/tags"
        self.header = "Client-ID \(self.clientId)"
    }
       
    func getResponseJSON(data: Data, completionHandler: @escaping (Bool, [DataJSON]?) -> Void) {
        do {
            let resultData: [DataJSON] = try JSONDecoder().decode(Gallery.self, from: data).data.tags
            completionHandler(true, resultData)
        } catch {
            completionHandler(false, nil)
        }
    }
}
