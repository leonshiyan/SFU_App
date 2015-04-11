//
//  GradesViewController.swift
//  SFU_App
//
//  Created by Hugo Cheng on 2015-03-05.
//  Copyright (c) 2015 Hugo Cheng. All rights reserved.
//

import UIKit

class goSFUController: UIViewController,ENSideMenuDelegate {
    
    // Create a reachability object
    let reachability = Reachability.reachabilityForInternetConnection()
    
    // Webview for goSFU page//
    
    @IBOutlet weak var goSFUview: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Prepare notifier which constantly observes for connection in the background
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityChanged:", name: ReachabilityChangedNotification, object: reachability)
        reachability.startNotifier()
        
        // Set slide menu control to this controller
        self.sideMenuController()?.sideMenu?.delegate = self;
        
        // url for goSFU
        var url = NSURL(string: "https://go.sfu.ca/psp/paprd/EMPLOYEE/h/?tab=SFU_STUDENT_CENTER")
        
        var request = NSURLRequest(URL:url!)
        goSFUview.loadRequest(request)
        
        
        // Do any additional setup after loading the view.
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
    // Disable SlideMenu
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
