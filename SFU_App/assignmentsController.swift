//
//  assignmentsController.swift
//  SFU_App
//
//  Created by Jerrod Seger on 2015-03-17.
//  Copyright (c) 2015 Hugo Cheng. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func stripCharactersInSet(chars: [Character]) -> String {
        return String(filter(self) {find(chars, $0) == nil})
    }
}

class MyCustomCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var grade: UILabel!
    
}


class assignmentsController: UITableViewController {
    
    @IBOutlet var assignmentTable: UITableView!
    
    var programVar : Int = 1
    
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
        
        let currentURLString = "https://canvas.sfu.ca/courses/" + String(programVar) + "/grades/"
        
        
        let currentURL = NSURL(string: currentURLString)
        var err : NSError?
        
        
        let currentHTMLString = NSString(contentsOfURL: currentURL!, encoding: NSUTF8StringEncoding, error: nil)
        
        
        var parser = HTMLParser(html : currentHTMLString!, error: &err)
        if err != nil{
            println(err)
            exit(1)
        }
        
        var bodyNode = parser.body
        
        if let assignmentNodes = bodyNode?.findChildTagsAttr("tr", attrName: "class", attrValue: "student_assignment assignment_graded editable"){
            for node in assignmentNodes{
                if let nameNode = node.findChildTagAttr("th", attrName: "class", attrValue: "title"){
                    if let nameNode = node.findChildTag("a"){
                        assignmentNames.append(nameNode.contents)
                    }
                }
                if let nameNode = node.findChildTagAttr("span", attrName: "class", attrValue: "score"){
                    var string = nameNode.contents.stripCharactersInSet(chars)
                    let decimalAsDouble = NSNumberFormatter().numberFromString(string)!.doubleValue
                    
                    assignmentScore.append(
                        NSString(format: "%.2f", decimalAsDouble)
                    )
                }
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
            
            
            
            (cell as MyCustomCell).name.text = name
            (cell as MyCustomCell).grade.text = score + "/" + outOf
            
            return cell
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