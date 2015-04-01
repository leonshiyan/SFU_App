//
//  EmailViewController.swift
//  SFUAppButtons
//
//  Created by Hugo Cheng on 2015-03-02.
//  Copyright (c) 2015 Jerrod Seger. All rights reserved.
//

import UIKit

class sMapController: UIViewController, UIWebViewDelegate,ENSideMenuDelegate {
    
    // View Controller to load google maps for SFU, not fully implemented yet //
    
    @IBOutlet weak var mapView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var url = NSURL (string:"https://www.google.ca/maps?q=sfu+surrey&rlz=1C1CHMO_en-GBCA566CA566&ion=1&espv=2&bav=on.2,or.r_cp.&bvm=bv.89744112,d.cGU&biw=1264&bih=937&dpr=1&um=1&ie=UTF-8&sa=X&ei=flcbVdL9C8icoQStuoDICw&ved=0CAYQ_AUoAQ")
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
