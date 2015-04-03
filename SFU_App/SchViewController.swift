//
//  SchViewController.swift
//  SFU_App
//
//  Created by Hugo Cheng on 2015-03-08.
//  Copyright (c) 2015 Hugo Cheng. All rights reserved.
//

import UIKit

/*class courses{
    var department: String = String();
    var section: String = String();
    var number: String = String();
}

class courseLists{
    var name: String = String("NaN");
    var instructor: String = String("NaN");
    var times: String = String("NaN");
    var days: String = String();
    var desc: String = String();
    var location: String = String();
    
}

class classCell: UITableViewCell{
    
    @IBOutlet weak var className: UILabel!
    @IBOutlet weak var classDesc: UILabel!
    @IBOutlet weak var classInstruct: UILabel!
    @IBOutlet weak var classTimes: UILabel!
    @IBOutlet weak var classDays: UILabel!
    @IBOutlet weak var classLocation: UILabel!
    
    
}

var arr: [courses] = []
    
var courseList: [courseLists] = []
*/
class SchViewController: UITableViewController,ENSideMenuDelegate {
    
   //var arr: [courses] = []
    
  // var courseList: [courseLists] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set slide menu control to this controller
        self.sideMenuController()?.sideMenu?.delegate = self;
        
        let currentURLString = "https://sims-prd.sfu.ca/psc/csprd_1/EMPLOYEE/HRMS/c/SA_LEARNER_SERVICES.SSR_SSENRL_SCHD_W.GBL?Page=SSR_SS_WEEK&Action=A&ExactKeys=Y&EMPLID=301179599&TargetFrameName=None&PortalActualURL=https%3a%2f%2fsims-prd.sfu.ca%2fpsc%2fcsprd_1%2fEMPLOYEE%2fHRMS%2fc%2fSA_LEARNER_SERVICES.SSR_SSENRL_SCHD_W.GBL%3fPage%3dSSR_SS_WEEK%26Action%3dA%26ExactKeys%3dY%26EMPLID%3d301179599%26TargetFrameName%3dNone&PortalRegistryName=EMPLOYEE&PortalServletURI=https%3a%2f%2fgo.sfu.ca%2fpsp%2fpaprd_1%2f&PortalURI=https%3a%2f%2fgo.sfu.ca%2fpsc%2fpaprd_1%2f&PortalHostNode=EMPL&NoCrumbs=yes&PortalKeyStruct=yes"
        
        
        let currentURL = NSURL(string: currentURLString)
        var err : NSError?
        
        let currentHTMLString = NSString(contentsOfURL: currentURL!, encoding: NSUTF8StringEncoding, error: nil)
        
        
        var parser = HTMLParser(html : currentHTMLString!, error: &err)
        if err != nil{
            println(err)
            exit(1)
        }
        
