//
//  TopPlaces.swift
//  TopFlickrPlaces
//
//  Created by anatoliy.kant on 04.06.16.
//  Copyright © 2016 anatoliy.kant. All rights reserved.
//

import UIKit

class TopPlaces: NSObject {

     //date (Optional)
    //A valid date in YYYY-MM-DD format. The default is yesterday.
    //woe_id (Optional)
    //Limit your query to only those top places belonging to a specific Where on Earth (WOE) identifier.
    
        //var name:String?
    
        var placeID = ""
        var placeTypeID = ""
    
    
//        var title: String? {
//            return name
//        }
    
        
        init(info:[String:AnyObject]) {
//            if let parsedName = info["title"] as? String {
//                name = parsedName
//            }
            
            if let ownerIDType = info["place_type_id"] as? String {
                placeTypeID = ownerIDType
//                22: neighbourhood
//                7: locality
//                8: region
//                12: country
//                29: continent
            }
            
            if let id = info["place_id"] as? String {
                placeID = id
            }
            
            super.init()
        }
    

}
