//
//  ViewController.swift
//  DEV_epicture_2019
//
//  Created by Guillaume Djaider Fornari on 15/10/2019.
//  Copyright © 2019 Guillaume Djaider Fornari. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    let accessToken = AccessToken()
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = accessToken.url else {
            return
        }
        webView.navigationDelegate = self
        webView.load( URLRequest(url: url))
    }
}

extension ViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        
        if (accessToken.parseRedirectUri(uri: webView.url?.absoluteString) == false) {
            print("Error")
            return
        }
        self.performSegue(withIdentifier: "segueToUserImages", sender: self)
    }
}
