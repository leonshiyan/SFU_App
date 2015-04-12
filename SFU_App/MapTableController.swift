//
//  MapTableController.swift
//  SFU_App
//
//  Created by Nethaniel Yuen on 2015-03-20.
//  Copyright (c) 2015 Hugo Cheng. All rights reserved.
//

import UIKit
import Foundation


class MapTableController: UITableViewController {
    
    
    @IBOutlet weak var bMaps: UIView!
    @IBOutlet weak var sMaps: UIView!
    @IBOutlet weak var vMaps: UIView!
    
    // Create a reachability object
    let reachability = Reachability.reachabilityForInternetConnection()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Prepare notifier which constantly observes for connection in the background
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityChanged:", name: ReachabilityChangedNotification, object: reachability)
        reachability.startNotifier()
        
        let shadowPath = UIBezierPath(rect: bMaps.bounds)
        bMaps.layer.masksToBounds = false
        bMaps.layer.shadowColor = UIColor.blackColor().CGColor
        bMaps.layer.shadowOffset = CGSizeMake(0, 0.5)
        bMaps.layer.shadowOpacity = 0.1
        bMaps.layer.shadowPath = shadowPath.CGPath
        
        let shadowPath2 = UIBezierPath(rect: sMaps.bounds)
        sMaps.layer.masksToBounds = false
        sMaps.layer.shadowColor = UIColor.blackColor().CGColor
        sMaps.layer.shadowOffset = CGSizeMake(0, 0.5)
        sMaps.layer.shadowOpacity = 0.1
        sMaps.layer.shadowPath = shadowPath2.CGPath
        
        let shadowPath3 = UIBezierPath(rect: vMaps.bounds)
        vMaps.layer.masksToBounds = false
        vMaps.layer.shadowColor = UIColor.blackColor().CGColor
        vMaps.layer.shadowOffset = CGSizeMake(0, 0.5)
        vMaps.layer.shadowOpacity = 0.1
        vMaps.layer.shadowPath = shadowPath3.CGPath
    }
    
    // Deinitializes notifier
    deinit {
        reachability.stopNotifier()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toggleSideMenu(sender: AnyObject) {
        toggleSideMenuView()
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

