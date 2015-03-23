//
//  BusPassUpController.swift
//  SFU_App
//
//  Created by Nethaniel Yuen on 2015-03-20.
//  Copyright (c) 2015 Hugo Cheng. All rights reserved.
//

import UIKit

class BusPassUpController: UIViewController,ENSideMenuDelegate {
    
    // View controller to connect user to bus pass up website
    @IBOutlet var BusPassUpView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set slide menu control to this controller
        self.sideMenuController()?.sideMenu?.delegate = self;
        
        // URL to SFU connect
        var url = NSURL (string:"http://www.sfu.ca/busstop.html")
        // Load URL into webview webbrowser
        var request = NSURLRequest(URL: url!)
        BusPassUpView.loadRequest(request)
        
        
        // Do any additional setup after loading the view.
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
    // disabled Slide Menu
    func sideMenuShouldOpenSideMenu() -> Bool {
        println("sideMenuShouldOpenSideMenu")
        return false;
    }
    
    
}
