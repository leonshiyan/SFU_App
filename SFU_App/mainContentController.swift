//
//  mainContentController.swift
//  SFU_App
//
//  Created by Jerrod Seger on 2015-03-24.
//  Copyright (c) 2015 Hugo Cheng. All rights reserved.
//

import Foundation
import UIKit

class mainContentController: UITableViewController, ENSideMenuDelegate {
    
    @IBOutlet weak var subView1: UIView!
    @IBOutlet weak var subView2: UIView!
    @IBOutlet weak var subView3: UIView!
    
    
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var humid: UILabel!
    @IBOutlet weak var weatherDesc: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var canvasView: UIWebView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
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
        
        
        var urlca = NSURL (string:"https://canvas.sfu.ca")
        // Load Url into webview
        var requestcamn = NSURLRequest(URL: urlca!)
        canvasView.loadRequest(requestcamn)

        
        
        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?>=nil
        var error: NSErrorPointer = nil
        
        let url = NSURL(string: "http://api.openweathermap.org/data/2.5/weather?q=Burnaby,CA&units=metric")
        let request = NSURLRequest(URL: url!)
        var dataVal: NSData =  NSURLConnection.sendSynchronousRequest(request, returningResponse: response, error:nil)!
            
        let json = JSON(data: dataVal)
        var temperature = json["main"]["temp"].stringValue
        var humidity = json["main"]["humidity"].stringValue
        var description = json["weather"][0]["description"].stringValue
        var weatherid = json["weather"][0]["id"].stringValue.toInt()
        let substringindex = 3
        temperature = temperature.substringToIndex(advance(temperature.startIndex,substringindex))
        temp.text = temperature + "C"
        humid.text = humidity + "%"
        weatherDesc.text = description.capitalizedString
        
        let moon = UIImage(named: "moon.png") as UIImage!
        let thunder = UIImage(named: "thunder.png") as UIImage!
        let cloudy = UIImage(named: "cloudy.png") as UIImage!
        let suncloud = UIImage(named: "suncloud.png") as UIImage!
        let snow = UIImage(named: "snow.png") as UIImage!
        let rain = UIImage(named: "rain.png") as UIImage!
        let sunny = UIImage(named: "sunny.png") as UIImage!
        
        if weatherid >= 600 && weatherid <= 622{
            weatherImage.image = snow
        }else
        if weatherid >= 802 && weatherid <= 804{
            weatherImage.image = cloudy
        }else
        if weatherid == 801{
            weatherImage.image = suncloud
        }else
        if weatherid == 80{
            weatherImage.image = sunny
        }else
        if weatherid >= 200 && weatherid <= 232{
            weatherImage.image = thunder
        }else
        if weatherid >= 300 && weatherid <= 321{
            weatherImage.image = rain
        }else
        if weatherid >= 500 && weatherid <= 531{
            weatherImage.image = rain
        }else{
            weatherImage.image = cloudy
        }
        
        
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
        
        

        

    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?>=nil
        var error: NSErrorPointer = nil
        
        let url2 = NSURL(string: "https://canvas.sfu.ca/api/v1/users/self/todo")
        let canvasRequest = NSURLRequest(URL: url2!)
        var dataVal2: NSData =  NSURLConnection.sendSynchronousRequest(canvasRequest, returningResponse: response, error:nil)!
        var theString:NSString = NSString(data: dataVal2, encoding: NSASCIIStringEncoding)!
        println(theString)
        theString = theString.substringFromIndex(9)
        
        let jsonCan = JSON(data: dataVal2)
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

    
}