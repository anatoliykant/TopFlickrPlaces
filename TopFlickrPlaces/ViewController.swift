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

    var topTable = TopPlacesTableViewController()
    //var apiClient = APIClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topTable.showMeTop100Places()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
