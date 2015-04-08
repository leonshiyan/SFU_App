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
    
    //@IBOutlet weak var pointfield: UITextField!
    var scannedPoints: Int?
    
    @IBOutlet weak var TOTAL: UILabel!
    @IBOutlet weak var msgLabel: UILabel!
    
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    /*var strData : NSString!
    var ActualData = ""
    var captureSession : AVCaptureSession!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    var qrCodeFrameView:UIView!*/
    override func viewDidLoad() {
        super.viewDidLoad()
        FetchPoints()

        /*var captureSession : AVCaptureSession
        var videoPreviewLayer: AVCaptureVideoPreviewLayer
        var qrCodeFrameView:UIView
        
        */
        // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video
        // as the media type parameter.
        let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        // Get an instance of the AVCaptureDeviceInput class using the previous device object.
        var error:NSError?
        let input: AnyObject! = AVCaptureDeviceInput.deviceInputWithDevice(captureDevice, error: &error)
        
        if (error != nil) {
            // If any error occurs, simply log the description of it and don't continue any more.
            println("\(error?.localizedDescription)")
            return
        }
        super.viewDidLoad()
        FetchPoints()
        // Initialize the captureSession object.
        captureSession = AVCaptureSession()
        // Set the input device on the capture session.
        captureSession?.addInput(input as AVCaptureInput)
        
        // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession?.addOutput(captureMetadataOutput)
        
        // Set delegate and use the default dispatch queue to execute the call back
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
      
        
        // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer)
        
        // Start video capture.
        captureSession?.startRunning()
        
        // Move the message label to the top view
        view.bringSubviewToFront(msgLabel)
        view.bringSubviewToFront(TOTAL)
        
        // Initialize QR Code Frame to highlight the QR code
        qrCodeFrameView = UIView()
        qrCodeFrameView?.layer.borderColor = UIColor.greenColor().CGColor
        qrCodeFrameView?.layer.borderWidth = 2
        view.addSubview(qrCodeFrameView!)
        view.bringSubviewToFront(qrCodeFrameView!)
        
        
        
    }
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects == nil || metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRectZero
            msgLabel.text = "No QR code is detected"
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObjectTypeQRCode {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObjectForMetadataObject(metadataObj as AVMetadataMachineReadableCodeObject) as AVMetadataMachineReadableCodeObject
            qrCodeFrameView?.frame = barCodeObject.bounds;
            
            if metadataObj.stringValue != nil {
                msgLabel.text = metadataObj.stringValue
            }
        }
        let barCodeObject = videoPreviewLayer?.transformedMetadataObjectForMetadataObject(metadataObj as AVMetadataMachineReadableCodeObject) as AVMetadataMachineReadableCodeObject
        
        qrCodeFrameView?.frame = barCodeObject.bounds
        
        // if it  is not nil then increment or decrement depending on QR
        if metadataObj.stringValue != "No QR code is detected" {
            
            if(metadataObj.stringValue.toInt() > 0) {
                IncrementP();
                FetchPoints();
            }
            
            if(metadataObj.stringValue.toInt() < 0 ) {
                DecrementP()
                FetchPoints()
                
            }
            
            
            
            
            
            
            
        }
        return
    }
    
    
    func IncrementP() {
        
        var name : NSString = defaults.stringForKey("usernameKey")!
        
        var amount = msgLabel.text?.toInt()
        println(amount)
        if (amount < 0 ){
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
    
    
    
    
    
    
    
    
    
    func DecrementP() {
        var name : NSString = defaults.stringForKey("usernameKey")!
        
        var amount = msgLabel.text?.toInt()
        if(amount == 0 ||  name != defaults.stringForKey("usernameKey")){
            println("not valid input, you are not loggedin");
            return;
        }
        // Future version will have alert dialog
        
        var request = NSMutableURLRequest(URL: NSURL( string: "http://cmpt275team1.hostoi.com/Spend.php")!)
        if (amount < 0 ){
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
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toggleSideMenu(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    
    
}
