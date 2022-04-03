//
//  GalleryController.swift
//  DEV_epicture_2019
//
//  Created by Guillaume Djaider Fornari on 20/10/2019.
//  Copyright © 2019 Guillaume Djaider Fornari. All rights reserved.
//

import UIKit

class GalleryController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var activityTableView: UIActivityIndicatorView!
    @IBOutlet weak var tableViewGallery: UITableView!
    
    var tags: [Tags] = []
    var imagesGallery: [GalleryRecover] = []
    var rowPicked: Int = 0
    let test = GalleryTags()
    //let test1 = GalleryMetadata()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(displayError), name: .error, object: nil)
        test.newRequestGet { success, data in
            if (success) {
                self.tags = data as! [Tags]
                GalleryMetadata(tagName: self.tags[0].name ?? "").newRequestGet { success, data in
                    if (success) {
                        self.pickerView.reloadAllComponents()
                        self.pickerView.isHidden = false
                        self.imagesGallery = data as! [GalleryRecover]
                        self.tableViewGallery.reloadData()
                        self.tableViewGallery.isHidden = false
                        self.activityTableView.stopAnimating()
                    }
                }
            }
        }
    }
    
    @IBAction func newResearch(_ sender: Any) {
        GalleryMetadata(tagName: self.tags[self.rowPicked].name ?? "").newRequestGet { success, data in
            if (success) {
                self.imagesGallery = data as! [GalleryRecover]
                self.tableViewGallery.reloadData()
            }
        }
    }
    
    @objc func addFavorite(sender : UIButton!) {
        let row = sender.tag
        let alert = UIAlertController(title: "Are you sure you want to add this photo ?", message: "This image will be favorite from your account", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            FavoriteImage(imageHash: self.imagesGallery[row].item.cover ?? "").newRequestPost {_,_ in
                NotificationCenter.default.post(name: .reloadImages, object: nil)
            }
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
}

extension GalleryController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imagesGallery.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: GalleryViewCell = tableView.dequeueReusableCell(withIdentifier: "GalleryCell") as! GalleryViewCell
        
        cell.setGallery(galleryData: imagesGallery[indexPath.row])
        cell.addFavorite.tag = indexPath.row
        cell.addFavorite.addTarget(self, action:#selector(self.addFavorite(sender:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230.0
    }
}

extension GalleryController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tags.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tags[row].display_name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.rowPicked = row
    }
}

extension GalleryController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        GallerySearch(searchTag: searchBar.text ?? "").newRequestGet { success, data in
            if (success) {
                self.imagesGallery = data as! [GalleryRecover]
                self.tableViewGallery.reloadData()
            }
            
        }
        searchBar.resignFirstResponder()
    }
}
