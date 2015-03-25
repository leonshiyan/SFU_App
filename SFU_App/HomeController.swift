//
//  ViewController.swift
//  SFU_App
//
//  Created by Hugo Cheng on 2015-03-03.
//  Copyright (c) 2015 Hugo Cheng. All rights reserved.
//

import UIKit

class HomeController: UITableViewController {
    
    

    @IBOutlet var homeTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Adjust color of table view //
        homeTableView.separatorColor = UIColor(red: (224/255.0), green: (224/255.0), blue: (224/255.0), alpha: 1.0)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

