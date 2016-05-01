//
//  GalleryViewController.swift
//  TopFlickrPlaces
//
//  Created by Pao Mac PC on 02.05.16.
//  Copyright © 2016 anatoliy.kant. All rights reserved.
//

import UIKit
import SDWebImage

class GalleryViewController: UIViewController {

    var topPlaceID:String = ""
    
    var photos = [Photo]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var apiClient = APIClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        //assert(topPlaceID.characters.count > 0)    //разобраться с этим условием!!!
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        apiClient.findAllPhotosOfTopPlace(topPlaceID) { (success:[Photo]?, failure) -> Void in
            if let photosToShow = success {
                //print(photosToShow)
                self.photos.removeAll()
                self.photos.appendContentsOf(photosToShow)
                self.collectionView.reloadData()
            }
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension GalleryViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let aPhoto = photoAt(indexPath)
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PhotoCell", forIndexPath: indexPath) as! PhotoCollectionViewCell
        
        cell.imageView.updateImageWith(aPhoto)
        cell.textLabel.text = aPhoto.name
        
        return cell
    }
    
    private func photoAt(index:NSIndexPath) -> Photo {
        return photos[index.row]
    }
}


//MARK: -UIImageView Extention
extension UIImageView {
    private struct Constants {
        static let defaultIconWidth = 240
    }
    func updateImageWith(photo:Photo?) {
        guard let photoToApply = photo else {
            self.image = nil
            return
        }
        
        let width = photoToApply.iconWidth > 0 ? photoToApply.iconWidth : Constants.defaultIconWidth
        
        let url = CGFloat(width) > frame.size.width ? photoToApply.iconURL : photoToApply.photoURL
        
        sd_setImageWithURL(NSURL(string: url),
                           placeholderImage: nil,
                           options: [.ProgressiveDownload])
        
    }
}
