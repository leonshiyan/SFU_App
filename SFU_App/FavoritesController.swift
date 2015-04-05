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
        self.tableView.delegate = self ;
        self.tableView.dataSource = self ;
        //Set slide menu control to this controller
        self.sideMenuController()?.sideMenu?.delegate = self;
        
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
        
     
        
 
        
        
        
     
            cell.textLabel?.text = Display2[indexPath.row]
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