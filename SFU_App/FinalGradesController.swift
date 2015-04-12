//
//  GradesViewController.swift
//  SFU_App
//
//  Created by Hugo Cheng on 2015-03-05.
//  Copyright (c) 2015 Hugo Cheng. All rights reserved.
//

import UIKit

class FinalGradeController: UITableViewController,ENSideMenuDelegate {
    
    @IBOutlet weak var course0: UILabel!
    @IBOutlet weak var course1: UILabel!
    @IBOutlet weak var course2: UILabel!
    @IBOutlet weak var course3: UILabel!
    @IBOutlet weak var course4: UILabel!
    @IBOutlet weak var course5: UILabel!
    @IBOutlet weak var course6: UILabel!
    
    @IBOutlet weak var courseDesc1: UILabel!
    @IBOutlet weak var courseDesc2: UILabel!
    @IBOutlet weak var courseDesc3: UILabel!
    @IBOutlet weak var courseDesc4: UILabel!
    @IBOutlet weak var courseDesc5: UILabel!
    @IBOutlet weak var courseDesc6: UILabel!


    
    @IBOutlet weak var gpa0: UILabel!
    @IBOutlet weak var gpa1: UILabel!
    @IBOutlet weak var gpa2: UILabel!
    @IBOutlet weak var gpa3: UILabel!
    @IBOutlet weak var gpa4: UILabel!
    @IBOutlet weak var gpa5: UILabel!
    @IBOutlet weak var gpa6: UILabel!
    
    // Create a reachability object
    let reachability = Reachability.reachabilityForInternetConnection()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Prepare notifier which constantly observes for connection in the background
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityChanged:", name: ReachabilityChangedNotification, object: reachability)
        reachability.startNotifier()
        
        //Set slide menu control to this controller
        self.sideMenuController()?.sideMenu?.delegate = self;
        
        let currentURLString = "https://sims-prd.sfu.ca/psc/csprd/EMPLOYEE/HRMS/c/SA_LEARNER_SERVICES.SSR_SSENRL_GRADE.GBL?"
        
        
        let currentURL = NSURL(string: currentURLString)
        var err : NSError?
        
        
        let currentHTMLString = NSString(contentsOfURL: currentURL!, encoding: NSUTF8StringEncoding, error: nil)
        
        
        var parser = HTMLParser(html : currentHTMLString!, error: &err)
        if err != nil{
            println(err)
            exit(1)
        }
        
        
        gpa0.text = ""

        
        gpa0.text = ""
        gpa1.text = ""
        gpa2.text = ""
        gpa3.text = ""
        gpa4.text = ""
        gpa5.text = ""
        gpa6.text = ""
        
        courseDesc1.text = ""
        courseDesc2.text = ""
        courseDesc3.text = ""
        courseDesc4.text = ""
        courseDesc5.text = ""
        courseDesc6.text = ""
        
        course0.text = "Current GPA:"
        course1.text = ""
        course2.text = ""
        course3.text = ""
        course4.text = ""
        course5.text = ""
        course6.text = ""
        
        
        var bodyNode = parser.body
        
        if let inputNodes = bodyNode?.findChildTagAttr("a", attrName: "id", attrValue: "CLS_LINK$0"){
            println(inputNodes.contents)
            self.course1.text = inputNodes.contents
            
        }
        if let inputNodes = bodyNode?.findChildTagAttr("span", attrName: "id", attrValue: "CLASS_TBL_VW_DESCR$0"){
            println(inputNodes.contents)
            self.courseDesc1.text = inputNodes.contents
            
        }
        if let inputNodes = bodyNode?.findChildTagAttr("span", attrName: "id", attrValue: "STDNT_ENRL_SSV1_CRSE_GRADE_OFF$0"){
            println(inputNodes.contents)
            self.gpa1.text = inputNodes.contents
            if (inputNodes.contents == "&nbsp;"){
                gpa1.text = "N/A"
            }
        }
        
        
        
