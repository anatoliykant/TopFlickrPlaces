//
//  APIClient.swift
//  ShowKits
//
//  Created by Nikolay Shubenkov on 04/02/16.
//  Copyright © 2016 Nikolay Shubenkov. All rights reserved.
//

import UIKit
//import Alamofire // подключить Alamofire или SwiftyJSON

/*
 parameters[@"tags"] = @"cats";
 parameters[@"bbox"] = @"bbox";
 parameters[@"lat"]  = @(self.mapView.centerCoordinate.latitude);
 parameters[@"lon"]  = @(self.mapView.centerCoordinate.longitude);
 parameters[@"radius"] = @"5";
 parameters[@"extras"] = @"url_l,geo,date_taken,owner_name";
 parameters[@"format"] = @"json";
 
 
 parameters[@"content_type"] = @1;
 parameters[@"nojsoncallback"] = @1;
 
 parameters[@"method"] = @"flickr.photos.search";
 
 parameters[@"api_key"] = @"2b2c9f8abc28afe8d7749aee246d951c";
 */

class APIClient: NSObject {
    
    static let apiURL = "https://api.flickr.com/services/rest/"
    
    //typealias PhotosCompletion = (success:[Photo]?,failure:NSError?) -> Void
    
    typealias PhotosCompletionTopPlaces = (success:[PhotoTopPlaces]?,failure:NSError?) -> Void
    
//    func findAllPhotosOfUser(id:String, completion:PhotosCompletion){
//        var params = [String:AnyObject]()
//        
//        params["method"]  = "flickr.photos.search"
//        params["user_id"] = id
//        params = authorise(params)
//        params["extras"] = "url_l,geo,date_taken,owner_name,url_s,description"
//        
//        
//        Alamofire.request(.GET,
//            APIClient.apiURL,
//            parameters: params,
//            encoding: .URL,
//            headers: nil)
//            .responseJSON { response -> Void in
//                
//                if response.result.error != nil {
//                    completion(success:nil,failure:response.result.error)
//                    return
//                }
//                
//                let results = self.parsePhotosFrom(response.result.value as! [String:AnyObject])
//                completion(success:results,failure:nil)
//        }
//    }
    
//    func find(searchName:String,
//              longitude:Double,
//              latitude:Double,
//              radius:Double,
//              completion:PhotosCompletion
//        ){
//        var params = [String:AnyObject]()
//        
//        params["tags"] = searchName
//        params["bbox"] = "bbox"
//        params["lat"]  = latitude
//        params["lon"]  = longitude
//        params["radius"] = radius
//        params["extras"] = "url_l,geo,date_taken,owner_name,url_s,description"
//        
//        params["method"] = "flickr.photos.search"
//        params = authorise(params)
//        
//        Alamofire.request(.GET,
//            APIClient.apiURL,
//            parameters: params,
//            encoding: .URL,
//            headers: nil)
//            .responseJSON { response -> Void in
//                
//                if response.result.error != nil {
//                    completion(success: nil, failure: response.result.error)
//                    return
//                }
//                
//                
//                let results = self.parsePhotosFrom(response.result.value as! [String:AnyObject])
//                print("JSON find cats: \(results)")
//                completion(success: results, failure: nil)
//        }
//    }
//    
    
    
    func findTopPlaces(place_type_id:String, completion:PhotosCompletionTopPlaces){
        var params = [String:AnyObject]()
        
        
        //params["user_id"] = id
        params["place_type_id"] = place_type_id
        params["method"]  = "flickr.places.getTopPlacesList"
        params = authorise(params)
        
        
        
        Alamofire.request(.GET,
            APIClient.apiURL,
            parameters: params,
            encoding: .URL,
            headers: nil)
            .responseJSON { response -> Void in
                
                if response.result.error != nil {
                    completion(success:nil,failure:response.result.error)
                    
                    return
                }
                
                let results = self.parsePhotosTopPlaces(response.result.value as! [String:AnyObject])
                print("JSON top Places: \(results)")
                completion(success:results,failure:nil)
        }
    }
    
    
    
//    func parsePhotosFrom(info:[String:AnyObject])->[Photo]? {
//        
//        //photos
//        //photo
//        guard let photos = info  ["photos"] as? [String : AnyObject],
//            let photo = photos["photo"] as? [ [String : AnyObject] ]
//            else {
//                return [Photo]()
//        }
//        
//        var parsedPhotos = [Photo]()
//        
//        for info in photo {
//            parsedPhotos.append(Photo(info: info))
//        }
//        
//        return parsedPhotos
//    }
    
    //распарсим фотки 100 лучших мест
    func parsePhotosTopPlaces(info:[String:AnyObject])->[PhotoTopPlaces]? {
        
        //places
        //place
        guard let places = info["places"] as? [String : AnyObject],
            let place = places["place"] as? [ [String : AnyObject] ]
            else {
                return [PhotoTopPlaces]()
        }
        
        var parsedPhotos = [PhotoTopPlaces]()
        
        for info in place {
            parsedPhotos.append(PhotoTopPlaces(info: info))
        }
        
        return parsedPhotos
    }
    
    private func authorise(parameters:[String:AnyObject])->[String:AnyObject] {
        
        var authorisedParams = parameters
        
        authorisedParams["api_key"] = "2b2c9f8abc28afe8d7749aee246d951c"
        
        authorisedParams["format"]  = "json"
        authorisedParams["content_type"]   = 1
        authorisedParams["nojsoncallback"] = 1
        
        return authorisedParams
    }
}










