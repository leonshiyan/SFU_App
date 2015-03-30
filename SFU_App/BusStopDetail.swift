//
//  BusStopDetail.swift
//  SFU_App
//
//  Created by Daniel Russell on 2015-03-23.
//  Copyright (c) 2015 Hugo Cheng. All rights reserved.
//
import UIKit
import CoreData
var player: Player!
var players: [Player] = basedata

class BusStopDetail: UITableViewController,ENSideMenuDelegate {
    // Core data objects//
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    
    
    
    
    
    
    //initialize buttons
    @IBOutlet weak var BusStopNum: UITextField!
    @IBOutlet weak var BusStopName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set slide menu control to this controller
        self.sideMenuController()?.sideMenu?.delegate = self;
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //text fields priority on clicked
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            BusStopNum.becomeFirstResponder()
            BusStopName.becomeFirstResponder()
        }
    }
    //save enter bus stop and name to players array
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "saveBusStopDetail" {
            player = Player(name: self.BusStopName.text, number: self.BusStopNum.text)
            
            
            // Adding code to add BusStopName.text and BusStopNum to core data //
            let entityDescription = NSEntityDescription.entityForName("FavBus", inManagedObjectContext: managedObjectContext!)
            
            let favs = FavBus(entity: entityDescription!,insertIntoManagedObjectContext: managedObjectContext)
            
            favs.busnum = BusStopNum.text
            favs.tag = BusStopName.text
            
            var error: NSError?
            
            managedObjectContext?.save(&error)
            
            if  let err = error {
                println(err.localizedFailureReason)
                
            } else{
                println("Bus stop saved")
            }
            
        }
        
        
        
    }
    
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
}
