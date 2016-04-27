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

    //var topTable = TopPlacesTableViewController()
    //var TableOne = [String]()
    //var apiClient = TopPlacesTableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //apiClient.findTopPlaces()
        //let returnTopPlaces = apiClient.findTopPlaces()
        //print("return Top Places: \(returnTopPlaces)")
        
        //TableOne = topTable.showMeTop100Places()
        //topTable.showMeTop100Places()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


//
//  APIClient.swift
//  ShowKits
//
//  Created by Nikolay Shubenkov on 04/02/16.
//  Copyright © 2016 Nikolay Shubenkov. All rights reserved.
//

//import UIKit
//import Alamofire // подключить Alamofire или SwiftyJSON
//import SwiftyJSON
//
//
//class APIClient: UITableViewController {
//    
//    static let apiURL = "https://api.flickr.com/services/rest/"
//    
//    var topTable = TopPlacesTableViewController()
//    
//    //typealias PhotosCompletion = (success:[Photo]?,failure:NSError?) -> Void
//    
//    typealias PhotosCompletionTopPlaces = (success:[PhotoTopPlaces]?,failure:NSError?) -> Void
//    
//    
//    func jsonFromSwiftyJSON (dataFromNetworking: NSData) {
//        
//        let json = JSON (data: dataFromNetworking)
//        //"https://api.flickr.com/services/rest/" as! NSData)
//        //let json = JSON(data: APIClient.apiURL as! NSData)
//        if let userName = json["places"]["place"][0]["woe_name"].string {
//            //Now you got your value
//            print("First user name: \(userName)")
//        }
//        
//    }
//    
//    
//    //func findTopPlaces(place_type_id:String, completion:PhotosCompletionTopPlaces) -> [String] {
//    func findTopPlaces() -> [String] {
//        var params = [String:AnyObject]()
//        
//        
//        //params["user_id"] = id
//        params["place_type_id"] = "22"
//        params["method"]  = "flickr.places.getTopPlacesList"
//        params = authorise(params)
//        
//        var topPlaces = [String]()
//        
//        
//        Alamofire.request(.GET,
//            APIClient.apiURL,
//            parameters: params,
//            encoding: .URL,
//            headers: nil)
//            .responseJSON { response -> Void in
//                
//                //                if response.result.error != nil {
//                //                    completion(success:nil,failure:response.result.error)
//                //
//                //                    return
//                //                }
//                
//                //let results = self.parsePhotosTopPlaces(response.result.value as! [String:AnyObject])
//                
//                if let tempValue = response.result.value
//                {
//                    let json = JSON(tempValue)
//                    
//                    
//                    let onePlaceID = json["places"]["place"][1]["woe_name"].string!
//                    print("JSON: \(onePlaceID)")
//                    
//                    if let topArray = json["places"]["place"].array {
//                        
//                        
//                        for placeDict in 0..<topArray.count {
//                            let topPlace: String! = json["places"]["place"][placeDict]["woe_name"].string!
//                            //print("Another topPlace: \(topPlace)")
//                            
//                            topPlaces.append(topPlace)
//                        }
//                        
//                        print("topPlaces: \(topPlaces)")
//                        //Занесение списка сайтов в массив TableArray и перезагрузка списка c топ 100 фото
//                                                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
//                        
//                                                    //print("jokesSiteName: \(jokesSiteName)")
//                                                    //self.topTable = topPlaces
//                                                    //self.topTable.reloadData()
//                                                })
//                    }
//                    
//                    
//                    //                    //var parsedPhotos = [PhotoTopPlaces]()
//                    //
//                    //                    //let json = JSON(data: jokesData)//заносим данные с сайта .../sources в константу json
//                    //
//                    //                    //1 присваиваем константе jokeArray массив данных с сайта .../sources
//                    //                    if let jokeArray = json[].array {
//                    //                        //2 создаем изменяемый массив для хранения объектов, которые будут созданы
//                    //                        //var jokes = [JokesModel]()
//                    //                        var jokesSiteName = [String]()
//                    //
//                    //                        //3 перебираем все элементы и создаем AppModel из данных JSON.
//                    //                        for appDict in jokeArray {
//                    //                            for jokeDict in 0..<appDict.count {
//                    //                                let jokeSiteName: String? = appDict[jokeDict]["name"].string
//                    //                                //let appURL: String? = appDict[jokeDict]["url"].string
//                    //
//                    //                                jokesSiteName.append(jokeSiteName!)
//                    //                                //let joke = JokesModel(name: appName, jokeURL: appURL)
//                    //                                //jokes.append(joke)
//                    //                            }
//                    //
//                    //                        }
//                    //
//                    //                        jokesSiteName.append("Random")//добавляем в название для сайта http://www.umori.li/api/random?num=10
//                    //
//                    //
//                    //                        //Занесение списка сайтов в массив TableArray и перезагрузка списка в левом меню
//                    //                        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
//                    //
//                    //                            //print("jokesSiteName: \(jokesSiteName)")
//                    //                            self.TableArray = jokesSiteName
//                    //                            self.tableViewLeft.reloadData()
//                    //                        })
//                    //                    }
//                    
//                    //for placeID
//                    
//                    
//                    //        let parsedPhotos =
//                    //let placeTop = place[].array
//                    
//                    //        var jokesTopPlacesID = [String]()
//                    //
//                    //        for topPlacesDict in place {
//                    //            for idDict in 0..<topPlacesDict.count {
//                    //                let jokesTopPlacesID: String? = topPlacesDict[idDict]["place_id"].string
//                    //            }
//                    //        }
//                    
//                }
//                
//                //let countPlaces = results!.count
//                //print("JSON top Places: \(results!)")
//                //print("JSON top Places count: \(countPlaces)")
//                //completion(success:results,failure:nil)
//                
//                //return topPlaces
//        }
//        print("topPlaces End: \(topPlaces)")
//        return topPlaces
//    }
//    
//    
//    
//    
//    //    func parsePhotosFrom(info:[String:AnyObject])->[Photo]? {
//    //
//    //        //photos
//    //        //photo
//    //        guard let photos = info  ["photos"] as? [String : AnyObject],
//    //            let photo = photos["photo"] as? [ [String : AnyObject] ]
//    //            else {
//    //                return [Photo]()
//    //        }
//    //
//    //        var parsedPhotos = [Photo]()
//    //
//    //        for info in photo {
//    //            parsedPhotos.append(Photo(info: info))
//    //        }
//    //
//    //        return parsedPhotos
//    //    }
//    
//    //распарсим фотки 100 лучших мест
//    func parsePhotosTopPlaces(info:[String:AnyObject])->[PhotoTopPlaces]? {
//        
//        //places
//        //place
//        guard let places = info["places"] as? [String : AnyObject],
//            let place = places["place"] as? [ [String : AnyObject] ]
//            //let woe_name = place[""] as? String
//            else {
//                return [PhotoTopPlaces]()
//        }
//        
//        var parsedPhotos = [PhotoTopPlaces]()
//        
//        
//        for info in place {
//            parsedPhotos.append(PhotoTopPlaces(info: info))
//        }
//        
//        return parsedPhotos
//    }
//    
//    private func authorise(parameters:[String:AnyObject])->[String:AnyObject] {
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
//}











