////
////  APIClient.swift
////  ShowKits
////
////  Created by Nikolay Shubenkov on 04/02/16.
////  Copyright © 2016 Nikolay Shubenkov. All rights reserved.
////

import UIKit
import Alamofire

class APIClient: NSObject {
    
    static let apiURL = "https://api.flickr.com/services/rest/"
    
    private var topPlaces = TopPlacesTableViewController()
    
    typealias PhotosCompletion = (success:[Photo]?, failure:NSError?) -> Void
    
    func findAllPhotosOfTopPlace(id:String, completion: PhotosCompletion) {
        var params = [String:AnyObject]()
        
        params["method"] = "flickr.photos.search"
        params["place_id"] = id
        params = topPlaces.authorise(params)
        params["extras"] = "url_l, url_s, geo, date_taken, owner_name, description"
        
        Alamofire.request(.GET,
            APIClient.apiURL,
            parameters: params,
            encoding: .URL,
            headers: nil)
            .responseJSON { response -> Void in
                
                if response.result.error != nil {
                    completion(success: nil, failure: response.result.error)
                    return
                }
                
                let results = self.parsePhotosFrom(response.result.value as! [String:AnyObject])
                completion(success: results, failure: nil)
        }
}
    
    func parsePhotosFrom(info:[String:AnyObject])->[Photo]? {
        
        guard let photos = info  ["photos"] as? [String : AnyObject],
            let photo = photos["photo"] as? [ [String : AnyObject] ]
            else {
                return [Photo]()
        }
        
        var parsedPhotos = [Photo]()
        
        for info in photo {
            parsedPhotos.append(Photo(info: info))
        }
        
        return parsedPhotos
    }
}