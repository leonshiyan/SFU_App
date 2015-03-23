//
//  SchViewController.swift
//  SFU_App
//
//  Created by Hugo Cheng on 2015-03-08.
//  Copyright (c) 2015 Hugo Cheng. All rights reserved.
//

import UIKit

class courses{
    var department: String = String();
    var section: String = String();
    var number: String = String();
}

class SchViewController: UIViewController {
    
    @IBOutlet weak var TimeTable: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentURLString = "https://sims-prd.sfu.ca/psc/csprd_1/EMPLOYEE/HRMS/c/SA_LEARNER_SERVICES.SSR_SSENRL_SCHD_W.GBL?Page=SSR_SS_WEEK&Action=A&ExactKeys=Y&EMPLID=301179599&TargetFrameName=None&PortalActualURL=https%3a%2f%2fsims-prd.sfu.ca%2fpsc%2fcsprd_1%2fEMPLOYEE%2fHRMS%2fc%2fSA_LEARNER_SERVICES.SSR_SSENRL_SCHD_W.GBL%3fPage%3dSSR_SS_WEEK%26Action%3dA%26ExactKeys%3dY%26EMPLID%3d301179599%26TargetFrameName%3dNone&PortalRegistryName=EMPLOYEE&PortalServletURI=https%3a%2f%2fgo.sfu.ca%2fpsp%2fpaprd_1%2f&PortalURI=https%3a%2f%2fgo.sfu.ca%2fpsc%2fpaprd_1%2f&PortalHostNode=EMPL&NoCrumbs=yes&PortalKeyStruct=yes"
        
        
        let currentURL = NSURL(string: currentURLString)
        var err : NSError?
        var request = NSURLRequest(URL: currentURL!)
        TimeTable.loadRequest(request)
        
        let currentHTMLString = NSString(contentsOfURL: currentURL!, encoding: NSUTF8StringEncoding, error: nil)
        
        
        var parser = HTMLParser(html : currentHTMLString!, error: &err)
        if err != nil{
            println(err)
            exit(1)
        }
        
        var bodyNode = parser.body
        
        
        
        var arr: [courses] = []
        
        
        if let inputNodes = bodyNode?.findChildTagsAttr("span", attrName: "class", attrValue: "SSSTEXTWEEKLY"){
            for node in inputNodes{
                let original = node.contents
                let space = "&nbsp;"
                var final = original.stringByReplacingOccurrencesOfString("&nbsp;", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
                final = final.stringByReplacingOccurrencesOfString("(Section)", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
                final = final.stringByReplacingOccurrencesOfString("- ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
                final = final.stringByReplacingOccurrencesOfString("  ", withString: " ", options: NSStringCompareOptions.LiteralSearch, range: nil)
                println(final)
                var classArray = split(final) {$0 == " "}
                var dept = classArray[0].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
                var num = classArray[1].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
                var sec = classArray[2].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
                
                var c1: courses = courses()
                c1.department = dept
                c1.section = sec
                c1.number = num
                arr.append(c1)
                
            }
        }
        
        //online classes
        if let inputNodes = bodyNode?.findChildTagAttr("span", attrName: "id", attrValue: "NO_MTG_CLASS$0"){
            let original = inputNodes.contents
            var final = original.stringByReplacingOccurrencesOfString("&nbsp; ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            final = final.stringByReplacingOccurrencesOfString(" (Section)", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            final = final.stringByReplacingOccurrencesOfString("- ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            final = final.stringByReplacingOccurrencesOfString("  ", withString: " ", options: NSStringCompareOptions.LiteralSearch, range: nil)
            println(final)
            var classArray = split(final) {$0 == " "}
            var dept = classArray[0].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            var num = classArray[1].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            var sec = classArray[2].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            
        }
        if let inputNodes = bodyNode?.findChildTagAttr("span", attrName: "id", attrValue: "NO_MTG_CLASS$1"){
            let original = inputNodes.contents
            var final = original.stringByReplacingOccurrencesOfString("&nbsp; ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            final = final.stringByReplacingOccurrencesOfString(" (Section)", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            final = final.stringByReplacingOccurrencesOfString("- ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            final = final.stringByReplacingOccurrencesOfString("  ", withString: " ", options: NSStringCompareOptions.LiteralSearch, range: nil)
            println(final)
            var classArray = split(final) {$0 == " "}
            var dept = classArray[0].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            var num = classArray[1].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            var sec = classArray[2].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        }
        if let inputNodes = bodyNode?.findChildTagAttr("span", attrName: "id", attrValue: "NO_MTG_CLASS$2"){
            let original = inputNodes.contents
            var final = original.stringByReplacingOccurrencesOfString("&nbsp; ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            final = final.stringByReplacingOccurrencesOfString(" (Section)", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            final = final.stringByReplacingOccurrencesOfString("- ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            final = final.stringByReplacingOccurrencesOfString("  ", withString: " ", options: NSStringCompareOptions.LiteralSearch, range: nil)
            println(final)
            var classArray = split(final) {$0 == " "}
            var dept = classArray[0].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            var num = classArray[1].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            var sec = classArray[2].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        }
        if let inputNodes = bodyNode?.findChildTagAttr("span", attrName: "id", attrValue: "NO_MTG_CLASS$3"){
            let original = inputNodes.contents
            var final = original.stringByReplacingOccurrencesOfString("&nbsp; ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            final = final.stringByReplacingOccurrencesOfString(" (Section)", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            final = final.stringByReplacingOccurrencesOfString("- ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            final = final.stringByReplacingOccurrencesOfString("  ", withString: " ", options: NSStringCompareOptions.LiteralSearch, range: nil)
            println(final)
            var classArray = split(final) {$0 == " "}
            var dept = classArray[0].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            var num = classArray[1].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            var sec = classArray[2].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        }
        if let inputNodes = bodyNode?.findChildTagAttr("span", attrName: "id", attrValue: "NO_MTG_CLASS$4"){
            let original = inputNodes.contents
            var final = original.stringByReplacingOccurrencesOfString("&nbsp; ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            final = final.stringByReplacingOccurrencesOfString(" (Section)", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            final = final.stringByReplacingOccurrencesOfString("- ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            final = final.stringByReplacingOccurrencesOfString("  ", withString: " ", options: NSStringCompareOptions.LiteralSearch, range: nil)
            println(final)
            var classArray = split(final) {$0 == " "}
            var dept = classArray[0].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            var num = classArray[1].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            var sec = classArray[2].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        }
        if let inputNodes = bodyNode?.findChildTagAttr("span", attrName: "id", attrValue: "NO_MTG_CLASS$5"){
            let original = inputNodes.contents
            var final = original.stringByReplacingOccurrencesOfString("&nbsp; ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            final = final.stringByReplacingOccurrencesOfString(" (Section)", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            final = final.stringByReplacingOccurrencesOfString("- ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            final = final.stringByReplacingOccurrencesOfString("  ", withString: " ", options: NSStringCompareOptions.LiteralSearch, range: nil)
            println(final)
            var classArray = split(final) {$0 == " "}
            var dept = classArray[0].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            var num = classArray[1].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            var sec = classArray[2].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}
