//
//  courseGradeController.swift
//  SFU_App
//
//  Created by Jerrod Seger on 2015-03-17.
//  Copyright (c) 2015 Hugo Cheng. All rights reserved.
//

import Foundation
import UIKit

class courseGradeController: UITableViewController,ENSideMenuDelegate {
    
    @IBOutlet weak var course0: UILabel!
    @IBOutlet weak var courseDesc0: UILabel!
    
    @IBOutlet weak var course1: UILabel!
    @IBOutlet weak var courseDesc1: UILabel!
    
    @IBOutlet weak var course2: UILabel!
    @IBOutlet weak var courseDesc2: UILabel!
    
    @IBOutlet weak var course3: UILabel!
    @IBOutlet weak var courseDesc3: UILabel!
    
    @IBOutlet weak var course4: UILabel!
    @IBOutlet weak var courseDesc4: UILabel!
    
    @IBOutlet weak var course5: UILabel!
    @IBOutlet weak var courseDesc5: UILabel!
    
    @IBOutlet weak var course6: UILabel!
    @IBOutlet weak var courseDesc6: UILabel!
    
    @IBOutlet weak var course7: UILabel!
    @IBOutlet weak var courseDesc7: UILabel!
    
    @IBOutlet weak var course8: UILabel!
    @IBOutlet weak var courseDesc8: UILabel!
    
    @IBOutlet weak var course9: UILabel!
    @IBOutlet weak var courseDesc9: UILabel!
    
    @IBOutlet weak var course10: UILabel!
    @IBOutlet weak var courseDesc10: UILabel!
    
    @IBOutlet weak var course11: UILabel!
    @IBOutlet weak var courseDesc11: UILabel!
    
    
    @IBOutlet weak var cell0: UITableViewCell!
    @IBOutlet weak var cell1: UITableViewCell!
    @IBOutlet weak var cell2: UITableViewCell!
    @IBOutlet weak var cell3: UITableViewCell!
    @IBOutlet weak var cell4: UITableViewCell!
    
    @IBOutlet weak var cell5: UITableViewCell!
    @IBOutlet weak var cell6: UITableViewCell!
    @IBOutlet weak var cell7: UITableViewCell!
    @IBOutlet weak var cell8: UITableViewCell!
    @IBOutlet weak var cell9: UITableViewCell!
    @IBOutlet weak var cell10: UITableViewCell!
    @IBOutlet weak var cell11: UITableViewCell!
    
