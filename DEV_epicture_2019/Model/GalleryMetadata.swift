//
//  GalleryMetadata.swift
//  DEV_epicture_2019
//
//  Created by Guillaume Djaider Fornari on 20/10/2019.
//  Copyright © 2019 Guillaume Djaider Fornari. All rights reserved.
//

import Foundation

struct GalleryImage: Codable {
    let views: Int?
    let link: String?
}

struct Item: DataJSON {
    let title: String?
    let cover: String?
    let account_url: String?
    let images: [GalleryImage]?
    
}

struct GalleryItems: Codable {
    let items: [Item]
}

struct GalleryData: Codable {
    let data: GalleryItems
}

struct GalleryRecover: DataJSON {
    let item: Item
    let image: Data?
}

class GalleryMetadata: ApiProtocol, InfoClientProtocol, ImageProtocol {
    var accessToken: String = ""
    var session: URLSession = URLSession(configuration: .default)
    var task: URLSessionDataTask?
    var url: String = ""
    var request: URLRequest!
    var header: String = ""
    var tagName: String
    
    init(tagName: String) {
        self.tagName = tagName
    }
    
    func createUrl() {
        self.url = "https://api.imgur.com/3/gallery/t/\(self.tagName)/1"
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
