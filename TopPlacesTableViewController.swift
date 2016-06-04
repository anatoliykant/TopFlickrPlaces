//
//  TopPlacesTableViewController.swift
//  TopFlickrPlaces
//
//  Created by anatoliy.kant on 16.04.16.
//  Copyright © 2016 anatoliy.kant. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TopPlacesTableViewController: UITableViewController {
        
    @IBOutlet var tableViewListTopPlaces: UITableView!
    
    var TableArray = [String]()
    var TableArrayContent = [String]()
    var TableArrayTopID = [String]()

    var photosTop:[PhotoTopPlaces]?
    
    var topIDs = [TopPlaces]()
    
    let apiURL = "https://api.flickr.com/services/rest/"
    
    typealias PhotosCompletionTopPlaces = (success:[PhotoTopPlaces]?,failure:NSError?) -> Void
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        findTopPlaces()
        
    }

    func setupTableView() {
        tableViewListTopPlaces.delegate   = self
        tableViewListTopPlaces.dataSource = self
    }

    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    //распарсим список 100 лучших мест Flickr
    func parsePhotosTopPlaces(info:[String:AnyObject])->[PhotoTopPlaces]? {
        
        guard let places = info["places"] as? [String : AnyObject],
            let place = places["place"] as? [ [String : AnyObject] ]
            //let woe_name = place[""] as? String
            else {
                return [PhotoTopPlaces]()
        }
        
        var parsedPhotos = [PhotoTopPlaces]()
        
        for info in place {
            parsedPhotos.append(PhotoTopPlaces(info: info))
        }        
        return parsedPhotos
    }
    
    //прохождение авторизации
    func authorise(parameters:[String:AnyObject])->[String:AnyObject] {
        
        var authorisedParams = parameters
        
        authorisedParams["api_key"] = "2b2c9f8abc28afe8d7749aee246d951c"
        authorisedParams["format"]  = "json"
        authorisedParams["content_type"]   = 1
        authorisedParams["nojsoncallback"] = 1
        
        return authorisedParams
    }
    
    
    func findTopPlaces() {
        
        var params = [String:AnyObject]()
        
        
        //params["user_id"] = id
        params["place_type_id"] = "8"
        params["method"]  = "flickr.places.getTopPlacesList"
        params = authorise(params)
        
        Alamofire.request(.GET,
            self.apiURL,
            parameters: params,
            encoding: .URL,
            headers: nil)
            .responseJSON { response -> Void in
                
                if let tempValue = response.result.value
                {
                    let json = JSON(tempValue)
                    
                    var topPlaces = [String]()
                    var topPlacesContent = [String]()
                    var topPlacesID = [String]()
                    //let onePlaceContent = json["places"]["place"][1]["_content"].string!
                    //print("JSON: \(onePlaceContent)")
                    
                    if let topArray = json["places"]["place"].array {
                        
                        for placeDict in 0..<topArray.count {
                            let topPlace: String! = json["places"]["place"][placeDict]["woe_name"].string!
                            let topPlaceContent: String! = json["places"]["place"][placeDict]["_content"].string!
                            let topPlaceID: String! = json["places"]["place"][placeDict]["place_id"].string!
//                            print("topPlace: \(topPlace)")
//                            print("topPlaceContent: \(topPlaceContent)")
//                            print("ID topPlace: \(topPlaceID)")
                            
                            topPlaces.append(topPlace!)
                            topPlacesContent.append(topPlaceContent!)
                            topPlacesID.append(topPlaceID!)
                        }
                        
                        //print("topPlaces: \(topPlaces)")
                        //Занесение списка сайтов в массив TableArray и перезагрузка списка c топ 100 фото
                        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                            
                            //print("jokesSit eName: \(jokesSiteName)")
                            self.TableArray = topPlaces               //.sort()
                            self.TableArrayContent = topPlacesContent //.sort()
                            self.TableArrayTopID = topPlacesID
                            //print(self.TableArrayContent.count)
                            //print(self.TableArrayContent)
                            self.tableViewListTopPlaces.reloadData()
                        })
                    }
                }
        }
    }
    
    // вовзвращает кол-во строк в TableView = кол-во элементов массива TableArray
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return TableArray.count
    }
    
    // заполняет ячейки элементами из массива TableArray
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        Cell.textLabel?.text = TableArray[indexPath.row]
        Cell.detailTextLabel?.text = TableArrayContent[indexPath.row]
        return Cell
    }
    
    
//    private func topID(index:NSIndexPath) -> TopPlaces {
//        return topIDs[index.row]
//    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = storyboard?.instantiateViewControllerWithIdentifier("GalleryVC") as! GalleryViewController
        vc.topPlaceID = TableArrayTopID[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}




