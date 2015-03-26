//
//  MyMenuTableViewController.swift
//  SFU_App
//
//  Created by Nethaniel Yuen on 2015-03-12.
//  Copyright (c) 2015 Hugo Cheng. All rights reserved.
//

import UIKit

class MyMenuTableViewController: UITableViewController {
    var selectedMenuItem : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Customize apperance of table view
        tableView.contentInset = UIEdgeInsetsMake(64.0, 0, 0, 0) //
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0) //
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.clearColor()
        tableView.scrollsToTop = false
        tableView.scrollEnabled = false
        
        
        // Preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        tableView.selectRowAtIndexPath(NSIndexPath(forRow: selectedMenuItem, inSection: 0), animated: false, scrollPosition: .Middle)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return 9
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("CELL") as? UITableViewCell
        
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "CELL")
            
            cell!.backgroundColor = UIColor.clearColor()
            cell!.textLabel?.textColor = UIColor.blackColor()
            cell!.textLabel?.font = UIFont.systemFontOfSize(14.0)
            let selectedBackgroundView = UIView(frame: CGRectMake(0, 0, cell!.frame.size.width, cell!.frame.size.height))
            selectedBackgroundView.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.2)
            cell!.selectedBackgroundView = selectedBackgroundView
        }
        
        switch (indexPath.row) {
        case 0:
            cell!.textLabel?.text = "Home"
            break
        case 1:
            cell!.textLabel?.text = "Services"
            break
        case 2:
            cell!.textLabel?.text = "Transit"
            break
        case 3:
            cell!.textLabel?.text = "News"
            break
        case 4:
            cell!.textLabel?.text = "Maps"
            break
        case 5:
            cell!.textLabel?.text = "BreakMatcher"
            break
        case 6:
            cell!.textLabel?.text = "SFU Loyalty"
            break
        case 7:
            cell!.textLabel?.text = "Account"
            break
        case 8:
            cell!.textLabel?.text = "About"
            break
        default:
            cell!.textLabel?.text = "DEFAULT"
            break
        }
        
        
        
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40.0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        println("did select row: \(indexPath.row)")
        
        if (indexPath.row == selectedMenuItem) {
            return
        }
        selectedMenuItem = indexPath.row
        
        //Present new view controller
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        switch (indexPath.row) {
        case 0:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("mainScreen") as UIViewController
            break
        case 1:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("services") as UIViewController
            break
        case 2:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("transit") as UIViewController
            break
        case 3:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("news") as UIViewController
            break
        case 4:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("maps") as UIViewController
            break
        case 5:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("breakMatcher") as UIViewController
            break
        case 6:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("loyalty") as UIViewController
            break
        case 7:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("login") as UIViewController
            break
        case 8:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("About") as UIViewController
            break
        default:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("login") as UIViewController
            break
        }

        sideMenuController()?.setContentViewController(destViewController)
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}