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
    //var recentPhoto = [Photo]()
    
    var fullPhotos1 = UIImage?()//Удалить?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var apiClient = APIClient()
    private var recentClient = RecentPhotoArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        assert(topPlaceID.characters.count > 0)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
                
        apiClient.findAllPhotosOfTopPlace(topPlaceID) { (success:[Photo]?, failure) -> Void in
            if let photosToShow = success {
                self.photos.removeAll()
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
        let selectedPhoto = photoAt(indexPath)
        vc.selectPhoto = selectedPhoto
        
        recentClient.recentPhoto.append(selectedPhoto)
        
        
        
        
        let recentlyVC = storyboard?.instantiateViewControllerWithIdentifier("RecentlyVC") as! RecentlyViewController
        
        
        
        
        
        recentlyVC.selectPhoto3 = recentClient.recentPhoto
        
        //print("selectedPhoto: \(selectedPhoto)")
        print("recentPhoto: \(recentClient.recentPhoto)")
        print("recentlyVC.selectPhoto3 GalleryVC: \(recentlyVC.selectPhoto3)")
        
        //print("recentlyVC.selectPhoto1: \(recentlyVC.selectPhoto1)")
        
        //let number = 123
        
        NSUserDefaults.standardUserDefaults().setValue(recentClient.recentPhoto, forKey: "recSelectPhoto")
        
        
//        var recentPhotoTest = NSUserDefaults.standardUserDefaults().objectForKey("arrayPhoto") as? [Photo] ?? [Photo]()
//        recentPhotoTest.append(selectedPhoto)
//        
//        
//        NSUserDefaults.standardUserDefaults().setObject(recentPhotoTest, forKey: "arrayPhoto")
//        NSUserDefaults.standardUserDefaults().synchronize()
//        
//        let PhotoTest = NSUserDefaults.standardUserDefaults().valueForKey("recSelectPhoto") as! NSInteger
//        
//        print("PhotoTest: \(PhotoTest)")
//        
//        let PhotoTest2 = NSUserDefaults.standardUserDefaults().arrayForKey("arrayPhoto")
//        
//        print("PhotoTest2: \(PhotoTest2)")
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: -UIImageView Extension∫
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


