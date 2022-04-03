//
//  InfoClientProtocol.swift
//  DEV_epicture_2019
//
//  Created by Guillaume Djaider Fornari on 15/10/2019.
//  Copyright © 2019 Guillaume Djaider Fornari. All rights reserved.
//

import Foundation

protocol InfoClientProtocol: class {
    var clientId: String { get }
    var clientSecret: String { get }
    var accessToken: String? { get }
    var expireIn: String? { get }
    var tokenType: String? { get }
    var refreshToken: String? { get }
    var accountUsername: String? { get }
    var accountId: String? { get }
}

extension InfoClientProtocol {
    var clientId: String {
        return ("6a674c238282857")
    }
    
    var clientSecret: String {
        return ("5a2eaad34dc82f0ecc17bbc5d31e16ff009331bc")
    }
    
    var accessToken: String? {
        return (UserDefaults.standard.string(forKey: "accessToken") ?? nil)
    }
    
    var expireIn: String? {
        return (UserDefaults.standard.string(forKey: "expireIn") ?? nil)
    }
    
    var tokenType: String? {
        return (UserDefaults.standard.string(forKey: "tokenType") ?? nil)
    }
    
    var refreshToken: String? {
        return (UserDefaults.standard.string(forKey: "refreshToken") ?? nil)
    }
    
    var accountUsername: String? {
        return (UserDefaults.standard.string(forKey: "accountUsername") ?? nil)
    }
    
    var accountId: String? {
        return (UserDefaults.standard.string(forKey: "accountId") ?? nil)
    }
}
