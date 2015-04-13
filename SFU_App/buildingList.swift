//
//  buildingList.swift
//  SFU_App
//
//  Created by Daniel Russell on 2015-04-12.
//  Copyright (c) 2015 Hugo Cheng. All rights reserved.
//

import Foundation
import UIKit

var buildings: [String] = ["Academic Quadrangle", "Alcan Aquatic Research Centre", "Applied Sciences Building",  "Blusson Hall", "Bee Research Building", "Childcare Centre", "Diamond Alumni Centre", "Dining Hall", "Discovery 1", "Discovery 2", "Education Building", "Facilities Services", "Greenhouses", "Halpern Centre", "Lorne Davies Complex", "Maggie Benston Centre", "Robert C. Brown Hall", "Saywell Hall", "Shrum Science Centre Biology", "Shrum Science Centre Chemisty", "Shrum Science Centre Kinesiology", "Shrum Science Building Physics", "South East Classroom Block", "South Sciences Building", "Science Research Annex", "Strand Hall", "Strand Hall Annex", "T3 - Achiology Trailer", "Technology & Science Complex 1", "Technology & Science Complex 2", "Transportation Centre", "University Theatre", "W.A.C. Bennett Library", "West Mall Centre", "Water Tower Building"]

var arrIndex = 0

class buildingList: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
 
        
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        //println(buildings.count)
        return buildings.count
        
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var  cell = tableView.dequeueReusableCellWithIdentifier("Cell",forIndexPath: indexPath) as UITableViewCell
        
        
        cell.textLabel!.text = buildings[indexPath.row]
        return cell
        
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        let indexPath = tableView.indexPathForSelectedRow();
        
        let currentCell = tableView.cellForRowAtIndexPath(indexPath!) as UITableViewCell!
        
        println(indexPath!.row)
        arrIndex = indexPath!.row
    }
    
}