        var bodyNode = parser.body
        
        
        
        
        
        
        if let inputNodes = bodyNode?.findChildTagsAttr("span", attrName: "class", attrValue: "SSSTEXTWEEKLY"){
            for node in inputNodes{
                let original = node.contents
                let space = "&nbsp;"
                var final = original.stringByReplacingOccurrencesOfString("&nbsp;", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
                final = final.stringByReplacingOccurrencesOfString("(Section)", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
                final = final.stringByReplacingOccurrencesOfString("- ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
                final = final.stringByReplacingOccurrencesOfString("  ", withString: " ", options: NSStringCompareOptions.LiteralSearch, range: nil)
                
                var classArray = split(final) {$0 == " "}
                var dept = classArray[0].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
                var num = classArray[1].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
                var sec = classArray[2].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
                
                var c1: courses = courses()
                c1.department = dept.lowercaseString
                c1.section = sec.lowercaseString
                c1.number = num.lowercaseString
                
                //println(c1.department + c1.section + c1.number)
                
                if !checkArrayForCourse(c1){
                    arr.append(c1)
                }
                
                
                
            }
        }
        
        //online classes
        if let inputNodes = bodyNode?.findChildTagAttr("span", attrName: "id", attrValue: "NO_MTG_CLASS$0"){
            let original = inputNodes.contents
            var final = original.stringByReplacingOccurrencesOfString("&nbsp; ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            final = final.stringByReplacingOccurrencesOfString(" (Section)", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            final = final.stringByReplacingOccurrencesOfString("- ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            final = final.stringByReplacingOccurrencesOfString("  ", withString: " ", options: NSStringCompareOptions.LiteralSearch, range: nil)
            
            var classArray = split(final) {$0 == " "}
            var dept = classArray[0].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            var num = classArray[1].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            var sec = classArray[2].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            var c1: courses = courses()
            c1.department = dept.lowercaseString
            c1.section = sec.lowercaseString
            c1.number = num.lowercaseString
            //println(c1.department + c1.section + c1.number)
            if !checkArrayForCourse(c1){
                arr.append(c1)
            }
            
        }
        if let inputNodes = bodyNode?.findChildTagAttr("span", attrName: "id", attrValue: "NO_MTG_CLASS$1"){
            let original = inputNodes.contents
            var final = original.stringByReplacingOccurrencesOfString("&nbsp; ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            final = final.stringByReplacingOccurrencesOfString(" (Section)", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            final = final.stringByReplacingOccurrencesOfString("- ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            final = final.stringByReplacingOccurrencesOfString("  ", withString: " ", options: NSStringCompareOptions.LiteralSearch, range: nil)

            var classArray = split(final) {$0 == " "}
            var dept = classArray[0].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            var num = classArray[1].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            var sec = classArray[2].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            var c1: courses = courses()
            c1.department = dept.lowercaseString
            c1.section = sec.lowercaseString
            c1.number = num.lowercaseString
            //println(c1.department + c1.section + c1.number)
            if !checkArrayForCourse(c1){
                arr.append(c1)
            }
        }
        if let inputNodes = bodyNode?.findChildTagAttr("span", attrName: "id", attrValue: "NO_MTG_CLASS$2"){
            let original = inputNodes.contents
            var final = original.stringByReplacingOccurrencesOfString("&nbsp; ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            final = final.stringByReplacingOccurrencesOfString(" (Section)", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            final = final.stringByReplacingOccurrencesOfString("- ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            final = final.stringByReplacingOccurrencesOfString("  ", withString: " ", options: NSStringCompareOptions.LiteralSearch, range: nil)

            var classArray = split(final) {$0 == " "}
            var dept = classArray[0].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            var num = classArray[1].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            var sec = classArray[2].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            var c1: courses = courses()
            c1.department = dept.lowercaseString
            c1.section = sec.lowercaseString
            c1.number = num.lowercaseString
            //println(c1.department + c1.section + c1.number)
            if !checkArrayForCourse(c1){
                arr.append(c1)
            }
        }
        if let inputNodes = bodyNode?.findChildTagAttr("span", attrName: "id", attrValue: "NO_MTG_CLASS$3"){
            let original = inputNodes.contents
            var final = original.stringByReplacingOccurrencesOfString("&nbsp; ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            final = final.stringByReplacingOccurrencesOfString(" (Section)", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            final = final.stringByReplacingOccurrencesOfString("- ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            final = final.stringByReplacingOccurrencesOfString("  ", withString: " ", options: NSStringCompareOptions.LiteralSearch, range: nil)

            var classArray = split(final) {$0 == " "}
            var dept = classArray[0].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            var num = classArray[1].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            var sec = classArray[2].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            var c1: courses = courses()
            c1.department = dept.lowercaseString
            c1.section = sec.lowercaseString
            c1.number = num.lowercaseString
            //println(c1.department + c1.section + c1.number)
            if !checkArrayForCourse(c1){
                arr.append(c1)
            }
        }
        if let inputNodes = bodyNode?.findChildTagAttr("span", attrName: "id", attrValue: "NO_MTG_CLASS$4"){
            let original = inputNodes.contents
            var final = original.stringByReplacingOccurrencesOfString("&nbsp; ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            final = final.stringByReplacingOccurrencesOfString(" (Section)", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            final = final.stringByReplacingOccurrencesOfString("- ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            final = final.stringByReplacingOccurrencesOfString("  ", withString: " ", options: NSStringCompareOptions.LiteralSearch, range: nil)

            var classArray = split(final) {$0 == " "}
            var dept = classArray[0].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            var num = classArray[1].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            var sec = classArray[2].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            var c1: courses = courses()
            c1.department = dept.lowercaseString
            c1.section = sec.lowercaseString
            c1.number = num.lowercaseString
            //println(c1.department + c1.section + c1.number)
            if !checkArrayForCourse(c1){
                arr.append(c1)
            }
        }
        if let inputNodes = bodyNode?.findChildTagAttr("span", attrName: "id", attrValue: "NO_MTG_CLASS$5"){
            let original = inputNodes.contents
            var final = original.stringByReplacingOccurrencesOfString("&nbsp; ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            final = final.stringByReplacingOccurrencesOfString(" (Section)", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            final = final.stringByReplacingOccurrencesOfString("- ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            final = final.stringByReplacingOccurrencesOfString("  ", withString: " ", options: NSStringCompareOptions.LiteralSearch, range: nil)

            var classArray = split(final) {$0 == " "}
            var dept = classArray[0].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            var num = classArray[1].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            var sec = classArray[2].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            var c1: courses = courses()
            c1.department = dept.lowercaseString
            c1.section = sec.lowercaseString
            c1.number = num.lowercaseString
            //println(c1.department + c1.section + c1.number)
            if !checkArrayForCourse(c1){
                arr.append(c1)
            }
        }
        
        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?>=nil
        var error: NSErrorPointer = nil

        
        for course in arr{
            let url = NSURL(string: "http://www.sfu.ca/bin/wcm/course-outlines?year=current&term=current&dept=" + course.department + "&number=" + course.number + "&section=" + course.section)
            let request = NSURLRequest(URL: url!)
            var dataVal: NSData =  NSURLConnection.sendSynchronousRequest(request, returningResponse: response, error:nil)!

                
            //println(NSString(data: dataVal, encoding: NSUTF8StringEncoding))

            let json = JSON(data: dataVal)
            var className = json["info"]["name"].stringValue
            var classInstruct = json["instructor"][0]["name"].stringValue
            var classInstruct1 = json["instructor"][1]["name"].stringValue
            var classInstruct2 = json["instructor"][2]["name"].stringValue
            if classInstruct == ""{
                classInstruct = "N/A"
            }
            if classInstruct1 == ""{
                classInstruct1 = classInstruct
            }
            if classInstruct2 == ""{
                classInstruct2 = classInstruct
            }
            var classStart = json["courseSchedule"][0]["startTime"].stringValue
            var classEnd = json["courseSchedule"][0]["endTime"].stringValue
            var classDays = json["courseSchedule"][0]["days"].stringValue
            var classType = json["courseSchedule"][0]["sectionCode"].stringValue
            var classTitle = json["info"]["title"].stringValue
            var classRN = json["courseSchedule"][0]["roomNumber"].stringValue
            var classRoom = json["courseSchedule"][0]["buildingCode"].stringValue
            
            var classStart1 = json["courseSchedule"][1]["startTime"].stringValue
            var classEnd1 = json["courseSchedule"][1]["endTime"].stringValue
            var classDays1 = json["courseSchedule"][1]["days"].stringValue
            var classType1 = json["courseSchedule"][1]["sectionCode"].stringValue
            var classTitle1 = json["info"]["title"].stringValue
            var classRN1 = json["courseSchedule"][1]["roomNumber"].stringValue
            var classRoom1 = json["courseSchedule"][1]["buildingCode"].stringValue
            
            var classStart2 = json["courseSchedule"][2]["startTime"].stringValue
            var classEnd2 = json["courseSchedule"][2]["endTime"].stringValue
            var classDays2 = json["courseSchedule"][2]["days"].stringValue
            var classType2 = json["courseSchedule"][2]["sectionCode"].stringValue
            var classTitle2 = json["info"]["title"].stringValue
            var classRN2 = json["courseSchedule"][2]["roomNumber"].stringValue
            var classRoom2 = json["courseSchedule"][2]["buildingCode"].stringValue
            
            if classType == "TUT"{
                classType = "Tutorial"
            }
            if classType == "LEC"{
                classType = "Lecture"
            }
            if classType == "SEC"{
                classType = "Distance Ed"
            }
            
            if classType1 == "TUT"{
                classType1 = "Tutorial"
            }
            if classType1 == "LEC"{
                classType1 = "Lecture"
            }
            if classType1 == "SEC"{
                classType1 = "Distance Ed"
            }
            
            if classType2 == "TUT"{
                classType2 = "Tutorial"
            }
            if classType2 == "LEC"{
                classType2 = "Lecture"
            }
            if classType2 == "SEC"{
                classType2 = "Distance Ed"
            }
            println(className + " " + classInstruct)
            var c1: courseLists = courseLists()
            c1.name = className + " - " + classType
            c1.instructor = classInstruct
            c1.desc = classTitle
            if classDays == "" {
                c1.times = "Online"
                c1.days = "Online"
            }else{
                c1.times = classStart + " -  " + classEnd
                c1.days = classDays
            }
            c1.location = classRoom+classRN
            
            if classStart1 != ""{
                var c2: courseLists = courseLists()
                c2.name = className + " - " + classType1
                c2.instructor = classInstruct1
                c2.desc = classTitle1
                if classDays1 == "" {
                    c2.times = "Online"
                    c2.days = "Online"
                }else{
                    c2.times = classStart1 + " -  " + classEnd1
                    c2.days = classDays1
                }
                c2.location = classRoom1+classRN1
                courseList.append(c2)
            }
            
            if classStart2 != ""{
                var c3: courseLists = courseLists()
                c3.name = className + " - " + classType2
                c3.instructor = classInstruct2
                c3.desc = classTitle2
                if classDays2 == "" {
                    c3.times = "Online"
                    c3.days = "Online"
                }else{
                    c3.times = classStart2 + " -  " + classEnd2
                    c3.days = classDays2
                }
                c3.location = classRoom2+classRN2
                courseList.append(c3)
            }
            
            
            
             courseList.append(c1)
        }
        
        for course in courseList{
            println (course.times)
}
        
    }
    
    func checkArrayForCourse(var x : courses) -> Bool{
        for y in arr{
            if x.department == y.department &&
            x.section == y.section &&
            x.number == y.number{
                return true
            }
        }
        return false
        
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
    
    override func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int)
        -> Int {
            return courseList.count
    }
    
    override func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
            let name = courseList[indexPath.row].name
            let instruct = courseList[indexPath.row].instructor
            let times = courseList[indexPath.row].times
            let days = courseList[indexPath.row].days
            let desc = courseList[indexPath.row].desc
            let loc = courseList[indexPath.row].location
            
            let cell = tableView.dequeueReusableCellWithIdentifier("classCellInfo", forIndexPath: indexPath) as UITableViewCell
            
            
            
            (cell as classCell).className.text = name
            (cell as classCell).classTimes.text = times
            (cell as classCell).classInstruct.text = instruct
            (cell as classCell).classDays.text = days
            (cell as classCell).classDesc.text = desc
            (cell as classCell).classLocation.text = loc
            return cell
    }
    
    
    
}
