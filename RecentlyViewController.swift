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
    
    var recPhotos = [Photo]()
    var hud = Loader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //выводит сохраненные (ранее просмотренные) фото из NSUserDefault
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let savedPeople = defaults.objectForKey("recPhoto") as? NSData {
            recPhotos = NSKeyedUnarchiver.unarchiveObjectWithData(savedPeople) as! [Photo]
        }
        
        recentlyCollectionView.dataSource = self
        recentlyCollectionView.delegate = self
        self.recentlyCollectionView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        recPhotos.removeAll()
        
        //выводит сохраненные (ранее просмотренные) фото из NSUserDefault
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let savedPeople = defaults.objectForKey("recPhoto") as? NSData {
            recPhotos = NSKeyedUnarchiver.unarchiveObjectWithData(savedPeople) as! [Photo]
        }
        self.recentlyCollectionView.reloadData()
    }
}

extension RecentlyViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {        
        return recPhotos.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let aPhoto = photoAt(indexPath)
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("RecentlyCell", forIndexPath: indexPath) as! RecentlyCollectionViewCell
        
        self.hud.Show("Идет загрузка", delegate: self, time: 1)
        
        cell.recentlyImageView.updateImageWith(aPhoto)
        
        if aPhoto.name != "" {
            cell.recentlyLabel.text = aPhoto.name
        }
        else if aPhoto.photoDescription != "" {
            cell.recentlyLabel.text = aPhoto.photoDescription
        } else {
            cell.recentlyLabel.text = "Неизвестно"
        }
        self.hud.Hide(self)
        return cell
    }
    
    private func photoAt(index:NSIndexPath) -> Photo {
        return recPhotos[index.row]
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let vc = storyboard?.instantiateViewControllerWithIdentifier("FullRecentlyVC") as! FullRecentlyViewController
        
        vc.selPhoto = photoAt(indexPath)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}