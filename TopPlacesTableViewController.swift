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
//import MapKit

//protocol SecondViewControllerDelegate {
//    func fillTheLabelWith(info: String)
//}

class TopPlacesTableViewController: UITableViewController {
        
    @IBOutlet var tableViewListTopPlaces: UITableView!
    
    var TableArray = [String]()
    var TableArrayContent = [String]()

    var photosTop:[PhotoTopPlaces]?
    
    static let apiURL = "https://api.flickr.com/services/rest/"
    
    //var topTable = TopPlacesTableViewController()
    
    //typealias PhotosCompletion = (success:[Photo]?,failure:NSError?) -> Void
    
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    //функция распарсивания 100 лучших мест с помощью SwiftyJSON (может дописать вместо Alamofire?)
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
    
    //распарсим списко 100 лучших мест Flickr
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
        params["place_type_id"] = "22"
        params["method"]  = "flickr.places.getTopPlacesList"
        params = authorise(params)
        
        Alamofire.request(.GET,
            TopPlacesTableViewController.apiURL,
            parameters: params,
            encoding: .URL,
            headers: nil)
            .responseJSON { response -> Void in
                
                
                if let tempValue = response.result.value
                {
                    let json = JSON(tempValue)
                    
                    var topPlaces = [String]()
                    var topPlacesContent = [String]()
                    //let onePlaceContent = json["places"]["place"][1]["_content"].string!
                    //print("JSON: \(onePlaceContent)")
                    
                    if let topArray = json["places"]["place"].array {
                        
                        
                        for placeDict in 0..<topArray.count {
                            let topPlace: String! = json["places"]["place"][placeDict]["woe_name"].string!
                            let topPlaceContent: String! = json["places"]["place"][placeDict]["_content"].string!
                            print("Another topPlace: \(topPlace)")
                            
                            topPlaces.append(topPlace!)
                            topPlacesContent.append(topPlaceContent!)
                        }
                        
                        //print("topPlaces: \(topPlaces)")
                        //Занесение списка сайтов в массив TableArray и перезагрузка списка c топ 100 фото
                        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                            
                            //print("jokesSiteName: \(jokesSiteName)")
                            self.TableArray = topPlaces
                            self.TableArrayContent = topPlacesContent
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
        let cell1 = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        cell1.textLabel?.text = TableArray[indexPath.row]
        //var detailLabel = "\(TableArray[indexPath.row]) \(indexPath.row)"
        cell1.detailTextLabel?.text = TableArrayContent[indexPath.row]
        return cell1
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //взять ячейку с нажатым индексом
        //let selectedCell = tableView.cellForRowAtIndexPath(indexPath)
        
        //вычленим у нее текст
        //let objectToSend = selectedCell!.textLabel!.text!
        
        //Всплывающее уведомление выбора места - временный момент (проверка)
        //let alert = UIAlertController(title: "Your choise", message: "Place: \(objectToSend)", preferredStyle: .Alert)
        //let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        
            //alert.addAction(action)
            //self.presentViewController(alert, animated: true, completion: nil)
        
        
        
//        func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//            performSegueWithIdentifier("Show Place Detail", sender: view.annotation)
//        }
        
        //пошлем уведомление с названием и текстом
        //NSNotificationCenter.defaultCenter().postNotificationName("LeftMenuPressed", object: objectToSend)
    }

    
    
    }




