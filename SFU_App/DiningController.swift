//
//  DiningController.swift
//  SFU_App
//
//  Created by Nethaniel Yuen on 2015-03-26.
//  Copyright (c) 2015 Hugo Cheng. All rights reserved.
//

import UIKit

class DiningController: UIViewController, ENSideMenuDelegate {
    
    @IBOutlet weak var container: UIView!
    
    override func viewDidLoad() {
        //super.viewDidLoad()
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
        return false;
    }
    
}