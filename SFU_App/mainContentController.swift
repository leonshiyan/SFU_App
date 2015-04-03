//
//  mainContentController.swift
//  SFU_App
//
//  Created by Jerrod Seger on 2015-03-24.
//  Copyright (c) 2015 Hugo Cheng. All rights reserved.
//

import Foundation
import UIKit

class courses{
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


class mainContentController: UITableViewController, ENSideMenuDelegate {
    
    @IBOutlet weak var subView1: UIView!
    @IBOutlet weak var subView2: UIView!
    @IBOutlet weak var subView3: UIView!
    
    @IBOutlet weak var instagramImage: UIImageView!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        
        
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
        
    

       
        
        
        
        println("TEST")
        var randomImage: UInt32 = (arc4random_uniform(12) + 1)
        var rdnImage = UIImage(named: "1.png") as UIImage!
        if randomImage == 1{
            rdnImage = UIImage(named: "1.png") as UIImage!
        }else if randomImage == 2{
            rdnImage = UIImage(named: "2.png") as UIImage!
        }else if randomImage == 3{
            rdnImage = UIImage(named: "3.png") as UIImage!
        }else if randomImage == 4{
            rdnImage = UIImage(named: "4.png") as UIImage!
        }else if randomImage == 5{
            rdnImage = UIImage(named: "5.png") as UIImage!
        }else if randomImage == 6{
            rdnImage = UIImage(named: "6.png") as UIImage!
        }else if randomImage == 7{
            rdnImage = UIImage(named: "7.png") as UIImage!
        }else if randomImage == 8{
            rdnImage = UIImage(named: "8.png") as UIImage!
        }else if randomImage == 9{
            rdnImage = UIImage(named: "9.png") as UIImage!
        }else if randomImage == 10{
            rdnImage = UIImage(named: "10.png") as UIImage!
        }else if randomImage == 11{
            rdnImage = UIImage(named: "11.png") as UIImage!
        }
        
        instagramImage.image = rdnImage
        
        self.sideMenuController()?.sideMenu?.delegate = self;
        
        let shadowPath = UIBezierPath(rect: subView1.bounds)
        subView1.layer.masksToBounds = false
        subView1.layer.shadowColor = UIColor.blackColor().CGColor
        subView1.layer.shadowOffset = CGSizeMake(0, 0.5)
        subView1.layer.shadowOpacity = 0.1
        subView1.layer.shadowPath = shadowPath.CGPath
        
        let shadowPath2 = UIBezierPath(rect: subView2.bounds)
        subView2.layer.masksToBounds = false
        subView2.layer.shadowColor = UIColor.blackColor().CGColor
        subView2.layer.shadowOffset = CGSizeMake(0, 0.5)
        subView2.layer.shadowOpacity = 0.1
        subView2.layer.shadowPath = shadowPath2.CGPath
        
        let shadowPath3 = UIBezierPath(rect: subView3.bounds)
        subView3.layer.masksToBounds = false
        subView3.layer.shadowColor = UIColor.blackColor().CGColor
        subView3.layer.shadowOffset = CGSizeMake(0, 0.5)
        subView3.layer.shadowOpacity = 0.1
        subView3.layer.shadowPath = shadowPath3.CGPath
        
        
        
        
        var response2: AutoreleasingUnsafeMutablePointer<NSURLResponse?>=nil
        var error2: NSErrorPointer = nil
        
        let url = NSURL(string: "http://api.openweathermap.org/data/2.5/weather?q=Burnaby,CA&units=metric")
        let request = NSURLRequest(URL: url!)
        var dataVal: NSData =  NSURLConnection.sendSynchronousRequest(request, returningResponse: response, error:nil)!
            
        let json = JSON(data: dataVal)
        var humidity = "NaN"
        var description = "NaN"
        var weatherid = "NaN".toInt()
        let temperature = json["main"]["temp"].stringValue
        humidity = json["main"]["humidity"].stringValue
        description = json["weather"][0]["description"].stringValue
        weatherid = json["weather"][0]["id"].stringValue.toInt()
        var index2 = temperature.rangeOfString(".", options: .BackwardsSearch)?.startIndex
        if(temperature.isEmpty){
            let temperatureStr = " null"
        }else{
            let temperatureStr = temperature.substringToIndex(index2!)
          temp.text = temperatureStr + "C"}
        
        //humid.text = humidity + "%"
        //weatherDesc.text = description.capitalizedString
        
        let moon = UIImage(named: "moon.png") as UIImage!
        let thunder = UIImage(named: "thunder.png") as UIImage!
        let cloudy = UIImage(named: "cloudy.png") as UIImage!
        let suncloud = UIImage(named: "suncloud.png") as UIImage!
        let snow = UIImage(named: "snow.png") as UIImage!
        let rain = UIImage(named: "rain.png") as UIImage!
        let sunny = UIImage(named: "sunny.png") as UIImage!
        
        if weatherid >= 600 && weatherid <= 622{
            weatherIcon.image = snow
        }else
        if weatherid >= 802 && weatherid <= 804{
            weatherIcon.image = cloudy
        }else
        if weatherid == 801{
            weatherIcon.image = suncloud
        }else
        if weatherid == 80{
            weatherIcon.image = sunny
        }else
        if weatherid >= 200 && weatherid <= 232{
            weatherIcon.image = thunder
        }else
        if weatherid >= 300 && weatherid <= 321{
            weatherIcon.image = rain
        }else
        if weatherid >= 500 && weatherid <= 531{
            weatherIcon.image = rain
        }else{
            weatherIcon.image = cloudy
        }
        

        

        
     println(CreateMatrix())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        println("MEM")
    }
    


    
    @IBAction func toggleSideMenu(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    // MARK: - ENSideMenu Delegate
    func sideMenuWillOpen() {
        println("sideMenuWillOpen")
    }
    
    func sideMenuWillClose() {
        println("sideMenuWillClose")
    }
    
    func sideMenuShouldOpenSideMenu() -> Bool {
        println("sideMenuShouldOpenSideMenu")
        return true;
    }

    //parses schedule after login 
    
    
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

    
    
    
    
    
    
    
    
    
    
    
    
    
}