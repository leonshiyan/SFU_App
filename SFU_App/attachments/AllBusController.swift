//
//  AllBusController.swift
//  SFU_App
//
//  Created by Daniel Russell on 2015-03-22.
//  Copyright (c) 2015 Hugo Cheng. All rights reserved.
//
// XML was acquired using the translink API: https://developer.translink.ca/Home/TermsOfUse
// XML Parsing was done using: https://github.com/DharmeshKheni/XML-parsing-with-swift

import Foundation
import UIKit



class AllBusController: UITableViewController, NSXMLParserDelegate {
    var parser : NSXMLParser = NSXMLParser() // Instance of NSXML parser
    var subCategoryID : String = String() // stores parsed data
    var subCat : [subCategory] = [] // Array to hold parsed data
    var subCategoryTitle : String = String()
    var eName : String = String() // Tag name
    var i = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println(passNo)
        
        
        // load translink api url and initialize parser
        var url : NSURL = NSURL(string: "http://api.translink.ca/rttiapi/v1/stops/\(stopNo)/estimates?apikey=jTTSvGWPEtJTFahKHoBe")!
        parser = NSXMLParser(contentsOfURL: url)!
        parser.delegate = self
        parser.parse()
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
                subCategoryTitle+=data
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
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let subCategorys : subCategory = subCat[passNo]
        var temparr = split(subCategorys.subCategoryID) {$0 == " "}
        //println(temparr)
        var cellCount = temparr.count + 1
        //println(cellCount)
        
        return cellCount
    }
    
    // Assign output to desired cell locations
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let subCategorys : subCategory = subCat[passNo]
        var temparr = split(subCategorys.subCategoryID) {$0 == " "}
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        
        if (indexPath.row == 0) {
            cell.textLabel.text = subCategorys.subCategoryTitle
        }
        else{
            cell.textLabel.text = temparr[indexPath.row-1]
        }
        return cell
    }
    


}