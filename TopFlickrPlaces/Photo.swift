//
//  Photo.swift
//  ShowKits
//
//  Created by Nikolay Shubenkov on 04/02/16.
//  Copyright © 2016 Nikolay Shubenkov. All rights reserved.
//

import UIKit

class PhotoTopPlaces: NSObject  {
    var name:String?
    //var coordinate:CLLocationCoordinate2D
    var photoURL:String = ""
    var placeID:String = ""
    var title: String? {
        return name
    }
    
    init(info:[String:AnyObject]){
        if let parsedName = info["woe_name"] as? String {
            name = parsedName
        }
        
//        guard let long = info["longitude"] as? String,
//            let lat  = info["latitude"] as? String else {
//                coordinate = CLLocationCoordinate2D(latitude: -500, longitude: -500)
//                super.init()
//                return
//        }
        
        //coordinate = CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(long)!)
        
        if let url   = info["place_url"] as? String {
            photoURL = url
        }
        
        if let id  = info["place_id"] as? String {
            placeID = id
        }
        super.init()
    }
}

class Photo: NSObject {
    var name:String?
    
    var photoURL = ""
    var iconURL = ""
    var iconWidth = 0
    var photoDescription = ""
    var ownerID = ""
    var userID = ""
    var title: String? {
        return name
    }
    
    
    init(info:[String:AnyObject]) {
        if let parsedName = info["title"] as? String {
            name = parsedName
        }
        
        if let ownerIDValue = info["owner"] as? String {
            ownerID = ownerIDValue
        }
               
        
        
        if let url = info["url_l"] as? String {
            photoURL = url
        }
        
        if let id = info ["owner"] as? String {
            userID = id
        }
        
        if let iconURLValue = info["url_s"] as? String {
            iconURL = iconURLValue
        }
        
        if let description = info["description"] as? [String:String],
            let descriptionContent = description["_content"] {
            photoDescription = descriptionContent
        }
        if photoDescription.isEmpty {
            print("not found description")
        }
        
        if let iconWidthValue = info["width_s"] as? Int {
            iconWidth = iconWidthValue
        }
        
        super.init()
    }
}