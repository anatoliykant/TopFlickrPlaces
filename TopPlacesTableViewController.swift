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
import MBProgressHUD

class TopPlacesTableViewController: UITableViewController {
        
    @IBOutlet var tableViewListTopPlaces: UITableView!
    
    var TableArray = [String]()
    var TableArrayContent = [String]()
    var TableArrayTopID = [String]()
    var hud = Loader()
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
        
        params["place_type_id"] = "8"
        params["method"]  = "flickr.places.getTopPlacesList"
        params = authorise(params)
        
        self.hud.Show("Идет загрузка...", delegate: self, time: 5)
        Alamofire.request(.GET,
            self.apiURL,
            parameters: params,
            encoding: .URL,
            headers: nil)
            .responseJSON { response -> Void in
                
                self.hud.Hide(self)
                
                if let tempValue = response.result.value
                {
                    let json = JSON(tempValue)
                    
                    var topPlaces = [String]()
                    var topPlacesContent = [String]()
                    var topPlacesID = [String]()
                    
                    if let topArray = json["places"]["place"].array {
                        
                        for placeDict in 0..<topArray.count {
                            let topPlace: String! = json["places"]["place"][placeDict]["woe_name"].string!
                            let topPlaceContent: String! = json["places"]["place"][placeDict]["_content"].string!
                            let topPlaceID: String! = json["places"]["place"][placeDict]["place_id"].string!
                            
                            topPlaces.append(topPlace!)
                            topPlacesContent.append(topPlaceContent!)
                            topPlacesID.append(topPlaceID!)
                        }
                        
                        //Занесение списка сайтов в массив TableArray и перезагрузка списка c топ 100 фото
                        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                            
                            self.TableArray = topPlaces               //.sort()
                            self.TableArrayContent = topPlacesContent //.sort()
                            self.TableArrayTopID = topPlacesID
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let vc = storyboard?.instantiateViewControllerWithIdentifier("GalleryVC") as! GalleryViewController
        
        vc.topPlaceID = TableArrayTopID[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return nil
    }

}

//Расширение отображающее анимацию (лепестки) загрузки данных
extension UIViewController {
        
    func showIsBusy(busy:Bool, animated:Bool){
        if busy {
           let spiningActivity = MBProgressHUD.showHUDAddedTo(view, animated: animated)
            spiningActivity.activityIndicatorColor = UIColor.blueColor()
            spiningActivity.labelText = "Загрузка..."
            spiningActivity.minShowTime = 2
            //spiningActivity.mode = MBProgressHUDMode.DeterminateHorizontalBar
            //spiningActivity.showWhileExecuting(<#T##method: Selector##Selector#>, onTarget: <#T##AnyObject!#>, withObject: <#T##AnyObject!#>, animated: <#T##Bool#>)
            return
        }
        MBProgressHUD.hideHUDForView(view, animated: animated)
    }
}




