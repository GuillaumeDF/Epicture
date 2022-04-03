//
//  AccessToken.swift
//  DEV_epicture_2019
//
//  Created by Guillaume Djaider Fornari on 15/10/2019.
//  Copyright © 2019 Guillaume Djaider Fornari. All rights reserved.
//

import Foundation

class AccessToken: InfoClientProtocol {
    var url: URL?
    
    init() {
        self.url = URL(string: "https://api.imgur.com/oauth2/authorize?client_id=" + self.clientId + "&response_type=token&state=APPLICATION_STATE")
    }
    
    func setInfoClient(dict: [String:String]) -> Bool {
        guard let refreshToken: String = dict["refresh_token"],
            let accountUsername: String = dict["account_username"],
            let accountId: String = dict["account_id"],
            let tokenType: String = dict["token_type"],
            let expiresIn: String = dict["expires_in"],
            let accessToken: String = dict["access_token"]
            else {
                return false
        }
        UserDefaults.standard.set(accessToken, forKey: "accessToken")
        UserDefaults.standard.set(expiresIn, forKey: "expiresIn")
        UserDefaults.standard.set(tokenType, forKey: "tokenType")
        UserDefaults.standard.set(refreshToken, forKey: "refreshToken")
        UserDefaults.standard.set(accountUsername, forKey: "accountUsername")
        UserDefaults.standard.set(accountId, forKey: "accountId")
        return true
    }
    
    func parseRedirectUri(uri: String?) -> Bool {
        guard let uri: String = uri else {
            return false
        }
        var arr = uri.components(separatedBy:"#")
        arr = arr[1].components(separatedBy:"&")
        var dict = [String:String]()
        for row in arr {
            let pairs = row.components(separatedBy:"=")
            dict[pairs[0]] = pairs[1]
        }
        return self.setInfoClient(dict: dict)
    }
}
