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
    
    // Create a reachability object
    let reachability = Reachability.reachabilityForInternetConnection()
    
    // Core data variables//
   
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    
  
    

    
    
    //go back when cancel pushed
    @IBAction func cancelToFavoritesController(segue:UIStoryboardSegue) {
        
    }
    //save user input
    @IBAction func saveBusStopDetail(segue:UIStoryboardSegue) {
        let BusDetailsViewController = segue.sourceViewController as BusStopDetail
        var buses = [FavBus]()
        let fetchRequest  = NSFetchRequest(entityName:"FavBus")
        buses = managedObjectContext!.executeFetchRequest(fetchRequest,error: nil ) as [FavBus]
        
        //add the new bus to the players array
        players.append(player)
        
        //update the tableView
        let indexPath = NSIndexPath(forRow: buses.count-1, inSection: 0)
        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        
        //hide the detail view controller
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Prepare notifier which constantly observes for connection in the background
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityChanged:", name: ReachabilityChangedNotification, object: reachability)
        reachability.startNotifier()
        
        self.tableView.rowHeight = 50 ;
        self.tableView.delegate = self ;
        self.tableView.dataSource = self ;
        //Set slide menu control to this controller
        self.sideMenuController()?.sideMenu?.delegate = self;
        
        /*let entityDescription = NSEntityDescription.entityForName("FavBus", inManagedObjectContext: managedObjectContext!)
        let favs = FavBus(entity: entityDescription!,insertIntoManagedObjectContext: managedObjectContext)
        
        favs.busnum = "58444"
        favs.tag = "test"*/
        
    }
    
    // Deinitializes notifier
    deinit {
        reachability.stopNotifier()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
        
        
        
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let fetchRequest  = NSFetchRequest(entityName:"FavBus")
        let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest,error: nil )
        var Display2 : [String] = []
        for  result in fetchResults as [FavBus] {
          Display2.append(result.tag)
        
        
        }
        
        
        
        return Display2.count
        //println(temparr)
        
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let fetchRequest  = NSFetchRequest(entityName:"FavBus")
        let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest,error: nil )
        var Display2 : [String] = []
        for  result in fetchResults as [FavBus] {
            Display2.append(result.tag)
            
            
        }

            var  cell = tableView.dequeueReusableCellWithIdentifier("Cell",forIndexPath: indexPath) as UITableViewCell
        
     
        
 
        
        
        
     
            cell.textLabel!.text = Display2[indexPath.row]
            return cell
        
        
        
        
        
        
        
    }
    //segue bus number assiciated with cell in search
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        var buses = [FavBus]()
        let fetchRequest  = NSFetchRequest(entityName:"FavBus")
        buses = managedObjectContext!.executeFetchRequest(fetchRequest,error: nil ) as [FavBus]
     
        
        let indexPath = tableView.indexPathForSelectedRow();
        
        let currentCell = tableView.cellForRowAtIndexPath(indexPath!) as UITableViewCell!
        
        println(currentCell.textLabel!.text)

        
        
       // println("You selected cell #\(indexPath.row)!")
        //passNo = indexPath.row
        
        search = buses[indexPath!.row].busnum
            //currentCell.textLabel!.text
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
    
    // Function to output alert when internet connection changed
    func reachabilityChanged(note: NSNotification) {
        
        let reachability = note.object as Reachability
        
        if reachability.isReachable() {
            if reachability.isReachableViaWiFi() {
                println("Reachable via WiFi")
            } else {
                println("Reachable via Cellular")
            }
        } else {
            println("Not reachable")
            let alertController = UIAlertController(title: "Error", message: "No internet connection detected", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    // populates table with data 
    
    func controllerDidChangeContent(controller: NSFetchedResultsController!)
    {
        tableView.reloadData()
    }
    
}