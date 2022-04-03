//
//  ApiProtocol.swift
//  DEV_epicture_2019
//
//  Created by Guillaume Djaider Fornari on 15/10/2019.
//  Copyright © 2019 Guillaume Djaider Fornari. All rights reserved.
//

import Foundation

protocol DataJSON: Codable {}

protocol ApiProtocol: class {
    var session: URLSession { get set }
    var url: String { set get }
    var request: URLRequest! { set get }
    var task: URLSessionDataTask? { get set }
    var accessToken: String { get set }
    var header: String { get set }
    func createUrl() -> Void
    func newRequestGet(completionHandler: @escaping (Bool, [DataJSON]?) -> Void)
    func newRequestPost(completionHandler: @escaping (Bool, [DataJSON]?) -> Void)
    func newRequestDelete(completionHandler: @escaping (Bool, [DataJSON]?) -> Void)
    func uploadImage(base64Image: String, completionHandler: @escaping (Bool, [DataJSON]?) -> Void)
    func getData(completionHandler: @escaping (Bool, [DataJSON]?) -> Void)
    func getResponseJSON(data: Data, completionHandler: @escaping (Bool, [DataJSON]?) -> Void)
}

extension ApiProtocol {
    
    func newRequestGet(completionHandler: @escaping (Bool, [DataJSON]?) -> Void) {
        self.createUrl()
        guard let url = URL(string: self.url) else {
            completionHandler(false, nil)
            return NotificationCenter.default.post(name: .error, object: ["Error Url", "Can't construct URL"])
        }
        self.request = URLRequest(url: url)
        self.request.httpMethod = "GET"
        self.request.addValue(self.header, forHTTPHeaderField: "Authorization")
        self.getData() { success, data in
            completionHandler(success, data)
        }
    }
    
    func newRequestPost(completionHandler: @escaping (Bool, [DataJSON]?) -> Void) {
        self.createUrl()
        guard let url = URL(string: self.url) else {
            completionHandler(false, nil)
            return NotificationCenter.default.post(name: .error, object: ["Error Url", "Can't construct URL"])
        }
        self.request = URLRequest(url: url)
        self.request.httpMethod = "POST"
        self.request.addValue(self.header, forHTTPHeaderField: "Authorization")
        self.getData() { success, data in
            completionHandler(success, data)
        }
    }
    
    func newRequestDelete(completionHandler: @escaping (Bool, [DataJSON]?) -> Void) {
        self.createUrl()
        guard let url = URL(string: self.url) else {
            completionHandler(false, nil)
            return NotificationCenter.default.post(name: .error, object: ["Error Url", "Can't construct URL"])
        }
        self.request = URLRequest(url: url)
        self.request.httpMethod = "DELETE"
        self.request.addValue(self.header, forHTTPHeaderField: "Authorization")
        self.getData() { success, data in
            completionHandler(true, nil)
        }
    }
    
    func uploadImage(base64Image: String, completionHandler: @escaping (Bool, [DataJSON]?) -> Void) {
        self.createUrl()
        guard let url = URL(string: self.url) else {
            completionHandler(false, nil)
            return NotificationCenter.default.post(name: .error, object: ["Error Url", "Can't construct URL"])
        }
        self.request = URLRequest(url: url)
        self.request.httpMethod = "POST"
        self.request.addValue(self.header, forHTTPHeaderField: "Authorization")
        let boundary = NSUUID().uuidString
        self.request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let body = NSMutableData()
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"image\"\r\n\r\n".data(using: .utf8)!)
        body.append(base64Image.data(using: .utf8)!)
        body.append("\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        self.request.httpBody = body as Data
        self.getData() { success, data in
            completionHandler(success, data)
        }
    }
    
    func getData(completionHandler: @escaping (Bool, [DataJSON]?) -> Void) {
        self.task = self.session.dataTask(with: self.request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completionHandler(false, nil)
                    return NotificationCenter.default.post(name: .error, object: ["Error Data", "Can't recover Data from Api"])
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completionHandler(false, nil)
                    return NotificationCenter.default.post(name: .error, object: ["Error Response", "Error Access from Api"])
                }
                self.getResponseJSON(data: data) { success, data in
                    completionHandler(success, data)
                    return
                }
            }
        }
        self.task?.resume()
    }
}
