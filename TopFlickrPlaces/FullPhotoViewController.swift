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
        
    var selectPhoto = Photo?()
    var hud = Loader()
    
    override func viewDidLoad() {
        //showIsBusy(true, animated: true)
        super.viewDidLoad()
        //showIsBusy(false, animated: true)
    }
    
    override func viewDidAppear(animated: Bool) {
        //showIsBusy(true, animated: true)
        setupImage()
        fullImageView.reloadInputViews()
        //showIsBusy(false, animated: true)
    }
    
    func setupImage() {
        //showIsBusy(true, animated: true)
        self.hud.Show("Загрузка...", delegate: self, time: 1.5)
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
        self.hud.Hide(self)
        //showIsBusy(false, animated: true)
    }
}