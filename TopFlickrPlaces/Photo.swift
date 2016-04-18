//
//  Photo.swift
//  ShowKits
//
//  Created by Nikolay Shubenkov on 04/02/16.
//  Copyright © 2016 Nikolay Shubenkov. All rights reserved.
//

import UIKit
//import MapKit

//class Photo: NSObject, MKAnnotation  {
//    var name:String?
//    var coordinate:CLLocationCoordinate2D
//    var photoURL:String = ""
//    var userID:String = ""
//    var title: String? {
//        return name
//    }
//    
//    init(info:[String:AnyObject]){
//        if let parsedName = info["title"] as? String {
//            name = parsedName
//        }
//        
//        guard let long = info["longitude"] as? String,
//            let lat  = info["latitude"] as? String else {
//                coordinate = CLLocationCoordinate2D(latitude: -500, longitude: -500)
//                super.init()
//                return
//        }
//        
//        coordinate = CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(long)!)
//        
//        if let url   = info["url_l"] as? String {
//            photoURL = url
//        }
//        
//        if let id  = info["owner"] as? String {
//            userID = id
//        }
//        super.init()
//    }
//}

class PhotoTopPlaces: NSObject, MKAnnotation  {
    var name:String?
    var coordinate:CLLocationCoordinate2D
    var photoURL:String = ""
    var userID:String = ""
    var title: String? {
        return name
    }
    
    init(info:[String:AnyObject]){
        if let parsedName = info["woe_name"] as? String {
            name = parsedName
        }
        
        guard let long = info["longitude"] as? String,
            let lat  = info["latitude"] as? String else {
                coordinate = CLLocationCoordinate2D(latitude: -500, longitude: -500)
                super.init()
                return
        }
        
        coordinate = CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(long)!)
        
        if let url   = info["place_url"] as? String {
            photoURL = url
        }
        
        if let id  = info["owner"] as? String {
            userID = id
        }
        super.init()
    }
}
