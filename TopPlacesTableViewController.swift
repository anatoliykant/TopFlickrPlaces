//
//  TopPlacesTableViewController.swift
//  TopFlickrPlaces
//
//  Created by anatoliy.kant on 16.04.16.
//  Copyright © 2016 anatoliy.kant. All rights reserved.
//

import UIKit
//import SwiftyJSON

class TopPlacesTableViewController: UITableViewController {
    
    @IBOutlet var tableViewListTopPlaces: UITableView!
    
    var TableArray = [String]()

    var apiClient = APIClient()
    var photosTop:[PhotoTopPlaces]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        // #warning Incomplete implementation, return the number of rows
        
        self.TableArray = apiClient.findTopPlaces("22") 
        print("TableArray.count = \(TableArray.count)")
        return TableArray.count
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */
    
    
    
//    @IBAction func showMeTop100Places() {
//        
//        //Список 100 лучших мест Flickr
//        self.TableArray = apiClient.findTopPlaces("22")  { (success, failure) -> Void in
//            
//            self.photosTop = success
//            
//            
//        }
//        print("TableArray.count = \(TableArray.count)")
//        
//    }
}
