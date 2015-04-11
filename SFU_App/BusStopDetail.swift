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
    
    // Create a reachability object
    let reachability = Reachability.reachabilityForInternetConnection()
    
    //initialize buttons
    @IBOutlet weak var BusStopNum: UITextField!
    @IBOutlet weak var BusStopName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*let entityDescription = NSEntityDescription.entityForName("FavBus", inManagedObjectContext: managedObjectContext!)
        
        let favs = FavBus(entity: entityDescription!,insertIntoManagedObjectContext: managedObjectContext)
        
        favs.busnum = "58444"
        favs.tag = "test"*/
        
        // Prepare notifier which constantly observes for connection in the background
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityChanged:", name: ReachabilityChangedNotification, object: reachability)
        reachability.startNotifier()
        
        var error: NSError?
        
        managedObjectContext?.save(&error)
        
        if  let err = error {
            println(err.localizedFailureReason)
            
        } else{
            println("Bus stop saved")
            
        }

        //Set slide menu control to this controller
        self.sideMenuController()?.sideMenu?.delegate = self;
        
    }
    
    // Deinitializes notifier
    deinit {
        reachability.stopNotifier()
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
}
