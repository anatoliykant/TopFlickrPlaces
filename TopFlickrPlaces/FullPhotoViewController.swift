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
    @IBOutlet weak var myLabel: UILabel! // удалить lable в сторибоард и в коде
    @IBOutlet weak var photoURLLabel: UILabel! // ----//----//----
    
    
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
        //self.myLabel.text = textLabel                 //удалить
        //self.photoURLLabel.text = textLabelPhotoURL   //удалить
    }
}