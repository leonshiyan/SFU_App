//
//  QRViewController.swift
//  SFU_App
//
//  Created by Hugo Cheng on 2015-03-20.
//  Copyright (c) 2015 Hugo Cheng. All rights reserved.
//


import UIKit
import AVFoundation




class QRViewController: UIViewController , AVCaptureMetadataOutputObjectsDelegate {

    @IBOutlet weak var pointfield: UITextField!
    
    @IBOutlet weak var TOTAL: UILabel!
    
    var strData : NSString!
    var ActualData = ""
    var captureSession : AVCaptureSession!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    var qrCodeFrameView:UIView!
        override func viewDidLoad() {
        
        var captureSession : AVCaptureSession
        var videoPreviewLayer: AVCaptureVideoPreviewLayer
        var qrCodeFrameView:UIView

        super.viewDidLoad()
            FetchPoints()
            qrCodeFrameView = UIView()
            qrCodeFrameView.layer.borderColor = UIColor.greenColor().CGColor
            qrCodeFrameView.layer.borderWidth = 2
            view.addSubview(qrCodeFrameView)
            view.bringSubviewToFront(qrCodeFrameView)
            
            let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
            
            var error:NSError?
            let input: AnyObject! = AVCaptureDeviceInput.deviceInputWithDevice(captureDevice, error: &error)
            
            if (error != nil) {
                // If any error occurs, simply log the description of it and don't continue any more.
                println("\(error?.localizedDescription)")
                return
            }
            
            // Initialize the captureSession object.
            captureSession = AVCaptureSession()
            // Set the input device on the capture session.
            captureSession.addInput(input as AVCaptureInput)
            
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.//
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            
            // TELL HARDWARE CAMERA THAT DEFAULT DATA INPUT IS QRCODE
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
            
            
            // DYANMICALLY LOAD THE VIDEO CAPTURE ON SCREEN  USING AVCaptureVideoLayer object
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
            videoPreviewLayer.frame = view.layer.bounds
            self.view.layer.addSublayer(videoPreviewLayer)
            
            
            // start video capture and recording by //
            
            captureSession.startRunning()
            self.view.bringSubviewToFront(self.TOTAL)
            //self.view.bringSubviewToFront(Cancel)
            //self.view.bringSubviewToFront(Snap)
        
        

        
          }
    
    
    @IBAction func IncrementP(sender: AnyObject) {
        
        var name : NSString = defaults.stringForKey("usernameKey")!
        
        var amount = pointfield.text
        if (amount.toInt() < 0 ){
            // future version will have alert dialog
            return;
        }
        var request = NSMutableURLRequest(URL: NSURL( string: "http://cmpt275team1.hostoi.com/Earn.php")!)
        
        var session = NSURLSession.sharedSession()
        request.HTTPMethod="POST"
        request.addValue("application/x-www-form-urlencoded",forHTTPHeaderField: "Content-Type")
        var body = "USERID=\(name)&Amount=\(amount)"
        request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding)
        
        
        
        var DataTask = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            
            
