//
//  Extension.swift
//  DEV_epicture_2019
//
//  Created by Guillaume Djaider Fornari on 18/10/2019.
//  Copyright © 2019 Guillaume Djaider Fornari. All rights reserved.
//

import Foundation
import UIKit


extension Notification.Name {
    static let error = Notification.Name("error")
    static let reloadImages = Notification.Name("reloadImages")
}

extension UIViewController {
    
    func displayAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    @objc func displayError(notification :Notification) {
        guard let dataError = notification.object as? [String] else {
            return
        }
        self.displayAlert(title: dataError[0], message: dataError[1])
    }
}

extension Optional where Wrapped == Data {
    
    var dataToUIImage: UIImage {
        if self != nil, let image = UIImage(data: self!) {
            return image
        }
        return  UIImage(named: "notFound")!
    }
    
}

extension Int {

    func timeStampToDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        return (formatter.string(from: Date(timeIntervalSince1970: TimeInterval(self))))
    }
}
