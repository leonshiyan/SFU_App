//
//  LoginViewController.swift
//  SFUAppButtons
//
//  Created by abc on 2015-02-28.
//  Copyright (c) 2015 Jerrod Seger. All rights reserved.
//

import UIKit
import Foundation
// View controller responsible for SFU authentication for both SIS system and CAS, serves to maintain login state for canvas, connect and SIS//
var USERID = ""
var validbit = 0;
let defaults = NSUserDefaults.standardUserDefaults()
class LoginController: UIViewController,UIWebViewDelegate,ENSideMenuDelegate,UITextFieldDelegate {
    // Reference to login and password fields//
    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var password: UITextField!
    
    // Login and logout button references //
    @IBOutlet weak var logoutButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    // Status message references//
    @IBOutlet weak var errorLabel: UILabel!
    
    // hidden webview references//
    @IBOutlet weak var LoginPage: UIWebView!
    
    @IBOutlet weak var guestLogin: UIButton!
    @IBOutlet weak var SISview: UIWebView!
    
    @IBOutlet weak var loginLoader: UIActivityIndicatorView!
    //var canLogin:Bool?
    var username:String?
    var Bounce: Bool? = true;
    
    var logoutBool : Bool? = false;
    
    var SISlogin:Bool? = false;
    var CASlogin:Bool? = false;
    
    var loginEventFired:Bool? = false;
    
    var pass:String?
    
    var comingFromMenu:Bool? = false;
    
    func setComingFromMenu(var x:Bool){
        comingFromMenu = x;
    }
    
