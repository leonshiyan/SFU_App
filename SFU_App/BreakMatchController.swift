//
//  BreakMatchController.swift
//  SFU_App
//
//  Created by Nethaniel Yuen on 2015-03-20.
//  Copyright (c) 2015 Hugo Cheng. All rights reserved.
//

import UIKit

class BreakMatchController: UIViewController {
    var matrix = Array("000000000000000000000000000000000000000000000000000000000000")
    
    var daymult = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        var colon = 0
       // var matrix = Array("000000000000000000000000000000000000000000000000000000000000")
        for course in courseList {
            //println(course.times)
            
            var intstring : [String] = course.times.componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString: ": -"))
            
            var daystring = course.days.componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString: ", "))
            
            var startime = intstring[0].toInt()
            var endtime = intstring[5].toInt()
            
            
            
           
            
            
            for day in daystring {
                
                
                switch day {
                    
                    
                case "Mo" :
                    
                    self.daymult = 0
                    break;
                    
                case "Tu":
                    self.daymult = 1
                    break;
                    
                case "We":
                    self.daymult = 2
                    break;
                    
                case "Th":
                    self.daymult = 3
                    break;

                case "Fr":
                    self.daymult = 4
                    break;
                    
                default :
                    break;
                    
                    
                }
                
                //Do some computation here
                var start = startime! - 8
                var end = endtime! - 8
                var hourOfClass = endtime! - startime!
                for (var i = 0; i < hourOfClass ; i++)
                {
                self.matrix[daymult*12 + start + i] = "1"
                }

                
                
                
                
                
                
                
                
            }
          
        
            
    }
        let schedule  = "" + self.matrix
        println(schedule)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toggleSideMenu(sender: AnyObject) {
        toggleSideMenuView()
    }
}


