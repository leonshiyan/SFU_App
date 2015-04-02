// Nethaniel is the best
//  errorMessage.swift
//  SFU_App
//
//  Created by Nethaniel Yuen on 2015-04-02.
//  Copyright (c) 2015 Hugo Cheng. All rights reserved.
//

import Foundation
import UIKit

public class errorMessage {
    
    func outputError(viewController: UIViewController) {
        if(Reachability.isConnectedToNetwork() == true){
            println("Internet connection OK")
            return
        }
        else{
            println("Internet connection FAILED")
            let alertHandler = { (action:UIAlertAction!) -> Void in // Handler to be run when OK
                return self.outputError(viewController)
            }
            let alertController = UIAlertController(title: "Error", message: "No internet connection available", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "Retry", style: .Default, handler: alertHandler)
            alertController.addAction(defaultAction)
            viewController.presentViewController(alertController, animated: true, completion: nil)
        }
    }
}