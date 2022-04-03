//
//  UserImagesController.swift
//  DEV_epicture_2019
//
//  Created by Guillaume Djaider Fornari on 17/10/2019.
//  Copyright © 2019 Guillaume Djaider Fornari. All rights reserved.
//

import UIKit

class UserImagesController: UIViewController {

    @IBOutlet var userImagesView: UserImagesView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableViewImages: UITableView!
    @IBOutlet weak var collectionViewInformation: UICollectionView!
    
    let imagePicker = UIImagePickerController()
    var images: [ImagesRecover] = []
    var imageToSend: ImagesRecover?
    var account: AccountRecover?
    var indexImage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(displayError), name: .error, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadImages), name: .reloadImages, object: nil)
        AccountBase().newRequestGet { success, data in
            if (success) {
                self.account = (data![0] as! AccountRecover)
                self.userImagesView.settUserImagesView(avatar: self.account?.avatar, cover: self.account?.cover)
                UserImages().newRequestGet { success, data in
                    if (success) {
                        self.images = data as! [ImagesRecover]
                        self.tableViewImages.isHidden = false
                        self.tableViewImages.reloadData()
                        self.activityIndicator.stopAnimating()
                        self.collectionViewInformation.reloadData()
                        self.collectionViewInformation.isHidden = false
                    }
                }
            }
        }
    }
    
    @objc func reloadImages() {
        self.images.remove(at: indexImage)
        self.tableViewImages.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetailImages" {
            let successVC = segue.destination as! DetailImageController
            successVC.imageReceived = imageToSend
        }
    }
    
    @IBAction func uploadImage(_ sender: Any) {
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
}

extension UserImagesController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ImagesCell = tableView.dequeueReusableCell(withIdentifier: "ImagesCell") as! ImagesCell
        cell.setImageCell(image: self.images[indexPath.row].image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         self.indexImage = indexPath.row
        self.imageToSend = self.images[indexPath.row]
        self.performSegue(withIdentifier: "segueToDetailImages", sender: self)
    }
}

extension UserImagesController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var information: [(String, String)] {
        return [("Name", self.account?.data.url ?? "No Name"),
                ("Reputation", String(self.account?.data.reputation ?? 0)),
                ("Reputation Name", self.account?.data.reputation_name ?? "No Reputaion"),
                ("Created on", (self.account?.data.created ?? 0).timeStampToDate())]
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return information.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: AccountViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AccountViewCell", for: indexPath) as! AccountViewCell
        cell.setAccountCell(key: information[indexPath.row].0, value: information[indexPath.row].1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 253, height: 67)
    }
}

extension UserImagesController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        imagePicker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[.originalImage] as? UIImage else {
            return
        }
        let imageData = selectedImage.pngData()
        let base64Image = imageData?.base64EncodedString() ?? ""
        UploadImage().uploadImage(base64Image: base64Image) { success, data in
            if (success) {
                self.images.append(data?[0] as! ImagesRecover)
                self.tableViewImages.reloadData()
            }
        }
    }
}
