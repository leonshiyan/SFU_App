//
//  TransitController.swift
//  SFU_App
//
//  Created by Nethaniel Yuen on 2015-03-05.
//  Copyright (c) 2015 Hugo Cheng. All rights reserved.
//
// XML was acquired using the translink API: https://developer.translink.ca/Home/TermsOfUse
// XML Parsing was done using: https://github.com/DharmeshKheni/XML-parsing-with-swift

import UIKit
import Foundation


var passNo: NSInteger!
var stopNo: NSString!

class TransitController: UITableViewController, NSXMLParserDelegate,ENSideMenuDelegate {
        var toPass:String!
        var parser : NSXMLParser = NSXMLParser() // Instance of NSXML parser
        var subCategoryID : String = String() // stores parsed data
        var subCategoryTitle : String = String()
        var subCat : [subCategory] = [] // Array to hold parsed data
        var eName : String = String() // Tag name
    
        // Create a reachability object
        let reachability = Reachability.reachabilityForInternetConnection()
    
        override func viewDidLoad() {
            super.viewDidLoad()
            stopNo = search
            
            // Prepare notifier which constantly observes for connection in the background
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityChanged:", name: ReachabilityChangedNotification, object: reachability)
            reachability.startNotifier()
            
            // Error checking for when user inputs stop numbers >5 or <5
            if(countElements(search as String) != 5){
                let alertController = UIAlertController(title: "Error", message: "Not a valid 5-number bus stop", preferredStyle: .Alert)
                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertController.addAction(defaultAction)
                self.presentViewController(alertController, animated: true, completion: nil)
            }
            
            //Set slide menu control to this controller
            self.sideMenuController()?.sideMenu?.delegate = self;
                        
            // load translink api url and initialize parser
            println(toPass)
            var url : NSURL = NSURL(string: "http://api.translink.ca/rttiapi/v1/stops/\(search)/estimates?apikey=jTTSvGWPEtJTFahKHoBe")!
            parser = NSXMLParser(contentsOfURL: url)!
            parser.delegate = self
            parser.parse()
        }
    
        // Deinitializes notifier
        deinit {
            reachability.stopNotifier()
        
        }
    
        // Obtain access to correct layer from url XML
        func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: [NSObject : AnyObject]!) {
            
            eName = elementName
            if elementName == "NextBus"{
                subCategoryID = String()
                subCategoryTitle = String()
            }
        }
    
        // Parse selected tags required for desired information and concatenate
        func parser(parser: NSXMLParser!, foundCharacters string: String!) {
            
            let data = string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            if(!data.isEmpty){
                if eName == "ExpectedLeaveTime"{
                    var temp = data
                    var temparr = split(temp) {$0 == " "}
                    subCategoryID += temparr[0]
                    subCategoryID += "  "
                }else if eName == "RouteNo" {
                    subCategoryTitle += data
                    subCategoryTitle += " "
                }else if eName == "RouteName" {
                    var temp2 = data
                    var temp2Arr = split(temp2) {$0 == "/"}
                    subCategoryTitle+=temp2Arr[0]
                }
            }
        }

        // Save ID and Title into desired output variable
        func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!) {
            
            
            if elementName == "NextBus"{
                
                let output : subCategory = subCategory()
                output.subCategoryID = subCategoryID
                output.subCategoryTitle = subCategoryTitle
                subCat.append(output)
            }
            
        }
    
        // Prepare table for View Cells
   
    
        // Assign output to desired cell locations
    
    // Prepare table for View Cells
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Error checking for invalid bus stop number
        if(subCat.count == 0){
            let alertController = UIAlertController(title: "Error", message: "Invalid Bus Stop", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        return subCat.count
    }
    
    // Assign output to desired cell locations
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        //retrieve current time
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: date)
        let minutes = components.minute
        let hours = components.hour
        
        let subCategorys : subCategory = subCat[indexPath.row]
        
        //retrieve next bus times
        var temp = subCategorys.subCategoryID
        var temparr = split(temp) {$0 == " "}
        var nextBusMinutes = temparr[0]
        var nextBusHours = temparr[0]
        var length = nextBusMinutes.utf16Count
        
        //find if hours is length 1 or 2 to get index of minutes correct
        if (length == 6) {
            nextBusMinutes = nextBusMinutes.substringWithRange(Range<String.Index>(start: advance(nextBusMinutes.startIndex, 2), end: advance(nextBusMinutes.startIndex, 4)))
            nextBusHours = nextBusHours.substringWithRange(Range<String.Index>(start: advance(nextBusMinutes.startIndex, 0), end: advance(nextBusMinutes.startIndex, 1)))
        }
        else {
            nextBusMinutes = nextBusMinutes.substringWithRange(Range<String.Index>(start: advance(nextBusMinutes.startIndex, 3), end: advance(nextBusMinutes.startIndex, 5)))
            nextBusHours = nextBusHours.substringWithRange(Range<String.Index>(start: advance(nextBusMinutes.startIndex, 0), end: advance(nextBusMinutes.startIndex, 2)))
        }
        
        let nextBusMinInt:Int? = nextBusMinutes.toInt()
        let nextBusHourInt:Int? = nextBusHours.toInt()
        
        var nextMin: Int
        //calculate time to next bus
        if(nextBusMinInt!<minutes){
            nextMin = (nextBusMinInt!+60) - minutes
            if(nextBusHourInt!>(hours+1)) {
                nextMin += 60
            }
        }
        else {
            nextMin = nextBusMinInt! - minutes
            if (nextBusHourInt!>hours) {
                nextMin += 60
            }
        }
        
        
        let minuteNSNumber = nextMin as NSNumber
        let minuteString : String = minuteNSNumber.stringValue + " mins"
        
        let errorString: String = "Please go back and enter a valid bus stop"
        
        // Configure the cell...
        
        if (subCategoryID.isEmpty){
            cell.textLabel?.text = errorString
        }else{
            cell.textLabel?.text = subCategorys.subCategoryTitle
            cell.detailTextLabel?.text = minuteString //subCategorys.subCategoryID
        }
        return cell
    }
    
    
    
    //store the row index of selected row
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
        passNo = indexPath.row
    }

    
    
    
    // MARK: - ENSideMenu Delegate
    func sideMenuWillOpen() {
        println("sideMenuWillOpen")
    }
    
    func sideMenuWillClose() {
        println("sideMenuWillClose")
    }
    // disabled Slide Menu
    func sideMenuShouldOpenSideMenu() -> Bool {
        println("sideMenuShouldOpenSideMenu")
        return false;
    }
    
    // Function to output alert when internet connection changed
    func reachabilityChanged(note: NSNotification) {
        
        let reachability = note.object as Reachability
        
        if reachability.isReachable() {
            if reachability.isReachableViaWiFi() {
                println("Reachable via WiFi")
            } else {
                println("Reachable via Cellular")
            }
        } else {
            println("Not reachable")
            let alertController = UIAlertController(title: "Error", message: "No internet connection detected", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    
    
    
        }
    
    

