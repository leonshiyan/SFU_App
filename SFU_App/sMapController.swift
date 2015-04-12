//
//  EmailViewController.swift
//  SFUAppButtons
//
//  Created by Hugo Cheng on 2015-03-02.
//  Copyright (c) 2015 Jerrod Seger. All rights reserved.
//

import UIKit

class sMapController: UIViewController, UIWebViewDelegate,ENSideMenuDelegate {
    
    // Create a reachability object
    let reachability = Reachability.reachabilityForInternetConnection()
    
    // View Controller to load google maps for SFU, not fully implemented yet //
    
    @IBOutlet weak var mapView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Prepare notifier which constantly observes for connection in the background
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityChanged:", name: ReachabilityChangedNotification, object: reachability)
        reachability.startNotifier()
        
        var url = NSURL (string:"https://www.google.ca/maps?q=sfu+surrey&rlz=1C1CHMO_en-GBCA566CA566&ion=1&espv=2&bav=on.2,or.r_cp.&bvm=bv.89744112,d.cGU&biw=1264&bih=937&dpr=1&um=1&ie=UTF-8&sa=X&ei=flcbVdL9C8icoQStuoDICw&ved=0CAYQ_AUoAQ")
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
