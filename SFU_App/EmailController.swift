//
//  EmailViewController.swift
//  SFUAppButtons
//
//  Created by Hugo Cheng on 2015-03-02.
//  Copyright (c) 2015 Jerrod Seger. All rights reserved.
//

import UIKit

class EmailController: UIViewController,ENSideMenuDelegate {
    
    // View controller to connet user to connect.sfu.ca
    @IBOutlet weak var EmailWebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set slide menu control to this controller
        self.sideMenuController()?.sideMenu?.delegate = self;
      
        // URL to SFU connect
        var url = NSURL (string:"https://connect.sfu.ca")
        // Load URL into webview webbrowser
        var request = NSURLRequest(URL: url!)
        EmailWebView.loadRequest(request)
        
        
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
    // Disable SlideMenu
    func sideMenuShouldOpenSideMenu() -> Bool {
        println("sideMenuShouldOpenSideMenu")
        return false;
    }
    
    
}
