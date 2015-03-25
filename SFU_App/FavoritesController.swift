//
//  FavoritesController.swift
//  SFU_App
//
//  Created by Daniel Russell on 2015-03-22.
//  Copyright (c) 2015 Hugo Cheng. All rights reserved.
//

import Foundation
import UIKit



class FavoritesController: UITableViewController {
    
    //go back when cancel pushed
    @IBAction func cancelToFavoritesController(segue:UIStoryboardSegue) {
        
    }
    //save user input
    @IBAction func saveBusStopDetail(segue:UIStoryboardSegue) {
        let BusDetailsViewController = segue.sourceViewController as BusStopDetail
        
        //add the new bus to the players array
        players.append(player)
        
        //update the tableView
        let indexPath = NSIndexPath(forRow: players.count-1, inSection: 0)
        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        
        //hide the detail view controller
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //println(temparr)
        var cellCount = players.count
        //println(cellCount)
        
        return cellCount
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        //display bus stop name input by user
        let player = players[indexPath.row] as Player
        cell.textLabel?.text = player.name
        return cell
    }
    //segue bus number assiciated with cell in search
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
        passNo = indexPath.row
        search = players[passNo].number
        
    }
    
}