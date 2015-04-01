//
//  ChannelController.swift
//  SFU_App
//
//  Created by Yan Shi on 2015-03-22.
//  Copyright (c) 2015 Hugo Cheng. All rights reserved.
//

import Foundation

import UIKit
var rsschn: NSString!
var eventTitle: String!
class ChannelController: UITableViewController{
    
    @IBOutlet weak var bevents: UIButton!
    @IBOutlet weak var sevents: UIButton!
    @IBOutlet weak var vevents: UIButton!
    @IBOutlet weak var deadlines: UIButton!
    
    @IBOutlet weak var volunteer: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let shadowPath = UIBezierPath(rect: bevents.bounds)
        bevents.layer.masksToBounds = false
        bevents.layer.shadowColor = UIColor.blackColor().CGColor
        bevents.layer.shadowOffset = CGSizeMake(0, 0.5)
        bevents.layer.shadowOpacity = 0.1
        bevents.layer.shadowPath = shadowPath.CGPath
        
        let shadowPath2 = UIBezierPath(rect: sevents.bounds)
        sevents.layer.masksToBounds = false
        sevents.layer.shadowColor = UIColor.blackColor().CGColor
        sevents.layer.shadowOffset = CGSizeMake(0, 0.5)
        sevents.layer.shadowOpacity = 0.1
        sevents.layer.shadowPath = shadowPath2.CGPath
        
        let shadowPath3 = UIBezierPath(rect: vevents.bounds)
        vevents.layer.masksToBounds = false
        vevents.layer.shadowColor = UIColor.blackColor().CGColor
        vevents.layer.shadowOffset = CGSizeMake(0, 0.5)
        vevents.layer.shadowOpacity = 0.1
        vevents.layer.shadowPath = shadowPath3.CGPath
        
        let shadowPath4 = UIBezierPath(rect: deadlines.bounds)
        deadlines.layer.masksToBounds = false
        deadlines.layer.shadowColor = UIColor.blackColor().CGColor
        deadlines.layer.shadowOffset = CGSizeMake(0, 0.5)
        deadlines.layer.shadowOpacity = 0.1
        deadlines.layer.shadowPath = shadowPath4.CGPath
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toggleSideMenu(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    override func prepareForSegue(segue: (UIStoryboardSegue!), sender: AnyObject!) {
        var svc = segue!.destinationViewController as NewsTableViewController;

        if (segue!.identifier == "event1")
        {
            svc.rsschn = "https://events.sfu.ca/rss/calendar_id/2.xml"
            svc.eventTitle = "Burnaby Events Calender"
        }
        else if (segue!.identifier == "event2")
        {
            svc.rsschn = "https://events.sfu.ca/rss/calendar_id/5.xml"
            svc.eventTitle = "Surrey Events Calender"

        }
        else if(segue!.identifier == "event3")
        {
            svc.rsschn = "https://events.sfu.ca/rss/calendar_id/6.xml"
            svc.eventTitle = "Vancouver Event Calender"
        }
        else if(segue!.identifier == "event4")
        {
            svc.rsschn = "https://events.sfu.ca/rss/calendar_id/18.xml"
            svc.eventTitle = "Volunteer Servicies"
        }
        else
        {
            svc.rsschn = "https://events.sfu.ca/rss/calendar_id/30.xml"
            svc.eventTitle = "eadlines"

        }
        
    }
}
