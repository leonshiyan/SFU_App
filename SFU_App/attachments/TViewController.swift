//
//  TViewController.swift
//  SFU_App
//
//  Created by Nethaniel Yuen on 2015-03-05.
//  Copyright (c) 2015 Hugo Cheng. All rights reserved.
//

// Global variable that gets shared to the display screen for bust imes
var search: NSString!
import UIKit

class TViewController: UIViewController {
    @IBOutlet var fav: UIButton!
    // ViewController that takes user input for bus stop number
    @IBOutlet weak var submit: UIButton!
    @IBOutlet weak var input: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
            // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
// Submit button action//
    @IBAction func submit(sender: AnyObject) {
        
        search = input.text
      }
    @IBAction func fav(sender: AnyObject) {
        search = input.text
    }
    
}
