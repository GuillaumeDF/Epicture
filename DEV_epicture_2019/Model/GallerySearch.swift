//
//  GallerySearch.swift
//  DEV_epicture_2019
//
//  Created by Guillaume Djaider Fornari on 20/10/2019.
//  Copyright © 2019 Guillaume Djaider Fornari. All rights reserved.
//

import Foundation

class GallerySearch: ApiProtocol, InfoClientProtocol, ImageProtocol {
    var accessToken: String = ""
    var session: URLSession = URLSession(configuration: .default)
    var task: URLSessionDataTask?
    var url: String = ""
    var request: URLRequest!
    var header: String = ""
    var searchTag: String
    
    init(searchTag: String) {
        self.searchTag = searchTag
    }
    
    func createUrl() {
        self.url = "https://api.imgur.com/3/gallery/t/\(self.searchTag)/1"
        self.header = "Client-ID \(self.clientId)"
    }
       
    func getResponseJSON(data: Data, completionHandler: @escaping (Bool, [DataJSON]?) -> Void) {
        do {
            var resultRecover: [GalleryRecover] = []
            var resultData: [DataJSON] = try JSONDecoder().decode(GalleryData.self, from: data).data.items
            if (resultData.count > 10) {
                resultData = Array(resultData.prefix(10))
            }
            for image in resultData as! [Item] {
                resultRecover.append(GalleryRecover(item: image, image: self.recoverDataImage(urlImage: image.images?[0].link ?? "")))
            }
            completionHandler(true, resultRecover)
        } catch {
            print(error)
            completionHandler(false, nil)
        }
    }
}
