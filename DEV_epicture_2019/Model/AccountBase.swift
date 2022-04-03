//
//  AccountBase.swift
//  DEV_epicture_2019
//
//  Created by Guillaume Djaider Fornari on 18/10/2019.
//  Copyright © 2019 Guillaume Djaider Fornari. All rights reserved.
//

import Foundation

struct InformationAccount: DataJSON {
    let url: String?
    let reputation_name: String?
    let avatar: String?
    let cover: String?
    let reputation: Int?
    let created: Int?
}

struct Account: Codable {
    let data: InformationAccount
}

struct AccountRecover: DataJSON {
    let data: InformationAccount
    let avatar: Data?
    let cover: Data?
}

class AccountBase: ApiProtocol, InfoClientProtocol, ImageProtocol {
    var accessToken: String = ""
    var session: URLSession = URLSession(configuration: .default)
    var task: URLSessionDataTask?
    var url: String = ""
    var request: URLRequest!
    var header: String = ""
       
    func createUrl() {
        guard let username = self.accountUsername else {
            self.url = ""
            self.header = ""
            return
        }
        self.url = "https://api.imgur.com/3/account/\(username)"
        self.header = "Client-ID \(self.clientId)"
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
