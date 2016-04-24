//
//  ViewController.swift
//  TopFlickrPlaces
//
//  Created by anatoliy.kant on 16.04.16.
//  Copyright © 2016 anatoliy.kant. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UITabBarController {

    var catsClient = CatsViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        catsClient.showMeTop100Places()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
//    static let apiURL = "https://api.flickr.com/services/rest/"
//    
//    //typealias PhotosCompletion = (success:[Photo]?,failure:NSError?) -> Void
//    
//    typealias PhotosCompletionTopPlaces = (success:[PhotoTopPlaces]?,failure:NSError?) -> Void
//    
//    func authorise(parameters:[String:AnyObject])->[String:AnyObject] {
//        
//        var authorisedParams = parameters
//        
//        authorisedParams["api_key"] = "2b2c9f8abc28afe8d7749aee246d951c"
//        
//        authorisedParams["format"]  = "json"
//        authorisedParams["content_type"]   = 1
//        authorisedParams["nojsoncallback"] = 1
//        
//        return authorisedParams
//    }
//    
//    func parsePhotosTopPlaces(info:[String:AnyObject])->[PhotoTopPlaces]? {
//        
//        //places
//        //place
//        guard let places = info["places"] as? [String : AnyObject],
//            let place = places["place"] as? [ [String : AnyObject] ]
//            else {
//                return [PhotoTopPlaces]()
//        }
//        
//        var parsedPhotos = [PhotoTopPlaces]()
//        
//        for info in place {
//            parsedPhotos.append(PhotoTopPlaces(info: info))
//        }
//        
//        return parsedPhotos
//    }
//
//    
//    func findTopPlaces(place_type_id:String, completion:PhotosCompletionTopPlaces){
//        var params = [String:AnyObject]()
//        
//        
//        //params["user_id"] = id
//        params["place_type_id"] = place_type_id
//        params["method"]  = "flickr.places.getTopPlacesList"
//        params = authorise(params)
//        
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
//                    
//                    return
//                }
//                
//                let results = self.parsePhotosTopPlaces(response.result.value as! [String:AnyObject])
//                print("JSON top Places: \(results)")
//                completion(success:results,failure:nil)
//        }
//
//        
//}
}