    // Check internet function
    func outputError() {
        if(Reachability.isConnectedToNetwork() == true){
            println("Internet connection OK")
            return
        }
        else{
            println("Internet connection FAILED")
            let retryHandler = { (action:UIAlertAction!) -> Void in // Handler: refreshes view so that autologin can work
                return self.viewDidLoad()
            }
            let gLogHandler = { (action:UIAlertAction!) -> Void in // Handler: goes to guest log in
                return self.guestLogin.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
            }
            let alertController = UIAlertController(title: "Error", message: "No internet connection available", preferredStyle: .Alert)
            let retryAction = UIAlertAction(title: "Retry", style: .Default, handler: retryHandler)
            let gLogAction = UIAlertAction(title: "Guest Login", style: .Default, handler: gLogHandler)
            alertController.addAction(retryAction)
            alertController.addAction(gLogAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Delegates for textfield
        login.delegate = self
        password.delegate = self
        
        // Check for internet connection
        self.outputError()
        
        if(comingFromMenu == true){
            guestLogin.setTitle("Main Menu", forState: UIControlState.Normal)
        }
        
        // Set slide menu control to this controller
        self.sideMenuController()?.sideMenu?.delegate = self;
        
        // Establish URL to SIS login page and cas login page//
        var url = NSURL (string:"https://cas.sfu.ca/cas/login")
        
        
        var sisurl = NSURL(string:"https://go.sfu.ca/psp/paprd/EMPLOYEE/h/?tab=SFU_STUDENT_CENTER")
        
        var SISLog = NSURLRequest(URL: sisurl!)
        var LoginRequest = NSURLRequest(URL: url!)
        
        //UIwebdelegate references to handle webview loading events for parsing //
        LoginPage.delegate=self
        SISview.delegate=self
        
        //Intiate the webview by loading the URl//
        LoginPage.loadRequest(LoginRequest)
        SISview.loadRequest(SISLog)
        
        // HTML string of login page , used for accessing authentication results//
        var result : NSString! = LoginPage.stringByEvaluatingJavaScriptFromString("document.body.innerHTML")
        // sucessful login attempts returne the page containg the message "succesfully logged into", attempt to search html for this tag.

        
        if result.containsString("successfully logged into"){
            // Events that trigger after successful login, fade out log in button, fade out password//
            login.enabled = false
            password.enabled = false
            loginButton.enabled = false
            logoutButton.enabled = true
            loginButton.alpha = 0.1
            logoutButton.alpha = 1
            Bounce = true;
            validbit = 1;
          
           
        }else{
            login.enabled = true
            password.enabled = true
            loginButton.enabled = true
            logoutButton.enabled = false
            loginButton.alpha = 1
            logoutButton.alpha = 0.1
            Bounce = false;
        }
        
        loginLoader.startAnimating()
        loginLoader.hidesWhenStopped = true
        println(defaults.stringForKey(userNameKeyConstant))
        if(defaults.stringForKey(userNameKeyConstant) != nil){
            login.text = defaults.stringForKey(userNameKeyConstant)
            password.text = defaults.stringForKey(passwordKeyConstant)
        }
        
        
        
        
    }
    
    // Set textfield so that after pressing Next in login textfield, it will move to password textfield
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if(login.isFirstResponder()){
            login.resignFirstResponder()
            password.becomeFirstResponder()
        }
        
        else if(password.isFirstResponder()){
            password.resignFirstResponder()
            loginAction(loginButton)
        }
        return true
    }
    
    // Do any additional setup after loading the view.
    
    
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
    // Disabled SlideMenu
    func sideMenuShouldOpenSideMenu() -> Bool {
        println("sideMenuShouldOpenSideMenu")
        return false;
    }
    
    // Delegate function that gets called after webview finishes loading resource, handle Javascript for login, and result parsing//
    func webViewDidFinishLoad(webView: UIWebView) {
        if(webView == self.SISview){
            println("SIS LOADED")
            var result2 : NSString! = SISview.stringByEvaluatingJavaScriptFromString("document.body.innerHTML")
            // sucessful login attempts returne the page containg the message "succesfully logged into", attempt to search html for this tag.
            
            if login.text != nil && password.text != nil{
                
                SISview.stringByEvaluatingJavaScriptFromString("document.getElementById('user').value='\(login.text)'")
                SISview.stringByEvaluatingJavaScriptFromString("document.getElementById('pwd').value='\(password.text)'")
                SISview.stringByEvaluatingJavaScriptFromString("document.getElementsByName('Submit')[0].click()")
                
            }
            SISlogin = true
        }
        if(webView == self.LoginPage){
            CASlogin = true
        }
        
        // html parse for authentication status
        
        var result : NSString! = LoginPage.stringByEvaluatingJavaScriptFromString("document.body.innerHTML")
        
        
        if result.containsString("credentials you provided"){
            errorLabel.text = "Invalid Username/Password."
            

           login.enabled = true
           password.enabled = true
           loginButton.enabled = true
           logoutButton.enabled = false
           loginButton.alpha = 1
           logoutButton.alpha = 0.1
             Bounce = true;
            validbit = 0
        }else if result.containsString("successfully logged out"){
            errorLabel.text=""

            login.enabled = true
            password.enabled = true
            loginButton.enabled = true
            logoutButton.enabled = false
            loginButton.alpha = 1
            logoutButton.alpha = 0.1
            var url = NSURL (string:"https://cas.sfu.ca/cas/login")
            var LoginRequest = NSURLRequest(URL: url!)
            LoginPage.delegate=self
            
            LoginPage.loadRequest(LoginRequest)
            //defaults.setObject(login.text, forKey: userNameKeyConstant)
            //defaults.setObject(password.text, forKey: passwordKeyConstant)
            
        }else if result.containsString("successfully logged in"){
            errorLabel.text=""

            login.enabled = false
            password.enabled = false
            loginButton.enabled = false
            logoutButton.enabled = true
            loginButton.alpha = 0.1
            logoutButton.alpha = 1
            Bounce = true;
            validbit = 1 ;
            
            defaults.setObject(login.text, forKey: userNameKeyConstant)
            println(defaults.stringForKey(userNameKeyConstant))
            defaults.setObject(password.text, forKey: passwordKeyConstant)
           
            
            
            
            var request = NSMutableURLRequest(URL: NSURL( string: "http://cmpt275team1.hostoi.com/newuser.php")!)
            
            var session = NSURLSession.sharedSession()
            request.HTTPMethod="POST"
            request.addValue("application/x-www-form-urlencoded",forHTTPHeaderField: "Content-Type")
            var body = "USERID=\(login.text)"
            request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding)
            
            var DataTask = session.dataTaskWithRequest(request) {
                data, response, error in
                
                if(error != nil){
                    println("error=\(error)")
                    return;
                }
                var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
              
            }
            
            DataTask.resume()
            
            if(loginEventFired == false && comingFromMenu == false){
                loginEventFired = true
                performSegueWithIdentifier("goToMain", sender: self)
            }
            
            
        }else{
            errorLabel.text=""
            
            login.enabled = true
            password.enabled = true
            loginButton.enabled = true
            logoutButton.enabled = false
            loginButton.alpha = 1
            logoutButton.alpha = 0.1
            
        }
        
        if(defaults.stringForKey(userNameKeyConstant) != nil && logoutBool == false && CASlogin == true && SISlogin == true && comingFromMenu == false){
            loginButton.sendActionsForControlEvents(.TouchUpInside)
            
        }
        if(CASlogin == true && SISlogin == true){
            loginLoader.stopAnimating()
            
        }
        
    }
    // Log out button Function
    @IBAction func logoutAction(sender: AnyObject) {
        var url = NSURL (string:"https://cas.sfu.ca/cas/logout")
        var LoginRequest = NSURLRequest(URL: url!)
        LoginPage.delegate=self
        
        LoginPage.loadRequest(LoginRequest)
        
        var SISurl = NSURL(string:"https://go.sfu.ca/psp/paprd/EMPLOYEE/EMPL/?cmd=logout")
        var SISLogoutRequest = NSURLRequest(URL: SISurl!)
        
        SISview.delegate = self
        SISview.loadRequest(SISLogoutRequest)

        login.enabled = true
        password.enabled = true
        loginButton.enabled = true
        logoutButton.enabled = false
        loginButton.alpha = 1
        logoutButton.alpha = 0.1
        
        login.text = ""
        password.text = ""
        logoutBool = true;
       
        
    }
    