            dispatch_async(dispatch_get_main_queue(),{
                self.TOTAL.text = NSString(data: data, encoding: NSUTF8StringEncoding)});

            
            
            
            
            
            
            
            //self.TOTAL.text = NSString(data: data, encoding: NSUTF8StringEncoding)
        })
       
        /*var DataTask = session.dataTaskWithRequest(request) {
            data, response, error in
            
            if(error != nil){
                println("error=\(error)")
                return;
            }
            //self.strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            //println("after add :\(self.strData)")
          
            self.TOTAL.text = NSString(data: data, encoding: NSUTF8StringEncoding)
        }
        */
        DataTask.resume()
        FetchPoints()
        
    }

    
    // Get the Points of User//
    
    func FetchPoints() {
        var name : NSString = defaults.stringForKey("usernameKey")!
      
        
        var request = NSMutableURLRequest(URL: NSURL( string: "http://cmpt275team1.hostoi.com/Fetch.php")!)
        
        var session = NSURLSession.sharedSession()
        request.HTTPMethod="POST"
        request.addValue("application/x-www-form-urlencoded",forHTTPHeaderField: "Content-Type")
        var body = "USERID=\(name)"
        request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding)
        
        var DataTask = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
    
            dispatch_async(dispatch_get_main_queue(),{
                self.TOTAL.text = NSString(data: data, encoding: NSUTF8StringEncoding)});
        })
        
        
        DataTask.resume()
           }

        
        
    
    
    
    
    
    
    
    @IBAction func DecrementP(sender: AnyObject) {
        var name : NSString = defaults.stringForKey("usernameKey")!
        
        var amount = pointfield.text
        if(amount.isEmpty ||  name != defaults.stringForKey("usernameKey")){
            println("not valid input, you are not loggedin");
            return;
            }
        // Future version will have alert dialog
      
        var request = NSMutableURLRequest(URL: NSURL( string: "http://cmpt275team1.hostoi.com/Spend.php")!)
        if (amount.toInt() < 0 ){
            // future version will have alert dialog
            return;
        }
        var session = NSURLSession.sharedSession()
        request.HTTPMethod="POST"
        request.addValue("application/x-www-form-urlencoded",forHTTPHeaderField: "Content-Type")
        var body = "USERID=\(name)&Amount=\(amount)"
        request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding)
        
        
        var DataTask = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            
            dispatch_async(dispatch_get_main_queue(),{
                self.TOTAL.text = NSString(data: data, encoding: NSUTF8StringEncoding)});
        })
        DataTask.resume()
       
        
      
    }
    
    
    
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
        if (metadataObjects == nil || metadataObjects.count == 0 ){
            qrCodeFrameView.frame = CGRectZero
            //ScoreGain.text = " NO QR,Try again"
            return
        }
        
        let metadataObj = metadataObjects[0] as AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObjectTypeQRCode {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObjectForMetadataObject(metadataObj as AVMetadataMachineReadableCodeObject) as AVMetadataMachineReadableCodeObject
            qrCodeFrameView?.frame = barCodeObject.bounds;
            
            if metadataObj.stringValue != nil {
                //ScoreGain.text = metadataObj.stringValue
            }
        }
        return
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toggleSideMenu(sender: AnyObject) {
        toggleSideMenuView()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    // Intialize video capture object and attach to a video capturing device//
    
    
    //Code from www.appcoda.com/qr-code-reader-swift//
    // Technically should run, but unable to test without actual camera//

    
    // HANDLE QR Parsing
    
    /* func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
    
    if (metadataObjects == nil || metadataObjects.count == 0 ){
    qrCodeFrameView.frame = CGRectZero
    ScoreGain.text = " NO QR,Try again"
    return
    }
    
    let metadataObj = metadataObjects[0] as AVMetadataMachineReadableCodeObject
    
    if metadataObj.type == AVMetadataObjectTypeQRCode {
    // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
    let barCodeObject = videoPreviewLayer?.transformedMetadataObjectForMetadataObject(metadataObj as AVMetadataMachineReadableCodeObject) as AVMetadataMachineReadableCodeObject
    qrCodeFrameView?.frame = barCodeObject.bounds;
    
    if metadataObj.stringValue != nil {
    ScoreGain.text = metadataObj.stringValue
    }
    }
    return
    
    } */
    /* Camera functionality - disabled until testable
    var captureSession : AVCaptureSession
    var videoPreviewLayer: AVCaptureVideoPreviewLayer
    var qrCodeFrameView:UIView
    
    
    super.viewDidLoad()
    
    
    // Green box Variables//
    qrCodeFrameView = UIView()
    qrCodeFrameView.layer.borderColor = UIColor.greenColor().CGColor
    qrCodeFrameView.layer.borderWidth = 2
    view.addSubview(qrCodeFrameView)
    view.bringSubviewToFront(qrCodeFrameView)
    
    
    
    
    
    
    
    // Intialize video capture object and attach to a video capturing device//
    
    
    //Code from www.appcoda.com/qr-code-reader-swift//
    // Technically should run, but unable to test without actual camera//
    
    let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
    
    var error:NSError?
    let input: AnyObject! = AVCaptureDeviceInput.deviceInputWithDevice(captureDevice, error: &error)
    
    if (error != nil) {
    // If any error occurs, simply log the description of it and don't continue any more.
    println("\(error?.localizedDescription)")
    return
    }
    
    // Initialize the captureSession object.
    captureSession = AVCaptureSession()
    // Set the input device on the capture session.
    captureSession.addInput(input as AVCaptureInput)
    
    
    // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.//
    let captureMetadataOutput = AVCaptureMetadataOutput()
    captureSession.addOutput(captureMetadataOutput)
    
    // TELL HARDWARE CAMERA THAT DEFAULT DATA INPUT IS QRCODE
    
    // Set delegate and use the default dispatch queue to execute the call back
    captureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
    captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
    
    
    // DYANMICALLY LOAD THE VIDEO CAPTURE ON SCREEN  USING AVCaptureVideoLayer object
    
    videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
    videoPreviewLayer.frame = view.layer.bounds
    self.view.layer.addSublayer(videoPreviewLayer)
    
    
    // start video capture and recording by //
    
    captureSession.startRunning()
    self.view.bringSubviewToFront(ScoreGain)
    self.view.bringSubviewToFront(Cancel)
    self.view.bringSubviewToFront(Snap) */


}
