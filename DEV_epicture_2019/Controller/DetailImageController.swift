//
//  DetailImageController.swift
//  DEV_epicture_2019
//
//  Created by Guillaume Djaider Fornari on 18/10/2019.
//  Copyright © 2019 Guillaume Djaider Fornari. All rights reserved.
//

import UIKit

class DetailImageController: UIViewController {

    @IBOutlet var detailImageView: DetailImageView!
    var imageReceived: ImagesRecover?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.detailImageView.setDetailImageView(image: imageReceived?.image)
    }
    
    @IBAction func deleteImage(_ sender: Any) {
        let alert = UIAlertController(title: "Are you sure you want to delete this photo ?", message: "This image will be deleted from your account", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            DeleteImage(deleteHash: self.imageReceived?.data.deletehash ?? "").newRequestDelete {_,_ in
                NotificationCenter.default.post(name: .reloadImages, object: nil)
            }
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
}

extension DetailImageController: UITableViewDataSource, UITableViewDelegate {
    
    var informationImage: [(String, String)] {
        return [("Title", self.imageReceived?.data.title ?? "No title"),
                ("Description", self.imageReceived?.data.description ?? "No description"),
                ("Created on", (self.imageReceived?.data.datetime ?? 0).timeStampToDate()),
                ("Views", String(self.imageReceived?.data.views ?? 0)),
                ("Vote", self.imageReceived?.data.vote ?? "No vote")]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return informationImage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DetailImageViewCell = tableView.dequeueReusableCell(withIdentifier: "DetailImageCell") as! DetailImageViewCell
        
        cell.setCellDetailImage(key: informationImage[indexPath.row].0, value: informationImage[indexPath.row].1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 51.0
    }
    
}
