//
//  FullRecentlyViewController.swift
//  TopFlickrPlaces
//
//  Created by Goliaf on 06.06.16.
//  Copyright © 2016 anatoliy.kant. All rights reserved.
//

import UIKit

class FullRecentlyViewController: UIViewController {

    @IBOutlet weak var fullRecentlyImageView: UIImageView!
    @IBOutlet weak var textRecentlyLabel: UILabel!
    
    var selPhoto = Photo?()
    var hud = Loader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        //showIsBusy(true, animated: true)
        setupImage()
        fullRecentlyImageView.reloadInputViews()
        //showIsBusy(false, animated: true)
        
    }
    
    func setupImage() {
        self.hud.Show("Пожалуйста подождите", delegate: self, time: 1)
        self.fullRecentlyImageView.updateImageWith(selPhoto)
        
        guard let aPhoto = selPhoto else { return }
        //self.showIsBusy(true, animated: true)
        if aPhoto.name != "" {
            self.textRecentlyLabel.text = aPhoto.name
        }
        else if aPhoto.photoDescription != "" {
            self.textRecentlyLabel.text = aPhoto.photoDescription
        } else {
            self.textRecentlyLabel.text = "Неизвестно"
        }
        self.hud.Hide(self)
        //self.showIsBusy(false, animated: true)
    }    
}
