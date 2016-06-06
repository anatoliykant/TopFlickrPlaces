//
//  RecentlyTableViewController.swift
//  TopFlickrPlaces
//
//  Created by anatoliy.kant on 16.04.16.
//  Copyright © 2016 anatoliy.kant. All rights reserved.
//

import UIKit

class RecentlyViewController: UIViewController {

    
    @IBOutlet weak var recentlyCollectionView: UICollectionView!
    
    private var apiClient = APIClient()
    private var recentClient = RecentPhotoArray()
    
    var selectPhoto3 = [Photo]()
    
    //let galleryVC = storyboard?.instantiateViewControllerWithIdentifier("GalleryVC") as! GalleryViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("1.recentlyVC.selectPhoto3 RecentlyVC: \(selectPhoto3)")
        recentlyCollectionView.dataSource = self
        recentlyCollectionView.delegate = self
        self.recentlyCollectionView.reloadData()
        print("2.recentlyVC.selectPhoto3 RecentlyVC: \(selectPhoto3)")
        //assert(topPlaceID.characters.count > 0)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
                //print("recentPhoto before: \(recentPhoto)")
                //print("selectPhoto1 recentlyVC: \(selectPhoto1)")
                //recentClient.recentPhoto.removeAll()
                //recentClient.recentPhoto.append()
                print("recentPhoto after: \(recentClient.recentPhoto)")
                print("3.recentlyVC.selectPhoto3 RecentlyVC: \(selectPhoto3)")
                self.recentlyCollectionView.reloadData()
    }
}

extension RecentlyViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("recentClient.recentPhoto.count: \(recentClient.recentPhoto.count)")
        return recentClient.recentPhoto.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let aPhoto = photoAt(indexPath)
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("RecentlyCell", forIndexPath: indexPath) as! RecentlyCollectionViewCell
        
        cell.recentlyImageView.updateImageWith(aPhoto)
        
        if aPhoto.name != "" {
            cell.recentlyLabel.text = aPhoto.name
        }
        else if aPhoto.photoDescription != "" {
            cell.recentlyLabel.text = aPhoto.photoDescription
        } else {
            cell.recentlyLabel.text = "Неизвестно"
        }
        return cell
    }
    
    private func photoAt(index:NSIndexPath) -> Photo {
        return recentClient.recentPhoto[index.row]
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        
        //let iconURLText = photoAt(indexPath).iconURL
        //let photoURLText = photoAt(indexPath).photoURL
        
        let vc = storyboard?.instantiateViewControllerWithIdentifier("FullRecentlyVC") as! FullRecentlyViewController
        //let galleryVC = storyboard?.instantiateViewControllerWithIdentifier("GalleryVC") as! GalleryViewController
        //vc.textLabel = iconURLText
        //vc.textLabelPhotoURL = photoURLText
        vc.selPhoto = photoAt(indexPath)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}