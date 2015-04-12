//
//  EmailViewController.swift
//  SFUAppButtons
//
//  Created by Hugo Cheng on 2015-03-02.
//  Copyright (c) 2015 Jerrod Seger. All rights reserved.
//

import UIKit

class vMapController: UIViewController, UIWebViewDelegate,ENSideMenuDelegate {
    
    // Create a reachability object
    let reachability = Reachability.reachabilityForInternetConnection()
    
    // View Controller to load google maps for SFU, not fully implemented yet //
    
    @IBOutlet weak var mapView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Prepare notifier which constantly observes for connection in the background
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityChanged:", name: ReachabilityChangedNotification, object: reachability)
        reachability.startNotifier()
        
        var url = NSURL (string:"https://www.google.ca/maps/place/Simon+Fraser+University+at+Harbour+Centre/@49.284324,-123.111942,17z/data=!3m1!4b1!4m2!3m1!1s0x548673e7bde5acdf:0x9f179f886a077be4")
        var LoginRequest = NSURLRequest(URL: url!)
        mapView.delegate=self
        
        mapView.loadRequest(LoginRequest)
        
    }
    
    // Deinitializes notifier
    deinit {
        reachability.stopNotifier()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - ENSideMenu Delegate
    func sideMenuWillOpen() {
        println("sideMenuWillOpen")
    }
    
    func sideMenuWillClose() {
        println("sideMenuWillClose")
    }
    // Disabled SlideMenu
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
