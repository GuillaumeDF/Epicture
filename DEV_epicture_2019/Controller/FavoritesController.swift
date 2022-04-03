//
//  FavoritesController.swift
//  DEV_epicture_2019
//
//  Created by Guillaume Djaider Fornari on 20/10/2019.
//  Copyright © 2019 Guillaume Djaider Fornari. All rights reserved.
//

import UIKit

class FavoritesController: UIViewController {

    @IBOutlet weak var tableFavoritesView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var images: [ImagesRecover] = []
    var imageToSend: ImagesRecover?
    var indexImage = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadImages), name: .reloadImages, object: nil)
        AccountFavorites().newRequestGet { success, data in
            if (success) {
                self.images = data as! [ImagesRecover]
                self.tableFavoritesView.isHidden = false
                self.activityIndicator.stopAnimating()
                self.tableFavoritesView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetailFavorite" {
            let successVC = segue.destination as! DetailImageController
            successVC.imageReceived = imageToSend
        }
    }
    
    @objc func reloadImages() {
        AccountFavorites().newRequestGet { success, data in
            if (success) {
                self.images = data as! [ImagesRecover]
                self.tableFavoritesView.reloadData()
            }
        }
    }
}

extension FavoritesController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ImagesCell = tableView.dequeueReusableCell(withIdentifier: "FavoritesCell") as! ImagesCell
        cell.setFavoriteCell(image: self.images[indexPath.row].image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.indexImage = indexPath.row
        self.imageToSend = self.images[indexPath.row]
        self.performSegue(withIdentifier: "segueToDetailFavorite", sender: self)
    }
}
