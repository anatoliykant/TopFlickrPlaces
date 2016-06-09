//
//  GalleryViewController.swift
//  TopFlickrPlaces
//
//  Created by Pao Mac PC on 02.05.16.
//  Copyright © 2016 anatoliy.kant. All rights reserved.
//

import UIKit
import SDWebImage
import MBProgressHUD

class GalleryViewController: UIViewController {
        
    var topPlaceID:String = "Empty"
    
    var photos = [Photo]()
    var recentPhotos = [Photo]()
    var hud = Loader()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var apiClient = APIClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        assert(topPlaceID.characters.count > 0)
        
        //выводит сохраненные (ранее просмотренные) фото из NSUserDefault
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let savedPeople = defaults.objectForKey("recPhoto") as? NSData {
            recentPhotos = NSKeyedUnarchiver.unarchiveObjectWithData(savedPeople) as! [Photo]
        }
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
        
        self.hud.Show("Подгружаются фотографии...", delegate: self, time: 1)
        
        cell.imageView.updateImageWith(aPhoto)
        
        if aPhoto.name != "" {
            cell.textLabel.text = aPhoto.name            
        }
        else if aPhoto.photoDescription != "" {
            cell.textLabel.text = aPhoto.photoDescription
        } else {
            cell.textLabel.text = "Неизвестно"
        }
        
        self.hud.Hide(self)
        return cell
    }
        
    private func photoAt(index:NSIndexPath) -> Photo {
        return photos[index.row]
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let selectedPhoto = photoAt(indexPath)
        
        let vc = storyboard?.instantiateViewControllerWithIdentifier("FullStoryVC") as! FullPhotoViewController
        vc.selectPhoto = selectedPhoto
        
        addRecPhoto(100, addElement: selectedPhoto)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }    
    
    //функция записи просмотренных данных в NSUserDefault
    func save() {
        let savedData = NSKeyedArchiver.archivedDataWithRootObject(recentPhotos)
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(savedData, forKey: "recPhoto")
        //defaults.removeObjectForKey("recPhoto")//обнуление данных по ключу
    }
    
    //функцию для ограничения размера массива до заданного количества count элементов (просмотренных фотографий) -  в результате ее работы самый старый элемент массива (фото) удаляется,
    //а также для проверки массива на дубликаты фотографий
    func addRecPhoto(count: Int, addElement: Photo) {
        
        var repeate = false
        
        if recentPhotos.count == count {
            recentPhotos.removeLast()
        }
        
        for ind in recentPhotos {
            if ind.iconURL == addElement.iconURL
            {
                repeate = true
            }
        }
        
        if repeate == false {
            recentPhotos.insert(addElement, atIndex: 0)
            save()
        }
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


