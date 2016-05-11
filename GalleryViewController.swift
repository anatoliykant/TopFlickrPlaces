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
    
    var fullPhotos1 = UIImageView()
    
    //var indexPath1 = NSIndexPath()
    
    var aPhoto2 = Photo?()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var apiClient = APIClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        //assert(topPlaceID.characters.count > 0)    //разобраться с этим условием!!!
        
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        apiClient.findAllPhotosOfTopPlace(topPlaceID) { (success:[Photo]?, failure) -> Void in
            if let photosToShow = success {
                self.photos.removeAll()
                //разобраться, как можно очистить вью от фоток перед тем, как загружать новые!!!
                self.photos.appendContentsOf(photosToShow)
                self.collectionView.reloadData()
            }
        }
    }

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension GalleryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let aPhoto = photoAt(indexPath)
        print("indexPath: \(indexPath)")
        print("indexPath: \(indexPath.row)")
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PhotoCell", forIndexPath: indexPath) as! PhotoCollectionViewCell
        
        cell.imageView.updateImageWith(aPhoto)
        
      
        if aPhoto.name != "" {
            cell.textLabel.text = aPhoto.name
        }
        else if aPhoto.photoDescription != "" {
            cell.textLabel.text = aPhoto.photoDescription
        } else {
            cell.textLabel.text = "Неизвестно"
        }
        
        return cell
    }
        
    private func photoAt(index:NSIndexPath) -> Photo {
        return photos[index.row]
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    
        //let aPhoto = photoAt(indexPath)
        let index = indexPath
        let indexRow = indexPath.row
        
        print("index: \(index)")
        print("indexRow: \(indexRow)")
        
        aPhoto2 = photoAt(indexPath)
        print(" aPhoto2: \(aPhoto2!)")
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PhotoCell", forIndexPath: indexPath) as! PhotoCollectionViewCell
        
        fullPhotos1 = cell.imageView
        
        
        
    }
    
    override  func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let FullPhotoVC: FullPhotoViewController = segue.destinationViewController as! FullPhotoViewController
        let imageViewTemp = self.fullPhotos1
        FullPhotoVC.imageFull2 = imageViewTemp
        let imageTemp = self.fullPhotos1.image
        FullPhotoVC.image2 = imageTemp
        
        print("aPhoto2.iconURL: \(aPhoto2?.iconURL)")
        print("aPhoto2.iconWidth: \(aPhoto2?.iconWidth)")
        print("aPhoto2.name: \(aPhoto2?.name)")
        print("aPhoto2.ownerID: \(aPhoto2?.ownerID)")
        print("aPhoto2.photoURL: \(aPhoto2?.photoURL)")
        print("aPhoto2.userID: \(aPhoto2?.userID)")
        
        
        FullPhotoVC.fullPhotoGood = aPhoto2
        //FullPhotoVC.fullImageView.image = imageTemp
        
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


