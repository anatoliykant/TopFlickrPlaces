//
//  FullPhotoViewController.swift
//  TopFlickrPlaces
//
//  Created by Pao Mac PC on 02.05.16.
//  Copyright © 2016 anatoliy.kant. All rights reserved.
//

import UIKit

class FullPhotoViewController: UIViewController {//, GalleryViewControllerDelegate {

    @IBOutlet weak var fullImageView: UIImageView!
    @IBOutlet weak var myLabel: UILabel!    
    
    
    //var textLabel = "Empty iconURL"
    //var textLabelPhotoURL = "Empty photoURL"
    var selectPhoto = Photo?()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        setupImage()
        fullImageView.reloadInputViews()
    }
    
    func setupImage() {
        self.fullImageView.updateImageWith(selectPhoto)
        
        guard let aPhoto = selectPhoto else { return }
        
        if aPhoto.name != "" {
            self.myLabel.text = aPhoto.name
        }
        else if aPhoto.photoDescription != "" {
            self.myLabel.text = aPhoto.photoDescription
        } else {
            self.myLabel.text = "Неизвестно"
        }
        
    }
}