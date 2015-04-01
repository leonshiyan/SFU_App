//
//  campusInfoController.swift
//  SFU_App
//
//  Created by Jerrod Seger on 2015-03-31.
//  Copyright (c) 2015 Hugo Cheng. All rights reserved.
//

import Foundation
import UIKit

class campusInfoController: UITableViewController{
    
    @IBOutlet weak var cell1: UIView!
    @IBOutlet weak var cell2: UIView!
    
    
    //burnaby
    @IBOutlet weak var bOpen: UILabel!
    @IBOutlet weak var bRoads: UILabel!
    @IBOutlet weak var bClasses: UILabel!
    @IBOutlet weak var bBuses: UILabel!

    //surrey
    @IBOutlet weak var sOpen: UILabel!
    @IBOutlet weak var sClasses: UILabel!
 
    //vancouver
    @IBOutlet weak var vOpen: UILabel!
    @IBOutlet weak var vClasses: UILabel!
    
    @IBOutlet weak var weatherWebView: UIWebView!
    
    @IBAction func bCall(sender: AnyObject) {
        let phone = "tel://7787824500";
        let url:NSURL = NSURL(string:phone)!;
        UIApplication.sharedApplication().openURL(url);

    }
    
    @IBAction func sCall(sender: AnyObject) {
        let phone = "tel://7787827511";
        let url:NSURL = NSURL(string:phone)!;
        UIApplication.sharedApplication().openURL(url);

    }
    
    @IBAction func vCall(sender: AnyObject) {
        let phone = "tel://7787825252";
        let url:NSURL = NSURL(string:phone)!;
        UIApplication.sharedApplication().openURL(url);

    }
    override func viewDidLoad(){
        super.viewDidLoad()
        
        //URL to sfu canvas
        var url = NSURL (string:"http://cgi.sfu.ca/~netops/cgi-bin/image.php?cam=mallcam&nocache=0.6927982002962381&update=2000&timeout=1800000&offset=4")
        // Load Url into webview
        var request = NSURLRequest(URL: url!)
        weatherWebView.loadRequest(request)
        //weatherWebView.scrollView.zoomScale = 4
        
        let shadowPath = UIBezierPath(rect: cell1.bounds)
        cell1.layer.masksToBounds = false
        cell1.layer.shadowColor = UIColor.blackColor().CGColor
        cell1.layer.shadowOffset = CGSizeMake(0, 0.5)
        cell1.layer.shadowOpacity = 0.1
        cell1.layer.shadowPath = shadowPath.CGPath
        
        let shadowPath2 = UIBezierPath(rect: cell2.bounds)
        cell2.layer.masksToBounds = false
        cell2.layer.shadowColor = UIColor.blackColor().CGColor
        cell2.layer.shadowOffset = CGSizeMake(0, 0.5)
        cell2.layer.shadowOpacity = 0.1
        cell2.layer.shadowPath = shadowPath2.CGPath
        
        let currentURLString = "http://www.sfu.ca/security/sfuroadconditions/"
        
        
        let currentURL = NSURL(string: currentURLString)
        var err : NSError?
        
        
        let currentHTMLString = NSString(contentsOfURL: currentURL!, encoding: NSUTF8StringEncoding, error: nil)
        
        
        var parser = HTMLParser(html : currentHTMLString!, error: &err)
        if err != nil{
            println(err)
            exit(1)
        }
        
        var bodyNode = parser.body
        
        if let inputNode = bodyNode?.findChildTagAttr("div", attrName: "class", attrValue: "campus-status normal"){
            if let inputNode2 = inputNode.findChildTag("h1"){
                bOpen.text = inputNode2.contents
            }
        }
        
        if let inputNode = bodyNode?.findChildTagAttr("div", attrName: "class", attrValue: "status-title first"){
            if let inputNode2 = inputNode.findChildTag("span"){
                bRoads.text = inputNode2.contents.capitalizedString
            }
        }
        
        if let inputNodes = bodyNode?.findChildTagsAttr("div", attrName: "class", attrValue: "campus-status normal other-campuses"){
            if let openNode = inputNodes[0].findChildTag("h3"){
                sOpen.text = openNode.contents
            }
            if let openNode = inputNodes[1].findChildTag("h3"){
                vOpen.text = openNode.contents
            }

        }
        
        if let inputNodes = bodyNode?.findChildTagsAttr("span", attrName: "class", attrValue: "normal"){
            bClasses.text = inputNodes[1].contents
            bBuses.text = inputNodes[2].contents
            
        }
        
        if let inputNodes = bodyNode?.findChildTagsAttr("span", attrName: "class", attrValue: "other-campus-classes-exams normal"){
            if let openNode = inputNodes[0].findChildTag("strong"){
                sClasses.text = openNode.contents
            }
            if let openNode = inputNodes[1].findChildTag("strong"){
                vClasses.text = openNode.contents
            }
            
        }
        
        
        
    }
    
}