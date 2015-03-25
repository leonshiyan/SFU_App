//
//  ViewController.swift
//  SFU_App
//
//  Created by Hugo Cheng on 2015-03-03.
//  Copyright (c) 2015 Hugo Cheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ENSideMenuDelegate {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var weatherImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sideMenuController()?.sideMenu?.delegate = self;
        

        
        
        
        
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