    let userNameKeyConstant = "usernameKey"
    let passwordKeyConstant = "passwordLey"
    
    //let defaults = NSUserDefaults.standardUserDefaults()
    // Login button Function//
    @IBAction func loginAction(sender: AnyObject) {
        
        if SISlogin == true && CASlogin == true{
            loginLoader.startAnimating()
            //set username
            
            pass=password.text
            username=login.text
          
            
           
            
            
            
            
            if(password.text.isEmpty || login.text.isEmpty){
                errorLabel.text="Require Username/Password"
                Bounce = false;
            }else{
                errorLabel.text=""
               
                
            
                
                }
            
                //CANVAS: Javascript to fill in login fields wwith user input and submit web form //
            LoginPage.stringByEvaluatingJavaScriptFromString("document.getElementById('username').value='\(login.text)'")
            LoginPage.stringByEvaluatingJavaScriptFromString("document.getElementById('password').value='\(password.text)'")
            LoginPage.stringByEvaluatingJavaScriptFromString("document.getElementById('fm1').submit()")
                
                //SIS: Javascript to fill in login fields with user input and submit webform//
            SISview.stringByEvaluatingJavaScriptFromString("document.getElementById('user').value='\(login.text)'")
            SISview.stringByEvaluatingJavaScriptFromString("document.getElementById('pwd').value='\(password.text)'")
            SISview.stringByEvaluatingJavaScriptFromString("document.getElementsByName('Submit')[0].click()")
                
                logoutBool = false;
                
            
            }
        }
        
        
        
    
    
    

}
