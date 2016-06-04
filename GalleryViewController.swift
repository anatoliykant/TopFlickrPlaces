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
        
    var topPlaceID:String = "Empty"
    
    var photos = [Photo]()
    
    var fullPhotos1 = UIImage?()
    
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
        
        let top = topPlaceID
        print(top)
        
        apiClient.findAllPhotosOfTopPlace(topPlaceID) { (success:[Photo]?, failure) -> Void in
            if let photosToShow = success {
                self.photos.removeAll()
                //разобраться, как можно очистить вью от фоток перед тем, как загружать новые!!!
                self.photos.appendContentsOf(photosToShow)
                self.collectionView.reloadData()
            }
        }
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
        
        
        //let iconURLText = photoAt(indexPath).iconURL
        //let photoURLText = photoAt(indexPath).photoURL
        
        let vc = storyboard?.instantiateViewControllerWithIdentifier("FullStoryVC") as! FullPhotoViewController
        //vc.textLabel = iconURLText
        //vc.textLabelPhotoURL = photoURLText
        vc.selectPhoto = photoAt(indexPath)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: -UIImageView Extension
extension UIImageView {
    private struct Constants {
        static let defaultIconWidth = 240
    }
    
    //функция плавной подгрузки фото в imageView по известному iconURL
    func updateImageWith(photo:Photo?) {
        guard let photoToApply = photo else {
            self.image = nil
            return
        }
        
        let width = photoToApply.iconWidth > 0 ? photoToApply.iconWidth : Constants.defaultIconWidth
        
        var url = ""
        
        if photoToApply.photoURL != "" {//если photoURL не существует, то присвоим переменной url = iconURL
            url = CGFloat(width) > frame.size.width ? photoToApply.iconURL : photoToApply.photoURL
        }
        else {
            url = photoToApply.iconURL
        }
        
        sd_setImageWithURL(NSURL(string: url),
                           placeholderImage: nil,
                           options: [.ProgressiveDownload])
    }
}