        if let inputNodes = bodyNode?.findChildTagAttr("a", attrName: "id", attrValue: "CLS_LINK$1"){
            println(inputNodes.contents)
            course2.text = inputNodes.contents
        }
        if let inputNodes = bodyNode?.findChildTagAttr("span", attrName: "id", attrValue: "CLASS_TBL_VW_DESCR$1"){
            println(inputNodes.contents)
            self.courseDesc2.text = inputNodes.contents
            
        }
        if let inputNodes = bodyNode?.findChildTagAttr("span", attrName: "id", attrValue: "STDNT_ENRL_SSV1_CRSE_GRADE_OFF$1"){
            println(inputNodes.contents)
            self.gpa2.text = inputNodes.contents
            if (inputNodes.contents == "&nbsp;"){
                gpa2.text = "N/A"
            }
        }
        
        if let inputNodes = bodyNode?.findChildTagAttr("a", attrName: "id", attrValue: "CLS_LINK$2"){
            println(inputNodes.contents)
            course3.text = inputNodes.contents
        }
        if let inputNodes = bodyNode?.findChildTagAttr("span", attrName: "id", attrValue: "CLASS_TBL_VW_DESCR$2"){
            println(inputNodes.contents)
            self.courseDesc3.text = inputNodes.contents
            
        }
        if let inputNodes = bodyNode?.findChildTagAttr("span", attrName: "id", attrValue: "STDNT_ENRL_SSV1_CRSE_GRADE_OFF$2"){
            println(inputNodes.contents)
            self.gpa3.text = inputNodes.contents
            if (inputNodes.contents == "&nbsp;"){
                gpa3.text = "N/A"
            }
        }
        
        if let inputNodes = bodyNode?.findChildTagAttr("a", attrName: "id", attrValue: "CLS_LINK$3"){
            println(inputNodes.contents)
            course4.text = inputNodes.contents
        }
        if let inputNodes = bodyNode?.findChildTagAttr("span", attrName: "id", attrValue: "CLASS_TBL_VW_DESCR$3"){
            println(inputNodes.contents)
            self.courseDesc4.text = inputNodes.contents
            
        }
        if let inputNodes = bodyNode?.findChildTagAttr("span", attrName: "id", attrValue: "STDNT_ENRL_SSV1_CRSE_GRADE_OFF$3"){
            println(inputNodes.contents)
            self.gpa4.text = inputNodes.contents
            if (inputNodes.contents == "&nbsp;"){
                gpa4.text = "N/A"
            }
        }
        
        if let inputNodes = bodyNode?.findChildTagAttr("a", attrName: "id", attrValue: "CLS_LINK$4"){
            println(inputNodes.contents)
            course5.text = inputNodes.contents
        }
        if let inputNodes = bodyNode?.findChildTagAttr("span", attrName: "id", attrValue: "CLASS_TBL_VW_DESCR$4"){
            println(inputNodes.contents)
            self.courseDesc5.text = inputNodes.contents
            
        }
        if let inputNodes = bodyNode?.findChildTagAttr("span", attrName: "id", attrValue: "STDNT_ENRL_SSV1_CRSE_GRADE_OFF$4"){
            println(inputNodes.contents)
            self.gpa5.text = inputNodes.contents
            if (inputNodes.contents == "&nbsp;"){
                gpa5.text = "N/A"
            }
        }
        
        if let inputNodes = bodyNode?.findChildTagAttr("a", attrName: "id", attrValue: "CLS_LINK$5"){
            println(inputNodes.contents)
            course6.text = inputNodes.contents
        }
        if let inputNodes = bodyNode?.findChildTagAttr("span", attrName: "id", attrValue: "CLASS_TBL_VW_DESCR$5"){
            println(inputNodes.contents)
            self.courseDesc6.text = inputNodes.contents
            
        }
        if let inputNodes = bodyNode?.findChildTagAttr("span", attrName: "id", attrValue: "STDNT_ENRL_SSV1_CRSE_GRADE_OFF$5"){
            println(inputNodes.contents)
            self.gpa6.text = inputNodes.contents
            if (inputNodes.contents == "&nbsp;"){
                gpa6.text = "N/A"
            }
        }
        
        
        if let inputNodes = bodyNode?.findChildTagAttr("span", attrName: "id", attrValue: "STATS_CUMS$14"){
            println(inputNodes.contents)
            //gpa0.text = inputNodes.contents
        }
        
    }
    
    // Deinitializes notifier
    deinit {
        reachability.stopNotifier()
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
