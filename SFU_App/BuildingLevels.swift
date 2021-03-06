//
//  BuildingLevels.swift
//  SFU_App
//
//  Created by Daniel Russell on 2015-04-12.
//  Copyright (c) 2015 Hugo Cheng. All rights reserved.
//

import Foundation
import UIKit

// Array of floors with index corresponding to buildings index
var buildingsLevels: [String] = ["AQ-2000 AQ-3000 AQ-4000 AQ-5000 AQ-6000", "", "ASB-8000 ASB-9000 ASB-10000", "BH-9000 BH-10000A BH-10000B BH-11000A BH-11000B", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""]

// set up global variables to pass through to next VC
var building = ""
var level = ""
var floorIndex = 0

class buildingLevelsList: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var temp = buildingsLevels[arrIndex]
        var temparr = split(temp) {$0 == " "}
        
        // don't have floor plan records tell user
        if (temparr.count == 0) {
            let alertController = UIAlertController(title: "Error", message: "Floors not yet available", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
      
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
        
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // make array to set up display 
        var temp = buildingsLevels[arrIndex]
        var temparr = split(temp) {$0 == " "}
        
        return temparr.count
        
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var  cell = tableView.dequeueReusableCellWithIdentifier("Cell",forIndexPath: indexPath) as UITableViewCell
        
        var temp = buildingsLevels[arrIndex]
        var temparr = split(temp) {$0 == " "}
        
        
        cell.textLabel!.text = temparr[indexPath.row]
        
        return cell
        
    }
    
    //segue for floor plans associated with cell in search
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        let indexPath = tableView.indexPathForSelectedRow();
        
        let currentCell = tableView.cellForRowAtIndexPath(indexPath!) as UITableViewCell!
        
        var temp = buildingsLevels[arrIndex]
        var temparr = split(temp) {$0 == " "}
        
        floorIndex = indexPath!.row
        
        var temparr2 = split(temparr[floorIndex]) {$0 == "-"}
        
        building = temparr2[0]
        println(building)
        level = temparr2[1]
        println(level)
        
    }
    
}