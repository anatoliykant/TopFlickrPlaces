//
//  Photo.swift
//  ShowKits
//
//  Created by Nikolay Shubenkov on 04/02/16.
//  Copyright © 2016 Nikolay Shubenkov. All rights reserved.
//

import UIKit

class Photo: NSObject, NSCoding  {
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
        
//        if photoDescription.isEmpty {            
//        }
        
        if let iconWidthValue = info["width_s"] as? Int {
            iconWidth = iconWidthValue
        }
        
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("name") as? String
        photoURL = aDecoder.decodeObjectForKey("photoURL") as! String
        iconURL = aDecoder.decodeObjectForKey("iconURL") as! String
        iconWidth = aDecoder.decodeObjectForKey("iconWidth") as! Int
        photoDescription = aDecoder.decodeObjectForKey("photoDescription") as! String
        ownerID = aDecoder.decodeObjectForKey("ownerID") as! String
        userID = aDecoder.decodeObjectForKey("userID") as! String
        //title = aDecoder.decodeObjectForKey("title") as? String
        
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(photoURL, forKey: "photoURL")
        aCoder.encodeObject(iconURL, forKey: "iconURL")
        aCoder.encodeObject(iconWidth, forKey: "iconWidth")
        aCoder.encodeObject(photoDescription, forKey: "photoDescription")
        aCoder.encodeObject(ownerID, forKey: "ownerID")
        aCoder.encodeObject(userID, forKey: "userID")
        //aCoder.encodeObject(title, forKey: "title")
    }

}

//разобраться с этим классом, нужен ли он вообще?
class PhotoTopPlaces: NSObject  {
    
    var name:String?
    var photoURL:String = ""
    var placeID:String = ""
    var title: String? {
        return name
    }
    
    init(info:[String:AnyObject]){
        if let parsedName = info["woe_name"] as? String {
            name = parsedName
            print("name PhotoTopPlaces: \(name)")
        }
        
        if let url   = info["place_url"] as? String {
            photoURL = url
            print("photoURL PhotoTopPlaces: \(photoURL)")
        }
        
        if let id  = info["place_id"] as? String {
            placeID = id
            print("placeID PhotoTopPlaces: \(placeID)")
        }
        super.init()
    }
}