    var classIDArray = [Int](count: 20, repeatedValue: 0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set slide menu control to this controller
        self.sideMenuController()?.sideMenu?.delegate = self;
        
        let currentURLString = "https://canvas.sfu.ca/grades"
        
        
        let currentURL = NSURL(string: currentURLString)
        var err : NSError?
        
        
        let currentHTMLString = NSString(contentsOfURL: currentURL!, encoding: NSUTF8StringEncoding, error: nil)
        
        
        var parser = HTMLParser(html : currentHTMLString!, error: &err)
        if err != nil{
            println(err)
            exit(1)
        }
        
        var bodyNode = parser.body
        
        course0.text = ""
        course1.text = ""
        course2.text = ""
        course3.text = ""
        course4.text = ""
        course5.text = ""
        course6.text = ""
        course7.text = ""
        course8.text = ""
        course9.text = ""
        course10.text = ""
        course11.text = ""
        
        cell0.hidden = true
        cell1.hidden = true
        cell2.hidden = true
        cell3.hidden = true
        cell4.hidden = true
        cell5.hidden = true
        cell6.hidden = true
        cell7.hidden = true
        cell8.hidden = true
        cell9.hidden = true
        cell10.hidden = true
        cell11.hidden = true
        
        courseDesc0.text = ""
        courseDesc1.text = ""
        courseDesc2.text = ""
        courseDesc3.text = ""
        courseDesc4.text = ""
        courseDesc5.text = ""
        courseDesc6.text = ""
        courseDesc7.text = ""
        courseDesc8.text = ""
        courseDesc9.text = ""
        courseDesc10.text = ""
        courseDesc11.text = ""
        
        
        
        if let inputNodes = bodyNode?.findChildTagsAttr("li", attrName: "class", attrValue: "customListItem"){
            var i = 0
            for node in inputNodes{
                classIDArray[i] = node.dataIDCanvas.toInt()!
                if let inputNodes2 = node.findChildTagAttr("span", attrName: "class", attrValue: "name ellipsis"){
                    //println(inputNodes2.contents)
                    var myStringArr = inputNodes2.contents.componentsSeparatedByString(" ")
                    let nameLength = countElements(myStringArr[0]) + 1
                    switch i{
                    case 0:
                        cell0.hidden = false
                        course0.text = myStringArr[0] + " - Canvas"
                        courseDesc0.text = inputNodes2.contents.substringWithRange(Range<String.Index>(start: advance(inputNodes2.contents.startIndex, nameLength), end: advance(inputNodes2.contents.endIndex, 0)))
                    case 1:
                        cell1.hidden = false
                        course1.text = myStringArr[0] + " - Canvas"
                        courseDesc1.text = inputNodes2.contents.substringWithRange(Range<String.Index>(start: advance(inputNodes2.contents.startIndex, nameLength), end: advance(inputNodes2.contents.endIndex, 0)))
                    case 2:
                        cell2.hidden = false
                        course2.text = myStringArr[0] + " - Canvas"
                        courseDesc2.text = inputNodes2.contents.substringWithRange(Range<String.Index>(start: advance(inputNodes2.contents.startIndex, nameLength), end: advance(inputNodes2.contents.endIndex, 0)))
                    case 3:
                        cell3.hidden = false
                        course3.text = myStringArr[0] + " - Canvas"
                        courseDesc3.text = inputNodes2.contents.substringWithRange(Range<String.Index>(start: advance(inputNodes2.contents.startIndex, nameLength), end: advance(inputNodes2.contents.endIndex, 0)))
                    case 4:
                        cell4.hidden = false
                        course4.text = myStringArr[0] + " - Canvas"
                        courseDesc4.text = inputNodes2.contents.substringWithRange(Range<String.Index>(start: advance(inputNodes2.contents.startIndex, nameLength), end: advance(inputNodes2.contents.endIndex, 0)))
                    case 5:
                        cell5.hidden = false
                        course5.text = myStringArr[0] + " - Canvas"
                        courseDesc5.text = inputNodes2.contents.substringWithRange(Range<String.Index>(start: advance(inputNodes2.contents.startIndex, nameLength), end: advance(inputNodes2.contents.endIndex, 0)))
                    case 6:
                        cell6.hidden = false
                        course6.text = myStringArr[0] + " - Canvas"
                        courseDesc6.text = inputNodes2.contents.substringWithRange(Range<String.Index>(start: advance(inputNodes2.contents.startIndex, nameLength), end: advance(inputNodes2.contents.endIndex, 0)))
                    case 7:
                        cell7.hidden = false
                        course7.text = myStringArr[0] + " - Canvas"
                        courseDesc7.text = inputNodes2.contents.substringWithRange(Range<String.Index>(start: advance(inputNodes2.contents.startIndex, nameLength), end: advance(inputNodes2.contents.endIndex, 0)))
                    case 8:
                        cell8.hidden = false
                        course8.text = myStringArr[0] + " - Canvas"
                        courseDesc8.text = inputNodes2.contents.substringWithRange(Range<String.Index>(start: advance(inputNodes2.contents.startIndex, nameLength), end: advance(inputNodes2.contents.endIndex, 0)))
                    case 9:
                        cell9.hidden = false
                        course9.text = myStringArr[0] + " - Canvas"
                        courseDesc9.text = inputNodes2.contents.substringWithRange(Range<String.Index>(start: advance(inputNodes2.contents.startIndex, nameLength), end: advance(inputNodes2.contents.endIndex, 0)))
                    case 10:
                        cell10.hidden = false
                        course10.text = myStringArr[0] + " - Canvas"
                        courseDesc10.text = inputNodes2.contents.substringWithRange(Range<String.Index>(start: advance(inputNodes2.contents.startIndex, nameLength), end: advance(inputNodes2.contents.endIndex, 0)))
                    case 11:
                        cell11.hidden = false
                        course11.text = myStringArr[0] + " - Canvas"
                        courseDesc11.text = inputNodes2.contents.substringWithRange(Range<String.Index>(start: advance(inputNodes2.contents.startIndex, nameLength), end: advance(inputNodes2.contents.endIndex, 0)))
                    default:
                        println("ss")
                    }
                }
                i = i + 1
            }
            
            
            
            
            
        }


        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - ENSideMenu Delegate
    func sideMenuWillOpen() {
        println("sideMenuWillOpen")
    }
    
    func sideMenuWillClose() {
        println("sideMenuWillClose")
    }
    // Disable SlideMenu
    func sideMenuShouldOpenSideMenu() -> Bool {
        println("sideMenuShouldOpenSideMenu")
        return false;
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        // Create a variable that you want to send
        let selectedIndex = self.tableView.indexPathForCell(sender as UITableViewCell)
        
        // Create a new variable to store the instance of PlayerTableViewController
        let destinationVC = segue.destinationViewController as assignmentsController
        var tableIndex : Int?
        if let row = selectedIndex?.row {
            destinationVC.programVar = classIDArray[row]
        }
        
    }
    

    
}