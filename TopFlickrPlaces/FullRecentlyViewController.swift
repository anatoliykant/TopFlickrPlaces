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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        setupImage()
        fullRecentlyImageView.reloadInputViews()
    }
    
    func setupImage() {
        self.fullRecentlyImageView.updateImageWith(selPhoto)
        
        guard let aPhoto = selPhoto else { return }
        
        if aPhoto.name != "" {
            self.textRecentlyLabel.text = aPhoto.name
        }
        else if aPhoto.photoDescription != "" {
            self.textRecentlyLabel.text = aPhoto.photoDescription
        } else {
            self.textRecentlyLabel.text = "Неизвестно"
        }
        
    }    
}
