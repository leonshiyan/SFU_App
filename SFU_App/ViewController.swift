//
//  ViewController.swift
//  SFU_App
//
//  Created by Hugo Cheng on 2015-03-03.
//  Copyright (c) 2015 Hugo Cheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ENSideMenuDelegate {

    @IBOutlet weak var weatherImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sideMenuController()?.sideMenu?.delegate = self;
        
        //let currentURLString = "http://api.openweathermap.org/data/2.5/weather?q=Burnaby&mode=xml"
        
        
        //let currentURL = NSURL(string: currentURLString)
        //var err : NSError?
        
        
        //let currentHTMLString = NSString(contentsOfURL: currentURL!, encoding: NSUTF8StringEncoding, error: nil)
        
        
        //var parser = HTMLParser(html : currentHTMLString!, error: &err)
        //if err != nil{
        //    println(err)
        //    exit(1)
        //}
        
        let moon = UIImage(named: "moon.png") as UIImage!
        let thunder = UIImage(named: "thunder.png") as UIImage!
        let cloudy = UIImage(named: "cloudy.png") as UIImage!
        let suncloud = UIImage(named: "suncloud.png") as UIImage!
        let snow = UIImage(named: "snow.png") as UIImage!
        let rain = UIImage(named: "rain.png") as UIImage!
        let sunny = UIImage(named: "sunny.png") as UIImage!
        

        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toggleSideMenu(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    // MARK: - ENSideMenu Delegate
    func sideMenuWillOpen() {
        println("sideMenuWillOpen")
    }
    
    func sideMenuWillClose() {
        println("sideMenuWillClose")
    }
    
    func sideMenuShouldOpenSideMenu() -> Bool {
        println("sideMenuShouldOpenSideMenu")
        return true;
    }

}

