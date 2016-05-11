//
//  FullPhotoViewController.swift
//  TopFlickrPlaces
//
//  Created by Pao Mac PC on 02.05.16.
//  Copyright © 2016 anatoliy.kant. All rights reserved.
//

import UIKit
import SDWebImage // а надо ли здесь ее использовать (посмотреть за загрузкой большой картинки)

class FullPhotoViewController: UIViewController {

    @IBOutlet weak var fullScrollView: UIScrollView!
    @IBOutlet weak var fullImageView: UIImageView!
    
    var imageFull2 = UIImageView()
    var image2 = UIImage?()
    
    var fullPhotoGood = Photo?()
    
    private var full1 = FullImageCollectionViewCell()
    private var photo1 = PhotoCollectionViewCell()
    
    
    //var cell3: FullImageCollectionViewCell?
    //var cell5: PhotoCollectionViewCell?
    
    //@IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //fullScrollView.delegate   = self
        //fullScrollView.dataSource = self
        
        //setupViews()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        setupImage()
        fullScrollView.reloadInputViews()
        //fullImageView.reloadInputViews()
        //setupViews()
        //self.fullImageView. reloadData()
        
//        self.photos.removeAll()
//        //разобраться, как можно очистить вью от фоток перед тем, как загружать новые!!!
//        self.photos.appendContentsOf(photosToShow)
//        self.collectionView.reloadData()
    }

    func setupViews(){
        
        self.fullImageView.image = imageFull2.image
        print("imageFull2Image: \(imageFull2.image)")
        print("imageFull2ImageView: \(imageFull2)")
        print("image2Image: \(image2)")
        
        //print("photoGood: \(full1.imageView!)")
        //FullImageCollectionViewCell.imageView =
        //collectionView.delegate   = self
        //collectionView.dataSource = self
//        let photoGood = photo
//        print("photoGood: \(photoGood)")
    }
    
    func setupImage() {
        self.fullImageView.updateImageWith(fullPhotoGood)
        print("fullPhotoGood.iconURL: \(fullPhotoGood?.iconURL)")
        print("fullPhotoGood.iconWidth: \(fullPhotoGood?.iconWidth)")
        print("fullPhotoGood.name: \(fullPhotoGood?.name)")
        print("fullPhotoGood.ownerID: \(fullPhotoGood?.ownerID)")
        print("fullPhotoGood.photoURL: \(fullPhotoGood?.photoURL)")
        print("fullPhotoGood.userID: \(fullPhotoGood?.userID)")
    }
}