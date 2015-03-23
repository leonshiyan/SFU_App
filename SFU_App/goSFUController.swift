//
//  GradesViewController.swift
//  SFU_App
//
//  Created by Hugo Cheng on 2015-03-05.
//  Copyright (c) 2015 Hugo Cheng. All rights reserved.
//

import UIKit

class goSFUController: UIViewController,ENSideMenuDelegate {
    
    
    // Webview for goSFU page//
    
    @IBOutlet weak var goSFUview: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set slide menu control to this controller
        self.sideMenuController()?.sideMenu?.delegate = self;
        
        // url for goSFU
        var url = NSURL(string: "https://go.sfu.ca/psp/paprd/EMPLOYEE/h/?tab=SFU_STUDENT_CENTER")
        
        var request = NSURLRequest(URL:url!)
        goSFUview.loadRequest(request)
        
        
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
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
