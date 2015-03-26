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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
