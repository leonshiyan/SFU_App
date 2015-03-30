//
//  FavoritesController.swift
//  SFU_App
//
//  Created by Daniel Russell on 2015-03-22.
//  Copyright (c) 2015 Hugo Cheng. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class FavoritesController: UITableViewController,ENSideMenuDelegate ,NSFetchedResultsControllerDelegate {
    
    
    // Core data variables//
   
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    
    var fetchedResultController : NSFetchedResultsController = NSFetchedResultsController()

    
    func getFetchedResultsController() -> NSFetchedResultsController{
        
        var fetchedResultsController  = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        
        return fetchedResultsController
    }
    
    func taskFetchRequest() -> NSFetchRequest {
        
        let fetchRequest = NSFetchRequest(entityName: "FavBus")
        let sortDescriptor = NSSortDescriptor(key: "tag", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
    }
    
    

    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 50 ;
        fetchedResultController = getFetchedResultsController()
        fetchedResultController.delegate = self
        
        fetchedResultController.performFetch(nil)
        
        
        //Set slide menu control to this controller
        self.sideMenuController()?.sideMenu?.delegate = self;
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return fetchedResultController.sections!.count
        
        
        
        
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //println(temparr)
        var cellCount = players.count
        //println(cellCount)
        println (fetchedResultController.sections![section].numberOfObjects)
        if(fetchedResultController.sections![section].numberOfObjects <= 0 ) {
            println("list is empty")
            return 0 ;
        }
        return fetchedResultController.sections![section].numberOfObjects
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        /*let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        //display bus stop name input by user
        let player = players[indexPath.row] as Player
        cell.textLabel?.text = player.name
        return cell*/
       
            var  cell = tableView.dequeueReusableCellWithIdentifier("Cell",forIndexPath: indexPath) as UITableViewCell
        
     
        
 
        
            let task = fetchedResultController .objectAtIndexPath(indexPath) as FavBus
        
     
            cell.textLabel?.text = task.tag
            return cell
        
        
        
        
        
        
        
    }
    //segue bus number assiciated with cell in search
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
     
        
        let indexPath = tableView.indexPathForSelectedRow();
        
        let currentCell = tableView.cellForRowAtIndexPath(indexPath!) as UITableViewCell!
        
        println(currentCell.textLabel!.text)

        
        
       // println("You selected cell #\(indexPath.row)!")
        //passNo = indexPath.row
        
        search = currentCell.textLabel!.text
        println(search)
    }
    
 /*
    func controllerDidChangeContent(controller: NSFetchedResultsController!){
        
        tableView.reloadData()
    }*/
    // MARK: - ENSideMenu Delegate
    func sideMenuWillOpen() {
        println("sideMenuWillOpen")
    }
    
    func sideMenuWillClose() {
        println("sideMenuWillClose")
    }
    // disabled Slide Menu
    func sideMenuShouldOpenSideMenu() -> Bool {
        println("sideMenuShouldOpenSideMenu")
        return false;
    }
    
    // populates table with data 
    
    func controllerDidChangeContent(controller: NSFetchedResultsController!)
    {
        tableView.reloadData()
    }
    
}