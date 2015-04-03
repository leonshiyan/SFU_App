//
//  BreakMatchController.swift
//  SFU_App
//
//  Created by Nethaniel Yuen on 2015-03-20.
//  Copyright (c) 2015 Hugo Cheng. All rights reserved.
//


func CreateMatrix() ->String {
    for course in courseList {
        //println(course.times)
        var daymult = 0
        var intstring : [String] = course.times.componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString: ": -"))
        
        var daystring = course.days.componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString: ", "))
        
        var startime = intstring[0].toInt()
        var endtime = intstring[5].toInt()
        
        
        
        
        
        
        for day in daystring {
            
            
            switch day {
                
                
            case "Mo" :
                
                daymult = 0
                break;
                
            case "Tu":
                daymult = 1
                break;
                
            case "We":
                daymult = 2
                break;
                
            case "Th":
                daymult = 3
                break;
                
            case "Fr":
                daymult = 4
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
                matrix[daymult*12 + start + i] = "1"
            }
            
            // Convert the array back to the string that used to stored in database
            // let scheduleDB  = "" + self.matrix
            
            
            
            
            
            
            
        }
        
        
        
    }
    let schedule  = "" + matrix
    //println(schedule)
    
    
    return schedule
    
}

import UIKit
 var matrix = Array("000000000000000000000000000000000000000000000000000000000000")
class BreakMatchController: UIViewController {
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
                let date = NSDate()
                let calendar = NSCalendar.currentCalendar()
                let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: date)
                let hour = components.hour
                let minutes = components.minute
                let day = components.day
                var currentTime = hour*100 + minutes
                var timeSlot = 0
                switch currentTime
                {
                case 830...929:
                    timeSlot = 0;
                case 930...1029:
                    timeSlot = 1;
                case 1030...1129:
                    timeSlot = 2;
                case 1130...1229:
                    timeSlot = 3;
                case 1230...1329:
                    timeSlot = 4;
                case 1330...1429:
                    timeSlot = 5;
                case 1430...1529:
                    timeSlot = 6;
                case 1530...1629:
                    timeSlot = 7;
                case 1630...1729:
                    timeSlot = 8;
                case 1730...1829:
                    timeSlot = 9;
                case 1830...1929:
                    timeSlot = 10;
                case 1930...2329:
                    timeSlot = 11;
                default :
                    break
                }
        let dayTimeFormatter = NSDateFormatter()
        dayTimeFormatter.dateFormat = "EEEEEE"
        let dayString = dayTimeFormatter.stringFromDate(date)
        
        
        var daymult = 0
        switch dayString {
        case "Mo" :
            
            daymult = 0
            break;
            
        case "Tu":
            daymult = 1
            break;
            
        case "We":
            daymult = 2
            break;
            
        case "Th":
            daymult = 3
            break;
            
        case "Fr":
            daymult = 4
            break;
            
        default :
            break;
        }

        if(matrix[daymult*12 + timeSlot] == "0")
        {
            println(matrix)
            println("Yes, he is free now")
        }
        else
        {
            println("No, he is not free now")
            
        }
    
}
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toggleSideMenu(sender: AnyObject) {
        toggleSideMenuView()
    }
}


