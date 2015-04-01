//
//  EmailViewController.swift
//  SFUAppButtons
//
//  Created by Hugo Cheng on 2015-03-02.
//  Copyright (c) 2015 Jerrod Seger. All rights reserved.
//

import UIKit

class vMapController: UIViewController, UIWebViewDelegate,ENSideMenuDelegate {
    
    // View Controller to load google maps for SFU, not fully implemented yet //
    
    @IBOutlet weak var mapView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var url = NSURL (string:"https://www.google.ca/maps/place/Simon+Fraser+University+at+Harbour+Centre/@49.284324,-123.111942,17z/data=!3m1!4b1!4m2!3m1!1s0x548673e7bde5acdf:0x9f179f886a077be4")
        var LoginRequest = NSURLRequest(URL: url!)
        mapView.delegate=self
        
        mapView.loadRequest(LoginRequest)
        
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
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
