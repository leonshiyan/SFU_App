//
//  ViewController.swift
//  SFU_App
//
//  Created by Hugo Cheng on 2015-03-03.
//  Copyright (c) 2015 Hugo Cheng. All rights reserved.
//

import UIKit

class ServicesController: UITableViewController {
    
    
    @IBOutlet var servicesTableView: UITableView!
    
    @IBOutlet weak var schedule: UIView!
    @IBOutlet weak var courseGrades: UIView!
    @IBOutlet weak var email: UIView!
    @IBOutlet weak var canvas: UIView!
    @IBOutlet weak var goSFU: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Adjust navigation tab color to red
        servicesTableView.separatorColor = UIColor(red: (224/255.0), green: (224/255.0), blue: (224/255.0), alpha: 1.0)
        
        let shadowPath = UIBezierPath(rect: schedule.bounds)
        schedule.layer.masksToBounds = false
        schedule.layer.shadowColor = UIColor.blackColor().CGColor
        schedule.layer.shadowOffset = CGSizeMake(0, 0.5)
        schedule.layer.shadowOpacity = 0.1
        schedule.layer.shadowPath = shadowPath.CGPath
        
        let shadowPath2 = UIBezierPath(rect: courseGrades.bounds)
        courseGrades.layer.masksToBounds = false
        courseGrades.layer.shadowColor = UIColor.blackColor().CGColor
        courseGrades.layer.shadowOffset = CGSizeMake(0, 0.5)
        courseGrades.layer.shadowOpacity = 0.1
        courseGrades.layer.shadowPath = shadowPath2.CGPath
        
        let shadowPath3 = UIBezierPath(rect: email.bounds)
        email.layer.masksToBounds = false
        email.layer.shadowColor = UIColor.blackColor().CGColor
        email.layer.shadowOffset = CGSizeMake(0, 0.5)
        email.layer.shadowOpacity = 0.1
        email.layer.shadowPath = shadowPath3.CGPath
        
        let shadowPath4 = UIBezierPath(rect: canvas.bounds)
        canvas.layer.masksToBounds = false
        canvas.layer.shadowColor = UIColor.blackColor().CGColor
        canvas.layer.shadowOffset = CGSizeMake(0, 0.5)
        canvas.layer.shadowOpacity = 0.1
        canvas.layer.shadowPath = shadowPath4.CGPath
        
        let shadowPath5 = UIBezierPath(rect: goSFU.bounds)
        goSFU.layer.masksToBounds = false
        goSFU.layer.shadowColor = UIColor.blackColor().CGColor
        goSFU.layer.shadowOffset = CGSizeMake(0, 0.5)
        goSFU.layer.shadowOpacity = 0.1
        goSFU.layer.shadowPath = shadowPath5.CGPath
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toggleSideMenu(sender: AnyObject) {
        toggleSideMenuView()
    }
}

