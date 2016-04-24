//
//  CatsViewController.swift
//  ShowKits
//
//  Created by Nikolay Shubenkov on 04/02/16.
//  Copyright © 2016 Nikolay Shubenkov. All rights reserved.
//

import UIKit
//import MapKit
//import SDWebImage ///??? загрузить pod

class CatsViewController: UIViewController {
    
    
    var apiClient = APIClient()
    var photosTop:[PhotoTopPlaces]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setup()
    }
    
//    func setup() {
//        mapView.delegate = self
//        
//        locationManager.delegate  = self
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.startUpdatingLocation()
//    }
    
    
//    @IBAction func showMeTheCats(sender: AnyObject) {
//        
//        let radius:Double = 5
//        apiClient.find("cat",
//                       longitude: mapView.centerCoordinate.longitude,
//                       latitude: mapView.centerCoordinate.latitude,
//                       radius: radius) { (success, failure) -> Void in
//                        
//                        self.photos = success
//                        self.updateMapView()
//                        
//        }
//    }
    
//    func updateMapView(){
//        
//        self.mapView.removeAnnotations(self.mapView.annotations)
//        
//        if self.photos != nil {
//            self.mapView.addAnnotations(self.photos!)
//        }
//        
//    }
//    
//    func updateMapViewTop(){
//        
//        self.mapView.removeAnnotations(self.mapView.annotations)
//        
//        if self.photosTop != nil {
//            self.mapView.addAnnotations(self.photosTop!)
//        }
//        
//    }
    
    
    @IBAction func showMeTop100Places() {
        
        //Список 100 лучших мест Flickr
        apiClient.findTopPlaces("22")  { (success, failure) -> Void in
            
            self.photosTop = success
            
        }
        
    }
}


















