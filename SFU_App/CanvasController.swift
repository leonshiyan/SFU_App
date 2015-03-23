//
//  EmailViewController.swift
//  SFUAppButtons
//
//  Created by Hugo Cheng on 2015-03-02.
//  Copyright (c) 2015 Jerrod Seger. All rights reserved.
//

import UIKit
import Foundation

class CanvasController: UIViewController,ENSideMenuDelegate {
    
    // View Controller for Canvas.sfu.ca
    @IBOutlet weak var CanvasController: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set slide menu control to this controller
        self.sideMenuController()?.sideMenu?.delegate = self;
        
        //URL to sfu canvas
        var url = NSURL (string:"https://canvas.sfu.ca")
        // Load Url into webview
        var request = NSURLRequest(URL: url!)
        CanvasController.loadRequest(request)
        
        
        
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
    
    func webViewDidFinishLoad(webView: UIWebView) {
        
        
        
        
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
