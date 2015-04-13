//
//  assignmentsController.swift
//  SFU_App
//
//  Created by Jerrod Seger on 2015-03-17.
//  Copyright (c) 2015 Hugo Cheng. All rights reserved.
//

import Foundation
import UIKit

// String Extention to strip characters in a inputed array
extension String {
    func stripCharactersInSet(chars: [Character]) -> String {
        return String(filter(self) {find(chars, $0) == nil})
    }
}
// Custom Table view cell//
class MyCustomCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var grade: UILabel!
    
}


class assignmentsController: UITableViewController {
    
    @IBOutlet var assignmentTable: UITableView!
    
    var programVar : Int = 1
    // Array to hold scores, assignment names, and totals //
    var assignmentNames: [String] = []
    var assignmentScore: [String] = []
    var assignmentOutOf: [String] = []
    
    let chars: [Character] = [" ", "\n"]
    
    // Create a reachability object
    let reachability = Reachability.reachabilityForInternetConnection()
    
    override func viewDidLoad() {
        
        //Check internet connection to instantly return
        if(Reachability.isConnectedToNetwork() == false){
            return
        }
        
        // Prepare notifier which constantly observes for connection in the background
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityChanged:", name: ReachabilityChangedNotification, object: reachability)
        reachability.startNotifier()
        
        // Begin RESTAPi calls to parse website for canvas grades
        let currentURLString = "https://canvas.sfu.ca/courses/" + String(programVar) + "/grades/"
        
        
        let currentURL = NSURL(string: currentURLString)
        var err : NSError?
        
        
        let currentHTMLString = NSString(contentsOfURL: currentURL!, encoding: NSUTF8StringEncoding, error: nil)
        
        // USE imported HTMLParser Class
        
        var parser = HTMLParser(html : currentHTMLString!, error: &err)
        if err != nil{
           // println(err)
            exit(1)
        }
        
        var bodyNode = parser.body
         // Search for unique tags that return course and assignment information
        if let assignmentNodes = bodyNode?.findChildTagsAttr("tr", attrName: "class", attrValue: "student_assignment assignment_graded editable"){
            for node in assignmentNodes{
                if let nameNode = node.findChildTagAttr("th", attrName: "class", attrValue: "title"){
                    if let nameNode = node.findChildTag("a"){
                        // Add it to assignNames
                        assignmentNames.append(nameNode.contents)
                    }
                }
                // Search for SCore
                if let nameNode = node.findChildTagAttr("span", attrName: "class", attrValue: "score"){
                    var string = nameNode.contents.stripCharactersInSet(chars)
                    let decimalAsDouble = NSNumberFormatter().numberFromString(string)!.doubleValue
                    
                    assignmentScore.append(
                        NSString(format: "%.2f", decimalAsDouble)
                    )
                }
                // Search for total
                if let nameNode = node.findChildTagAttr("td", attrName: "class", attrValue: "possible points_possible"){
                    assignmentOutOf.append(nameNode.contents.stripCharactersInSet(chars))
                }
            }
        }
    }
    
    // Deinitializes notifier
    deinit {
        reachability.stopNotifier()
    }
    
    // Code to populate table view cells
    
    
    override func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int)
        -> Int {
            return assignmentNames.count
    }
    
    override func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
            let name = self.assignmentNames[indexPath.row]
            let score = self.assignmentScore[indexPath.row]
            let outOf = self.assignmentOutOf[indexPath.row]
            
            let cell = tableView.dequeueReusableCellWithIdentifier("assignmentWithScore", forIndexPath: indexPath) as UITableViewCell
            
            // iterates through al lthe assignment name and grades to display scores
            
            (cell as MyCustomCell).name.text = name
            (cell as MyCustomCell).grade.text = score + "/" + outOf
            
            return cell
    }
    
    // Function to output alert when internet connection changed
    func reachabilityChanged(note: NSNotification) {
        
        let reachability = note.object as Reachability
        
        if reachability.isReachable() {
            if reachability.isReachableViaWiFi() {
               //println("Reachable via WiFi")
            } else {
                //println("Reachable via Cellular")
            }
        } else {
            //println("Not reachable")
            let alertController = UIAlertController(title: "Error", message: "No internet connection detected", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    
    
    
}